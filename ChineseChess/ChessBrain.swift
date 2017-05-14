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
    private var isAbleToMove = false
    private var currentPlayer = Rules.FirstPlayer
    private var gameStates = Rules.GameStates
    public var winner : Player? = nil
    
    func setPiece(piece: PieceView) {
        if (winner != nil) { return }
        
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
                let distance: Int, obstacleNumbers: Int
                
                if (piece.row == row) {
                    distance = abs(piece.column - column)
                    obstacleNumbers = distance == 1 ?
                        0 : getObstacleNumbers(a: piece.column, b: column, rowStates: gameStates[row])
                } else if (piece.column == column) {
                    distance = abs(piece.row - row)
                    obstacleNumbers = distance == 1 ?
                        0 : getObstacleNumbers(a: piece.row, b: row, columnNumber: column)
                } else {
                    break
                }
                
                if (obstacleNumbers == 0) { isAbleToMove = true }
            case .Cannon:
                let distance: Int, obstacleNumbers: Int
                
                if (piece.row == row) {
                    distance = abs(piece.column - column)
                    obstacleNumbers = distance == 1 ?
                        0 : getObstacleNumbers(a: piece.column, b: column, rowStates: gameStates[row])
                } else if (piece.column == column) {
                    distance = abs(piece.row - row)
                    obstacleNumbers = distance == 1 ?
                        0 : getObstacleNumbers(a: piece.row, b: row, columnNumber: column)
                } else {
                    break
                }

                if (gameStates[row][column] != nil) {
                    if (obstacleNumbers == 1) { isAbleToMove = true }
                } else {
                    if (obstacleNumbers == 0) { isAbleToMove = true }
                }
            case .Soldier:
                let manhattanDistance = abs(piece.row - row) + abs(piece.column - column)
                if (manhattanDistance == 1) {
                    // Soldier is in its own territory, it can only move forward
                    if (Board.getTerritoryOwner(row: row) == piece.player) {
                        if (piece.row + 1 == row) {
                            isAbleToMove = true
                        }
                    } else {
                        // Soldier is in the other side, it can move forward, left, and right but never go back
                        if (row >= piece.row) {
                            isAbleToMove = true
                        }
                    }
                }
            case .Pawn:
                let manhattanDistance = abs(piece.row - row) + abs(piece.column - column)
                if (manhattanDistance == 1) {
                    if (Board.getTerritoryOwner(row: row) == piece.player) {
                        if (piece.row - 1 == row) {
                            isAbleToMove = true
                        }
                    } else {
                        if (row <= piece.row) {
                            isAbleToMove = true
                        }
                    }
                }
            case .Horse:
                // if the manhattan distance to target column and row is 3, it makes a "日" shape
                let manhattanDistance = abs(piece.row - row) + abs(piece.column - column)
                if (manhattanDistance == 3) {
                    let foo = piece.column < column ?
                        (min: piece.column, max: column) : (min: column, max: piece.column)
                    let boo = piece.row < row ?
                        (min: piece.row, max: row) : (min: row, max: piece.row)
                    
                    if((foo.max - foo.min == 2) && gameStates[piece.row][foo.min+1] == nil) {
                        isAbleToMove = true
                    }
                    
                    if ((boo.max - boo.min == 2) && gameStates[boo.min+1][piece.column] == nil) {
                        isAbleToMove = true
                    }
                }
            case .Bishop:
                // Todo: Bishop can not accross the river on the board
                if (Board.getTerritoryOwner(row: row) != piece.player) {
                    break
                }
                
                if (abs(piece.row - row) == 2 && abs(piece.column - column) == 2) {
                    // get the min column between column and destination column
                    let foo = piece.column < column ? piece.column : column
                    // get the min row between row and destination row
                    let boo = piece.row < row ? piece.row : row
                    
                    if (gameStates[boo+1][foo+1] == nil) {
                        isAbleToMove = true
                    }
                }
            case .Guard:
                if (abs(piece.row - row) == 1 && abs(piece.column - column) == 1) {
                    // Guard can only move inside King's island
                    if (Board.isForbidden(row: row, col: column)) {
                        isAbleToMove = true
                    }
                }
            case .King, .General:
                let manhattanDistance = abs(piece.row - row) + abs(piece.column - column)
                if (manhattanDistance == 1) {
                    
                    // King and General can only move inside its island
                    if (Board.isForbidden(row: row, col: column)) {
                        isAbleToMove = true
                    }
                }
            }
            
            if (isAbleToMove) {
                // Update gamestates
                gameStates[piece.row][piece.column] = nil
                gameStates[row][column] = piece.pieceType
                
                // Reposition piece
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
        if (food.pieceType == .King) {
            winner = .Red
        }
        
        if (food.pieceType == .General) {
            winner = .Black
        }
    }
    
    func turnPlayer(player: Player) -> Player {
        let ret : Player = (player == .Red) ? .Black : .Red
        return ret
    }
    
    func getObstacleNumbers(a: Int, b: Int, rowStates: [Piece?]? = nil, columnNumber: Int? = nil) -> Int {
        var ret = 0
        let (min, max) = a > b ? (b, a) : (a, b)
        
        // Get one row obstacles
        if let source = rowStates {
            for i in (min + 1)...(max - 1) {
                if (source[i] != nil) {
                    ret += 1
                }
            }
        }
        
        // Get one column obstacles
        if let column = columnNumber {
            for i in (min + 1)...(max - 1) {
                if (gameStates[i][column] != nil) {
                    ret += 1
                }
            }
        }
        return ret
    }
    
    func replay() {
        if let piece = pending {
            piece.removeBorder()
        }
        pending = nil
        
        isAbleToMove = false
        currentPlayer = Rules.FirstPlayer
        gameStates = Rules.GameStates
        winner = nil
    }
}
