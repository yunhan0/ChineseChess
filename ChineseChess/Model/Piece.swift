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
    
    // Helper property: pid
    public var pid: Int
    static var count: Int = 0
    
    private static func generatePid() -> Int {
        count += 1
        return count
    }
    
    // Constructor
    init(owner: Player, locationX: Int, locationY: Int) {
        self.owner = owner
        self.locationX = locationX
        self.locationY = locationY
        self.pid = Piece.generatePid()
    }
    
    func isValidMove(_ destinationX: Int, _ destinationY: Int, _ boardStates: [[Piece?]]) -> Bool {
        return false
    }
    
    func setLocation(x: Int, y: Int) {
        self.locationX = x
        self.locationY = y
    }
    
}

