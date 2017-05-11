//
//  ChessView.swift
//  ChineseChess
//
//  Created by Yunhan Li on 4/25/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import UIKit

@IBDesignable
class ChessView: UIView {
    
    @IBInspectable
    var lineWidth: CGFloat = 2 { didSet { setNeedsDisplay(); board.lineWidth = lineWidth } }
    @IBInspectable
    var color: UIColor = UIColor.black { didSet { setNeedsDisplay(); board.color = color } }
    
    public lazy var board: BoardView = self.createBoard()
    
    private func createBoard() -> BoardView {
        let board = BoardView()
        board.isOpaque = false
        board.color = color
        board.lineWidth = lineWidth
        return board
    }

    private func positionBoard(board: BoardView) {
        board.frame = bounds
        board.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    // Player: Black
    private lazy var blackPieces : [PieceView] = self.createPieces(.Black)
    private lazy var redPieces : [PieceView] = self.createPieces(.Red)
    
    private func createPieces(_ player: Player) -> [PieceView] {
        var ret: [PieceView] = []
        switch player {
            case .Black:
                for p in Rules.BlackPlayerPieces {
                    let piece = PieceView(player, p.piece, row: p.row, column: p.column)
                    ret.append(piece)
                }
            case .Red:
                for p in Rules.RedPlayerPieces {
                    let piece = PieceView(player, p.piece, row: p.row, column: p.column)
                    ret.append(piece)
                }
        }

        return ret
    }
    
    /** Todo: need to be lazy evaluated list, right now is just ugly. **/
    public var pieceViews: [PieceView] {
        return blackPieces + redPieces
    }
    
    private func positionPiece(piece: PieceView, center: CGPoint) {
        let size = board.gridWidth * 0.9
        piece.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: size, height: size))
        piece.center = center
        piece.setRadius(radius: size / 2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
     
        positionBoard(board: self.board)
        
        let m = board.boardCoordinates
        
        for p in blackPieces {
            positionPiece(piece: p, center: m[p.row][p.column])
        }
        
        for p in redPieces {
            positionPiece(piece: p, center: m[p.row][p.column])
        }
    }
}
