//
//  King.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class King : Piece {
    override func isValidMove(_ destinationX: Int, _ destinationY: Int, _ boardStates: [[Piece?]]) -> Bool {
        let manhattanDistance = abs(self.locationX - destinationX) + abs(self.locationY - destinationY)
        
        if (manhattanDistance == 1) {
            if (Board.isForbidden(x: destinationX, y: destinationY)) {
                return true
            }
        }
        
        return false
    }
}
