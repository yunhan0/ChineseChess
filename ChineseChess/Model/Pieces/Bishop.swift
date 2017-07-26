//
//  Bishop.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class Bishop : Piece {
    override func nextPossibleMoves(boardStates: [[Piece?]]) -> [Vector2] {
        let possibleMoves: [Vector2] = [
            Vector2(x: position.x - 2, y: position.y - 2),
            Vector2(x: position.x - 2, y: position.y + 2),
            Vector2(x: position.x + 2, y: position.y - 2),
            Vector2(x: position.x + 2, y: position.y + 2)
        ]
        
        var ret: [Vector2] = []
        
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
        
        // Bishop can not accross the river on the board
        if ( Board.getTerritoryOwner(x: move.x) != self.owner) {
            return false
        }

        let minrow = min(self.position.x, move.x)
        let mincol = min(self.position.y, move.y)
            
        if (boardStates[minrow + 1][mincol + 1] == nil) {
            return true
        }

        return false
    }
}
