//
//  Pawn.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class Pawn : Piece {
    override func nextPossibleMoves(boardStates: [[Piece?]]) -> [Vector2] {
        let possibleMoves: [Vector2] = [
            Vector2(x: position.x + 1, y: position.y),
            Vector2(x: position.x - 1, y: position.y),
            Vector2(x: position.x, y: position.y + 1),
            Vector2(x: position.x, y: position.y - 1)
        ]
        
        var ret : [Vector2] = []
        
        for _move in possibleMoves {
            if isValidMove(_move, boardStates) {
                ret.append(_move)
            }
        }
        
        return ret
    }
    
    override func isValidMove(_ move: Vector2, _ boardStates: [[Piece?]]) -> Bool {
        if Board.isOutOfBoard(move) {
            return false
        }
        
        let nextState = boardStates[move.x][move.y]

        if nextState != nil {
            if nextState?.owner == self.owner {
                return false
            }
        }
        
        if (Board.getTerritoryOwner(x: move.x) == self.owner) {
            if (self.owner == .Red && position.x - 1 == move.x) {
                return true
            }
            
            if (self.owner == .Black && position.x + 1 == move.x) {
                return true
            }
        } else {
            if (self.owner == .Red && move.x <= position.x) {
                return true
            }
            
            if (self.owner == .Black && move.x >= position.x) {
                return true
            }
        }
        
        return false
    }
}
