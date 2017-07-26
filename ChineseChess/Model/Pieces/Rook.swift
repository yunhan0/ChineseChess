//
//  Rook.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class Rook : Piece {
    private var obstacleNumber: Int = 0
    
    override func nextPossibleMoves(boardStates: [[Piece?]]) -> [Vector2] {
        var ret: [Vector2] = []
        
        // The same row
        obstacleNumber = 0
        for _x in stride(from: position.x - 1, through: 0, by: -1) {
            if (obstacleNumber == 1) {
                break
            }
            
            if isValidMove(Vector2(x: _x, y: position.y), boardStates) {
                ret.append(Vector2(x: _x, y: position.y))
            }
        }
        
        obstacleNumber = 0
        for _x in stride(from: position.x + 1, to: Board.rows, by: +1) {
            
            if (obstacleNumber == 1) {
                break
            }
            
            if isValidMove(Vector2(x: _x, y: position.y), boardStates) {
                ret.append(Vector2(x: _x, y: position.y))
            }
            
        }
        
        // The same column
        obstacleNumber = 0
        for _y in stride(from: position.y - 1, through: 0, by: -1) {
            
            if (obstacleNumber == 1) {
                break
            }
            
            if isValidMove(Vector2(x: position.x, y: _y), boardStates) {
                ret.append(Vector2(x: position.x, y: _y))
            }
            
        }
        
        obstacleNumber = 0
        for _y in stride(from: position.y + 1, to: Board.columns, by: +1) {
            
            if (obstacleNumber == 1) {
                break
            }
            
            if isValidMove(Vector2(x: position.x, y: _y), boardStates) {
                ret.append(Vector2(x: position.x, y: _y))
            }
        }
        
        return ret
    }
    
    
    override func isValidMove(_ move: Vector2, _ boardStates: [[Piece?]]) -> Bool {
        if Board.isOutOfBoard(move) {
            return false
        }
        
        if (obstacleNumber >= 1) {
            return false
        }
        
        if let nextstate = boardStates[move.x][move.y] {
            obstacleNumber += 1
            
            if nextstate.owner == self.owner {
                return false
            } else {
                return true
            }
        }
        
        return true
    }
}
