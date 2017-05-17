//
//  Board.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/15/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

enum Player {
    case Black
    case Red
}

class Board {
    // Chinese Chess has 10 rows and 9 columns
    public static let rows : Int = 10
    public static let columns : Int = 9;
    public static let riverRow : Int = 5;
    
    public static var initialBoardStates : [[Piece?]] = Board.initBoardStates()
    
    private static func initBoardStates() -> [[Piece?]] {
        return initPiecesStates()
    }
    
    public static func isForbidden(x: Int, y: Int) -> Bool {
        if (y >= 3 && y <= 5) {
            if ( (x >= 0 && x <= 2) || (x >= 7 && x <= 9) ) {
                return true
            }
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
        board[0][0] = Rook(owner: .Black, locationX: 0, locationY: 0)
        board[0][1] = Horse(owner: .Black, locationX: 0, locationY: 1)
        board[0][2] = Bishop(owner: .Black, locationX: 0, locationY: 2)
        board[0][3] = Guard(owner: .Black, locationX: 0, locationY: 3)
        board[0][4] = King(owner: .Black, locationX: 0, locationY: 4)
        board[0][5] = Guard(owner: .Black, locationX: 0, locationY: 5)
        board[0][6] = Bishop(owner: .Black, locationX: 0, locationY: 6)
        board[0][7] = Horse(owner: .Black, locationX: 0, locationY: 7)
        board[0][8] = Rook(owner: .Black, locationX: 0, locationY: 8)
        board[2][1] = Cannon(owner: .Black, locationX: 2, locationY: 1)
        board[2][7] = Cannon(owner: .Black, locationX: 2, locationY: 7)
        board[3][0] = Pawn(owner: .Black, locationX: 3, locationY: 0)
        board[3][2] = Pawn(owner: .Black, locationX: 3, locationY: 2)
        board[3][4] = Pawn(owner: .Black, locationX: 3, locationY: 4)
        board[3][6] = Pawn(owner: .Black, locationX: 3, locationY: 6)
        board[3][8] = Pawn(owner: .Black, locationX: 3, locationY: 8)
        
        // Red Player
        board[6][0] = Pawn(owner: .Red, locationX: 6, locationY: 0)
        board[6][2] = Pawn(owner: .Red, locationX: 6, locationY: 2)
        board[6][4] = Pawn(owner: .Red, locationX: 6, locationY: 4)
        board[6][6] = Pawn(owner: .Red, locationX: 6, locationY: 6)
        board[6][8] = Pawn(owner: .Red, locationX: 6, locationY: 8)
        board[7][1] = Cannon(owner: .Red, locationX: 7, locationY: 1)
        board[7][7] = Cannon(owner: .Red, locationX: 7, locationY: 7)
        board[9][0] = Rook(owner: .Red, locationX: 9, locationY: 0)
        board[9][1] = Horse(owner: .Red, locationX: 9, locationY: 1)
        board[9][2] = Bishop(owner: .Red, locationX: 9, locationY: 2)
        board[9][3] = Guard(owner: .Red, locationX: 9, locationY: 3)
        board[9][4] = King(owner: .Red, locationX: 9, locationY: 4)
        board[9][5] = Guard(owner: .Red, locationX: 9, locationY: 5)
        board[9][6] = Bishop(owner: .Red, locationX: 9, locationY: 6)
        board[9][7] = Horse(owner: .Red, locationX: 9, locationY: 7)
        board[9][8] = Rook(owner: .Red, locationX: 9, locationY: 8)
        
        return board
    }

}
