//
//  Cannon.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class Cannon : Piece {
    override func isValidMove(_ destinationX: Int, _ destinationY: Int, _ boardStates: [[Piece?]]) -> Bool {
        var obstacleNumbers: Int
        
        // Case 1: The movement happens in the same row
        if (self.locationX == destinationX) {
            
            let distance = abs(self.locationY - destinationY)
            
            if (distance == 1) { // There would not be any obstacles
                obstacleNumbers = 0
            } else {
                let (min, max) = self.locationY > destinationY ? (destinationY, self.locationY) : (self.locationY, destinationY)
                var ret : Int = 0
                
                for i in (min + 1)...(max - 1){
                    if boardStates[self.locationX][i] != nil { // It means there is obstacle pieces on that row
                        ret += 1
                    }
                }
                
                obstacleNumbers = ret
            }
            
        } else if (self.locationY == destinationY) { // Case 2: The movement happens in the same column
            let distance = abs(self.locationX - destinationX)
            
            if (distance == 1) {
                obstacleNumbers = 0
            } else {
                let (min, max) = self.locationX > destinationX ? (destinationX, self.locationX) : (self.locationX, destinationX)
                var ret : Int = 0
                
                for i in (min + 1)...(max - 1) {
                    if boardStates[i][self.locationY] != nil {
                        ret += 1
                    }
                }
                
                obstacleNumbers = ret
            }
        } else {
            return false
        }
        
        if (boardStates[destinationX][destinationY] != nil) {
            if (obstacleNumbers == 1) {
                return true
            }
        } else {
            if (obstacleNumbers == 0) {
                return true
            }
        }
        
        return false
    }
}

