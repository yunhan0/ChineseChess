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
    private var currentPiece: PieceView?
    
    func setPiece(piece: PieceView) {
        currentPiece = piece
    }
    
/*
    struct PendingOperationInfo {
        var firstSelection: PieceView
        var destination: CGPoint
    }

    private var pending: PendingOperationInfo?
    */
    func performMovement(coordinate: CGPoint) {
        if let piece = currentPiece {
            piece.center = coordinate
            currentPiece = nil
        }
        
    }
    
}
