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
    static let FirstPlayer: Player = .Red
    
    // Initial game states
    static var GameStates : [[Piece?]] {
        return BlackPieces + RedPieces
    }
    
    static var BlackPieces : [[Piece?]] {
        return initBlackPiecesStates()
    }
    
    static var RedPieces : [[Piece?]] {
        return initRedPiecesStates()
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
    private static func initBlackPiecesStates() -> [[Piece?]] {
        var states = [[Piece?]](
            repeating: [Piece?](repeating: nil, count: Int(Board.columns) + 1),
            count: Board.riverBorderIndex
        )
        
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
    
    private static func initRedPiecesStates() -> [[Piece?]] {
        // Mark red player territory as 1
        var states = [[Piece?]](
            repeating: [Piece?](repeating: nil, count: Int(Board.columns) + 1),
            count: Board.riverBorderIndex
        )
        
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
