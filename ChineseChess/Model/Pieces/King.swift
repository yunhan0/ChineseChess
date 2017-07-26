//
//  King.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class King : Piece {
    override func nextPossibleMoves(boardStates: [[Piece?]]) -> [Vector2] {
        // King can move 1 step in four directions.
        let possibleMoves: [Vector2] = [
            Vector2(x: position.x + 1, y: position.y),
            Vector2(x: position.x - 1, y: position.y),
            Vector2(x: position.x, y: position.y + 1),
            Vector2(x: position.x, y: position.y - 1)]
        
        var ret : [Vector2] = []
        
        for _move in possibleMoves {
            if isValidMove(_move, boardStates) {
                ret.append(_move)
            }
        }
        
        return ret
    }
    
    override func isValidMove(_ move: Vector2, _ boardStates: [[Piece?]]) -> Bool {
        // King can only move inside forbidden area
        if !Board.isForbidden(position: move) {
            return false
        }
        
        let nextState = boardStates[move.x][move.y]
        
        if nextState != nil {
            if nextState?.owner == self.owner {
                return false
            }
        }
        
        return true
    }
}
