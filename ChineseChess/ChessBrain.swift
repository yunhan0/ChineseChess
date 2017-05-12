//
//  ChessBrain.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/10/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation
import UIKit

class ChessBrain {
    private var pending: PieceView?
    private var isAbleToMove: Bool = false
    private var currentPlayer = Rules.FirstPlayer
    private var gameStates = Rules.GameStates
    
    func setPiece(piece: PieceView) {
        if let firstSelection = pending {
            /* Do nothing if the second piece selection equals the first piece
             * or they belong to the same player
             */
            if(firstSelection == piece || firstSelection.player == piece.player) {
                firstSelection.removeBorder()
                pending = nil
                return
            }
            performMovement(coordinate: piece.center, piece.row, piece.column)
            
            if (isAbleToMove) {
                eatPiece(food: piece)
                currentPlayer = turnPlayer(player: currentPlayer)
            }
        } else {
            if(piece.player == currentPlayer) {
                piece.setBorder(width: 2.0, color: UIColor.white.cgColor)
                pending = piece
            }
        }
    }
    
    func performMovement(coordinate: CGPoint, _ row: Int, _ column: Int) {
        isAbleToMove = false
        if let piece = pending {
            switch piece.pieceType {
            case .Rook:
                if (piece.row == row || piece.column == column) {
                    isAbleToMove = true
                }
            case .Cannon:
                if (piece.row == row || piece.column == column) {
                    isAbleToMove = true
                }
            case .Soldier:
                let manhattanDistance = abs(piece.row - row) + abs(piece.column - column)
                if (manhattanDistance == 1 && piece.row + 1 == row) {
                    isAbleToMove = true
                }
            case .Pawn:
                let manhattanDistance = abs(piece.row - row) + abs(piece.column - column)
                if (manhattanDistance == 1 && piece.row - 1 == row) {
                    isAbleToMove = true
                }
            case .Horse:
                // if the manhattan distance to target column and row is 3, it makes a "日" shape
                let manhattanDistance = abs(piece.row - row) + abs(piece.column - column)
                if (manhattanDistance == 3) {
                    isAbleToMove = true
                }
            case .Bishop:
                if (abs(piece.row - row) == 2 && abs(piece.column - column) == 2) {
                    isAbleToMove = true
                }
            case .Guard:
                if (abs(piece.row - row) == 1 && abs(piece.column - column) == 1) {
                    isAbleToMove = true
                }
            case .King, .General:
                let manhattanDistance = abs(piece.row - row) + abs(piece.column - column)
                if (manhattanDistance == 1) {
                    isAbleToMove = true
                }
            }
            
            if (isAbleToMove) {
                gameStates[piece.row][piece.column] = piece.row < Rules.SideRows ? 0 : 1
                gameStates[row][column] = piece.pieceType
                
                piece.center = coordinate
                piece.setLocation(row: row, col: column)
                currentPlayer = turnPlayer(player: currentPlayer)
            }
            
            piece.removeBorder()
            pending = nil
        }
    }
    
    func eatPiece(food: PieceView) {
        food.isHidden = true
    }
    
    func turnPlayer(player: Player) -> Player {
        let ret: Player
        switch player {
        case .Red: ret = .Black
        case .Black: ret = .Red
        }
        return ret
    }
}
