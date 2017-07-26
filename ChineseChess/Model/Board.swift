//
//  Board.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class Board {
    // Chinese Chess has 10 rows and 9 columns
    public static let rows : Int = 10
    public static let columns : Int = 9;
    public static let riverRow : Int = 5;
    
    public static var initialBoardStates : [[Piece?]] = Board.initPiecesStates()
    
    public static func isForbidden(position: Vector2) -> Bool {
        if position.y >= 3 && position.y <= 5 {
            if (position.x >= 0 && position.x <= 2) || (position.x >= 7 && position.x <= 9) {
                return true;
            }
        }
        return false
    }
    
    public static func isOutOfBoard(_ position: Vector2) -> Bool {
        if (position.x < 0) {
            return true
        }
        
        if (position.x >= Board.rows) {
            return true
        }
        
        if (position.y < 0) {
            return true
        }
        
        if (position.y >= Board.columns) {
            return true
        }
        
        return false
    }
    
    public static func getTerritoryOwner(x: Int) -> Player {
        if (x < riverRow) {
            return .Black
        } else {
            return .Red
        }
    }
    
    /*
     Each player starts the game with these pieces:
     1 king (or general),
     2 guards (or advisors),
     2 elephants (or bishops),
     2 knights (or horses),
     2 rooks (or chariots),
     2 cannons and 5 pawns (or soldiers).
     */
    
    private static func initPiecesStates() -> [[Piece?]] {
        // Initialize a board and populate with nil
        
        var board = [[Piece?]](
            repeating: [Piece?] (repeating: nil, count: Board.columns),
            count: Board.rows)
        
        // Black Player
        board[0][0] = Rook(owner: .Black, position: Vector2(x: 0, y: 0))
        board[0][1] = Horse(owner: .Black, position: Vector2(x: 0, y: 1))
        board[0][2] = Bishop(owner: .Black, position: Vector2(x: 0, y: 2))
        board[0][3] = Guard(owner: .Black, position: Vector2(x: 0, y: 3))
        board[0][4] = King(owner: .Black, position: Vector2(x: 0, y: 4))
        board[0][5] = Guard(owner: .Black, position: Vector2(x: 0, y: 5))
        board[0][6] = Bishop(owner: .Black, position: Vector2(x: 0, y: 6))
        board[0][7] = Horse(owner: .Black, position: Vector2(x: 0, y: 7))
        board[0][8] = Rook(owner: .Black, position: Vector2(x: 0, y: 8))
        board[2][1] = Cannon(owner: .Black, position: Vector2(x: 2, y: 1))
        board[2][7] = Cannon(owner: .Black, position: Vector2(x: 2, y: 7))
        board[3][0] = Pawn(owner: .Black, position: Vector2(x: 3, y: 0))
        board[3][2] = Pawn(owner: .Black, position: Vector2(x: 3, y: 2))
        board[3][4] = Pawn(owner: .Black, position: Vector2(x: 3, y: 4))
        board[3][6] = Pawn(owner: .Black, position: Vector2(x: 3, y: 6))
        board[3][8] = Pawn(owner: .Black, position: Vector2(x: 3, y: 8))
        
        // Red Player
        board[6][0] = Pawn(owner: .Red, position: Vector2(x: 6, y: 0))
        board[6][2] = Pawn(owner: .Red, position: Vector2(x: 6, y: 2))
        board[6][4] = Pawn(owner: .Red, position: Vector2(x: 6, y: 4))
        board[6][6] = Pawn(owner: .Red, position: Vector2(x: 6, y: 6))
        board[6][8] = Pawn(owner: .Red, position: Vector2(x: 6, y: 8))
        board[7][1] = Cannon(owner: .Red, position: Vector2(x: 7, y: 1))
        board[7][7] = Cannon(owner: .Red, position: Vector2(x: 7, y: 7))
        board[9][0] = Rook(owner: .Red, position: Vector2(x: 9, y: 0))
        board[9][1] = Horse(owner: .Red, position: Vector2(x: 9, y: 1))
        board[9][2] = Bishop(owner: .Red, position: Vector2(x: 9, y: 2))
        board[9][3] = Guard(owner: .Red, position: Vector2(x: 9, y: 3))
        board[9][4] = King(owner: .Red, position: Vector2(x: 9, y: 4))
        board[9][5] = Guard(owner: .Red, position: Vector2(x: 9, y: 5))
        board[9][6] = Bishop(owner: .Red, position: Vector2(x: 9, y: 6))
        board[9][7] = Horse(owner: .Red, position: Vector2(x: 9, y: 7))
        board[9][8] = Rook(owner: .Red, position: Vector2(x: 9, y: 8))

        return board
    }

}
