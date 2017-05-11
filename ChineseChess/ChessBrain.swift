//
//  ChessBrain.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/10/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation
import UIKit

class ChessBrain {
    private var pending: PieceView?
    
    func setPiece(piece: PieceView) {
        if let firstSelection = pending {
            // Do nothing if the second piece selection equals the first piece
            if(firstSelection == piece) {
                return
            }
            
            eatPiece(attacker: firstSelection, food: piece)
        } else {
            piece.setBorder(width: 2.0, color: UIColor.white.cgColor)
            pending = piece
        }
    }
    
    func performMovement(coordinate: CGPoint) {
        if let piece = pending {
            piece.center = coordinate
            piece.removeBorder()
            pending = nil
        }
    }
    
    func eatPiece(attacker: PieceView, food: PieceView) {
        attacker.center = food.center
        attacker.removeBorder()
        food.isHidden = true
        pending = nil
    }
    
}
