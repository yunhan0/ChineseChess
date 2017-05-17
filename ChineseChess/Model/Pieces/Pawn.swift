//
//  Pawn.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class Pawn : Piece {
    override func isValidMove(_ destinationX: Int, _ destinationY: Int, _ boardStates: [[Piece?]]) -> Bool {
        let manhattanDistance = abs(self.locationX - destinationX) + abs(self.locationY - destinationY)
        
        if (manhattanDistance == 1) {
            if (Board.getTerritoryOwner(x: destinationX) == self.owner) {
                if (self.owner == .Red && self.locationX - 1 == destinationX) {
                    return true
                }
                
                if (self.owner == .Black && self.locationX + 1 == destinationX) {
                    return true
                }
            } else {
                if (self.owner == .Red && destinationX <= self.locationX) {
                    return true
                }
                
                if (self.owner == .Black && destinationX >= self.locationX) {
                    return true
                }
            }
        }
        return false
    }
}
