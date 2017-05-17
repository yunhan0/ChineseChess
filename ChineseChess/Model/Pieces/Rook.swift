//
//  Rook.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class Rook : Piece {
    override func isValidMove(_ destinationX: Int, _ destinationY: Int, _ boardStates: [[Piece?]]) -> Bool {

        // Case 1: The movement happens in the same row
        if (self.locationX == destinationX) {
            let distance = abs(self.locationY - destinationY)
            
            if (distance == 1) { // There would not be any obstacles
                return true
            } else {
                let (min, max) = self.locationY > destinationY ? (destinationY, self.locationY) : (self.locationY, destinationY)
                
                for i in (min + 1)...(max - 1){
                    if boardStates[self.locationX][i] != nil { // It means there is obstacle pieces on that row
                        return false
                    }
                }
                return true
            }
            
        } else if (self.locationY == destinationY) { // Case 2: The movement happens in the same column
            let distance = abs(self.locationX - destinationX)
            
            if (distance == 1) {
                return true
            } else {
                let (min, max) = self.locationX > destinationX ? (destinationX, self.locationX) : (self.locationX, destinationX)
                
                for i in (min + 1)...(max - 1) {
                    if boardStates[i][self.locationY] != nil {
                        return false
                    }
                }
                
                return true
            }
        } else { // Other cases
            return false
        }
    }
}
