//
//  ChessView.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/16/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import UIKit

class ChessView: UIView {
    
    @IBInspectable
    var lineWidth: CGFloat = 1 { didSet { setNeedsDisplay(); board.lineWidth = lineWidth } }
    @IBInspectable
    var color: UIColor = UIColor.black { didSet { setNeedsDisplay(); board.color = color } }
    
    // Board
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
    
    // Pieces
    private lazy var pieces : [PieceView] = self.createPieces()
    
    private func createPieces() -> [PieceView] {
        var ret: [PieceView] = []
        let initialGameStates = Board.initialBoardStates
        
        for i in 0 ..< Board.rows {
            for j in 0 ..< Board.columns {
                if let piece = initialGameStates[i][j] {
                    ret.append(PieceView(piece))
                }
                
            }
        }
        
        return ret
    }
    
    private func positionPiece(piece: PieceView, center: CGPoint) {
        let size = board.gridWidth
        piece.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: size, height: size))
        piece.center = center
    }
    
    public var pieceViews: [PieceView] {
        return pieces
    }
    
    // Possible Move Hints
    public func createHint(center: CGPoint) -> UIImageView {
        let size = board.gridWidth * 0.9
        let hintView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        hintView.image = UIImage(named: "cursor")
        hintView.center = center
        addSubview(hintView)
        return hintView
    }
    
    public func removeHint(hintView: UIImageView) {
        hintView.removeFromSuperview()
    }
    
    override func layoutSubviews() {

        super.layoutSubviews()
        
        positionBoard(board: self.board)
        
        let m = board.boardCoordinates
        
        for p in pieces {
            let i = p.piece.position.x
            let j = p.piece.position.y
            
            positionPiece(piece: p, center: m[i][j])
        }
    }
    
}
