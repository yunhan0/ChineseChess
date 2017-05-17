//
//  Horse.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class Horse : Piece {
    override func isValidMove(_ destinationX: Int, _ destinationY: Int, _ boardStates: [[Piece?]]) -> Bool {
        // if the manhattan distance to target column and row is 3, it might make a "日" shape
        let manhattanDistance = abs(self.locationX - destinationX) + abs(self.locationY - destinationY)
        
        if (manhattanDistance == 3) {
            let boo = self.locationX < destinationX ? (min: self.locationX, max: destinationX) :
                (min: destinationX, max: self.locationX)
            
            let foo = self.locationY < destinationY ? (min: self.locationY, max: destinationY) :
                (min: destinationY, max: self.locationY)
            
            if (foo.max - foo.min == 2) && (boardStates[self.locationX][foo.min + 1] == nil) {
                return true
            }
            
            if (boo.max - boo.min == 2) && (boardStates[boo.min + 1][self.locationY] == nil) {
                return true
            }
            
        }
        return false
    }
}


