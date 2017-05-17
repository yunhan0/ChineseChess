//
//  Bishop.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class Bishop : Piece {
    override func isValidMove(_ destinationX: Int, _ destinationY: Int, _ boardStates: [[Piece?]]) -> Bool {
        // Bishop can not accross the river on the board
        if ( Board.getTerritoryOwner(x: destinationX) != self.owner) {
            return false
        }
        
        if abs(self.locationX - destinationX) == 2 && abs(self.locationY - destinationY) == 2 {
            let minrow = min(self.locationX, destinationX)
            let mincol = min(self.locationY, destinationY)
            
            if (boardStates[minrow + 1][mincol + 1] == nil) {
                return true
            }
        
        }
        
        return false
    }
}
