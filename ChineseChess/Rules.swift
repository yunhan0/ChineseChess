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
    
    /*
     Each player starts the game with these pieces: 
     1 king (or general), 
     2 guards (or advisors), 
     2 elephants (or bishops), 
     2 knights (or horses), 
     2 rooks (or chariots), 
     2 cannons and 5 pawns (or soldiers).
     */
    static let BlackPlayerPieces : [(piece: Piece, row: Int, column: Int)] = [
        (.Rook, 0, 0), (.Horse, 0, 1), (.Bishop, 0, 2), (.Guard, 0, 3),
        (.King, 0, 4), (.Guard, 0, 5), (.Bishop, 0, 6), (.Horse, 0, 7),
        (.Rook, 0, 8), (.Cannon, 2, 1), (.Cannon, 2, 7), (.Soldier, 3, 0),
        (.Soldier, 3, 2), (.Soldier, 3, 4), (.Soldier, 3, 6), (.Soldier, 3, 8)
    ]
    
    static let RedPlayerPieces : [(piece: Piece, row: Int, column: Int)] = [
        (.Rook, 9, 0), (.Horse, 9, 1), (.Bishop, 9, 2), (.Guard, 9, 3),
        (.General, 9, 4), (.Guard, 9, 5), (.Bishop, 9, 6), (.Horse, 9, 7),
        (.Rook, 9, 8), (.Cannon, 7, 1), (.Cannon, 7, 7), (.Pawn, 6, 0),
        (.Pawn, 6, 2), (.Pawn, 6, 4), (.Pawn, 6, 6), (.Pawn, 6, 8)
    ]
    
    // As tradition, red player will be the first one to move the piece
    static let FirstPlayer: Player = .Red
}
