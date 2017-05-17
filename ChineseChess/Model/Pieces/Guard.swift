//
//  Guard.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class Guard : Piece {
    override func isValidMove(_ destinationX: Int, _ destinationY: Int, _ boardStates: [[Piece?]]) -> Bool {
        if abs(self.locationX - destinationX) == 1 && abs(self.locationY - destinationY) == 1 {
            
            // Guard can only move inside forbidden area
            if (Board.isForbidden(x: destinationX, y: destinationY)) {
                return true
            }
        }
        return false
    }
}
