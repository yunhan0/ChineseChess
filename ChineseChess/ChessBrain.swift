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
                if (piece.row == row) {
                    let columnDistance = abs(piece.column - column)
                    if(columnDistance == 1) {
                        isAbleToMove = true
                    }

                    if(columnDistance > 1 &&
                        getObstacleNumbers(a: piece.column, b: column, rowStates: gameStates[row]) == 0) {
                        isAbleToMove = true
                    }
                }
                
                if (piece.column == column) {
                    let rowDistance = abs(piece.row - row)
                    if (rowDistance == 1) {
                        isAbleToMove = true
                    }

                    if (rowDistance > 1 && getObstacleNumbers(a: piece.row, b: row, columnNumber: column) == 0) {
                        isAbleToMove = true
                    }
                }
            case .Cannon:
                if (piece.row == row || piece.column == column) {
                    isAbleToMove = true
                }
            case .Soldier:
                let manhattanDistance = abs(piece.row - row) + abs(piece.column - column)
                if (manhattanDistance == 1) {
                    let nextState = gameStates[row][column]
                    
                    // If soldier is in its own territory, it can only move forward
                    if(Utility.isEqual(type: Int.self, a: nextState, b: 0) == true && piece.row + 1 == row) {
                        isAbleToMove = true
                        break
                    }
                    
                    // If soldier is in the other side, it can move forward, left, and right
                    if(Utility.isEqual(type: Int.self, a: nextState, b: 1) == true) {
                        isAbleToMove = true
                    }
                }
            case .Pawn:
                let manhattanDistance = abs(piece.row - row) + abs(piece.column - column)
                if (manhattanDistance == 1) {
                    let nextState = gameStates[row][column]
                    
                    if(Utility.isEqual(type: Int.self, a: nextState, b: 1) == true && piece.row - 1 == row) {
                        isAbleToMove = true
                        break
                    }
                    
                    if(Utility.isEqual(type: Int.self, a: nextState, b: 0) == true) {
                        isAbleToMove = true
                    }
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
                    let nextState = gameStates[row][column]
                    
                    // Guard can only move inside King's island
                    if(Utility.isEqual(type: Int.self, a: nextState, b: 2) == true) {
                        isAbleToMove = true
                    }
                }
            case .King, .General:
                let manhattanDistance = abs(piece.row - row) + abs(piece.column - column)
                if (manhattanDistance == 1) {
                    let nextState = gameStates[row][column]
                    
                    // King and General can only move inside its island
                    if(Utility.isEqual(type: Int.self, a: nextState, b: 2) == true) {
                        isAbleToMove = true
                    }
                }
            }
            
            if (isAbleToMove) {
                updateGameStates(origin: (row: piece.row, column: piece.column),
                                 destination: (row: row, column: column),
                                 piece: piece.pieceType)
                
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
    
    func getObstacleNumbers(a: Int, b: Int, rowStates: [Any]? = nil, columnNumber: Int? = nil) -> Int {
        var ret = 0
        let (min, max) = a > b ? (b, a) : (a, b)
        
        // Get one row obstacles
        if let source = rowStates {
            for i in (min + 1)...(max - 1) {
                if source[i] is Piece {
                    ret += 1
                }
            }
        }
        
        // Get one column obstacles
        if let column = columnNumber {
            for i in (min + 1)...(max - 1) {
                if gameStates[i][column] is Piece {
                    ret += 1
                }
            }
        }
        return ret
    }
    
    func updateGameStates(origin: (row: Int, column: Int), destination: (row: Int, column: Int), piece: Piece) {
        if ((0...2 ~= origin.row && 3...5 ~= origin.column) || (
            7...9 ~= origin.row && 3...5 ~= origin.column)) {
            gameStates[origin.row][origin.column] = 2
        } else {
            gameStates[origin.row][origin.column] = origin.row < Rules.SideRows ? 0 : 1
        }
        gameStates[destination.row][destination.column] = piece
    }
}
