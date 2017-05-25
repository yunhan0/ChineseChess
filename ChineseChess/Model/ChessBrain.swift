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
            
            if checkMovementAvailability(destinationX: piece.locationX, destinationY: piece.locationY) {
                eatPiece(food: piece)
            }
  
        } else {
            if (piece.owner == currentPlayer) {
                pending = piece
            }
        }
    }
    
    public func checkMovementAvailability(destinationX: Int, destinationY: Int) -> Bool {
        if let piece = pending {
            if piece.isValidMove(destinationX, destinationY, gameStates) {
                // Update gamestates
                gameStates[piece.locationX][piece.locationY] = nil
                gameStates[destinationX][destinationY] = piece
                piece.setLocation(x: destinationX, y: destinationY)
                
                // Next player's turn
                currentPlayer = turnPlayer(player: currentPlayer)
                
                pending = nil
                return true
            }
        }

        return false
    }
    
    private func eatPiece(food: Piece) {
        food.setLocation(x: -1, y: -1)
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
        
        for i in (0...Board.rows - 1) {
            for j in (0...Board.columns - 1) {
                if let piece = gameStates[i][j] {
                    piece.setLocation(x: i, y: j)
                }
            }
        }
    }
}
