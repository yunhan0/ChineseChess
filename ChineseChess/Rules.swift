//
//  Rules.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/11/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation
import UIKit

enum Player {
    case Black
    case Red
}

enum Piece {
    case King
    case Guard
    case Bishop
    case Horse
    case Rook
    case Cannon
    case Soldier
    case General
    case Pawn
}

class Rules {
    // Chinese Chess board has 9 rows and 8 columns
    static let BoardRows: CGFloat = 9
    static let BoardColumns: CGFloat = 8
    
    // Each player got 5 rows as initial territory
    static let SideRows: Int = 5
    
    // As tradition, red player will be the first one to move the piece
    static let FirstPlayer: Player = .Red
    
    static var GameStates : [[Any]] {
        return BlackPieces + RedPieces
    }
    
    static var BlackPieces : [[Any]] {
        return initBlackPieces()
    }
    
    
    static var RedPieces : [[Any]] {
        return initRedPieces()
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
    static func initBlackPieces() -> [[Any]] {
        // Mark black player territory as 0
        var states = [[Any]](
            repeating: [Any](repeating: 0, count: Int(Rules.BoardColumns) + 1),
            count: SideRows
        )
        
        // Mark King and Guard's territory as 2
        for i in 0...2 {
            for j in 3...5 {
                states[i][j] = 2
            }
        }
        
        states[0][0] = Piece.Rook
        states[0][1] = Piece.Horse
        states[0][2] = Piece.Bishop
        states[0][3] = Piece.Guard
        states[0][4] = Piece.King
        states[0][5] = Piece.Guard
        states[0][6] = Piece.Bishop
        states[0][7] = Piece.Horse
        states[0][8] = Piece.Rook
        states[2][1] = Piece.Cannon
        states[2][7] = Piece.Cannon
        states[3][0] = Piece.Soldier
        states[3][2] = Piece.Soldier
        states[3][4] = Piece.Soldier
        states[3][6] = Piece.Soldier
        states[3][8] = Piece.Soldier
        
        return states
    }
    
    static func initRedPieces() -> [[Any]] {
        // Mark red player territory as 1
        var states = [[Any]](
            repeating: [Any](repeating: 1, count: Int(Rules.BoardColumns) + 1),
            count: SideRows
        )
        
        // Mark General and Guard's territory as 2
        for i in 2...4 {
            for j in 3...5 {
                states[i][j] = 2
            }
        }
        
        states[1][0] = Piece.Pawn
        states[1][2] = Piece.Pawn
        states[1][4] = Piece.Pawn
        states[1][6] = Piece.Pawn
        states[1][8] = Piece.Pawn
        states[2][1] = Piece.Cannon
        states[2][7] = Piece.Cannon
        states[4][0] = Piece.Rook
        states[4][1] = Piece.Horse
        states[4][2] = Piece.Bishop
        states[4][3] = Piece.Guard
        states[4][4] = Piece.General
        states[4][5] = Piece.Guard
        states[4][6] = Piece.Bishop
        states[4][7] = Piece.Horse
        states[4][8] = Piece.Rook
    
        return states
    }
}
