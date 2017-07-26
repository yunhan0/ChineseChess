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
    
    // Record the current position/coorditate of the piece in the board matrix
    public var position: Vector2
    
    // The status of the piece
    public var status: PieceStatus
    
    // Helper property: pid
    public var pid: Int
    static var count: Int = 0
    
    private static func generatePid() -> Int {
        count += 1
        return count
    }
    
    // Constructor
    init(owner: Player, position: Vector2) {
        self.owner = owner
        self.position = position
        self.status = .Alive
        self.pid = Piece.generatePid()
    }
    
    public func setPosition(_ position: Vector2) {
        self.position = position
    }
    
    public func nextPossibleMoves(boardStates: [[Piece?]]) -> [Vector2] {
        return []
    }

    func isValidMove(_ move: Vector2, _ boardStates: [[Piece?]]) -> Bool {
        return false
    }  
}

