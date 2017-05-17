//
//  Piece.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class Piece {
    // The owner of the piece
    public var owner: Player
    
    // Record the current location of the piece in the board matrix
    public var locationX: Int
    public var locationY: Int
    
    // Constructor
    init(owner: Player, locationX: Int, locationY: Int) {
        self.owner = owner
        self.locationX = locationX
        self.locationY = locationY
    }
    
    func isValidMove(_ destinationX: Int, _ destinationY: Int, _ boardStates: [[Piece?]]) -> Bool {
        return false
    }
    
    func setLocation(x: Int, y: Int) {
        self.locationX = x
        self.locationY = y
    }
    
}
