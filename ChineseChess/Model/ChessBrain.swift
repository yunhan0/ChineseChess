//
//  ChessBrain.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

// UI independent model

class ChessBrain {
    public var pending : Piece?
    private var currentPlayer : Player = .Red // Red player is the first one to play
    public var gameStates = Board.initialBoardStates
    public var winner : Player?
    
    public func setPiece(piece: Piece) {
        
        if (winner != nil) { return }
        
        if let firstSelection = pending {
            /* If the second piece selection belongs to 
             * the same player with the first piece, set pending piece to the
             * second one.
             */
            if ( firstSelection.owner == piece.owner ) {
                pending = piece
                return
            }
            
            if checkMovementAvailability(destination: piece.position) {
                eatPiece(food: piece)
            }

        } else {
            if (piece.owner == currentPlayer) {
                pending = piece
            }
        }
    }
    
    public func checkMovementAvailability(destination: Vector2) -> Bool {
        if let piece = pending {
            let nextPossibleMoves = piece.nextPossibleMoves(boardStates: gameStates)
            
            if nextPossibleMoves.contains(where: {$0 == destination}) {
                // Update gamestates
                gameStates[piece.position.x][piece.position.y] = nil
                gameStates[destination.x][destination.y] = piece
                piece.setPosition(x: destination.x, y: destination.y)
                
                // Next player's turn
                currentPlayer = turnPlayer(player: currentPlayer)
                
                pending = nil
                return true
            }
        }
        
        return false
    }
    
    private func eatPiece(food: Piece) {
        food.deathPenalty()
        
        if food is King {
            if (food.owner == .Black) {
                winner = .Red
            } else {
                winner = .Black
            }
        }
    }
    
    private func turnPlayer(player: Player) -> Player {
        
        if (player == .Red) {
            return .Black
        } else {
            return .Red
        }
    }
    
    // Reset everything
    func replay() {
        
        pending = nil
        currentPlayer = .Red
        gameStates = Board.initialBoardStates
        winner = nil
        
        for i in (0 ..< Board.rows) {
            for j in (0 ..< Board.columns) {
                if let piece = gameStates[i][j] {
                    piece.setPosition(x: i, y: j)
                }
            }
        }
    }
}
