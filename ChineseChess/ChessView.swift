//
//  ChessView.swift
//  ChineseChess
//
//  Created by Yunhan Li on 4/25/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import UIKit
import Dispatch

@IBDesignable
class ChessView: UIView {
    
    @IBInspectable
    var lineWidth: CGFloat = 2 { didSet { setNeedsDisplay(); board.lineWidth = lineWidth } }
    @IBInspectable
    var color: UIColor = UIColor.black { didSet { setNeedsDisplay(); board.color = color } }
    
    private enum Player {
        case Black
        case Red
    }
    
    private enum Piece {
        case King
        case Guard
        case Bishop
        case Horse
        case Rook
        case Cannon
        case Solder
        case General
    }
    
    private var board: BoardView {
        return self.createBoard()
    }
    
    private func createBoard() -> BoardView {
        let board = BoardView()
        board.isOpaque = false
        board.color = color
        board.lineWidth = lineWidth
        self.addSubview(board)
        return board
    }

    private func positionBoard(board: BoardView) {
        board.frame = bounds
        board.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    // Player: Black
    private lazy var rookPieceLeft: PieceView = self.createPiece(Piece.Rook, player: Player.Black)
    private lazy var horsePieceLeft: PieceView = self.createPiece(Piece.Horse, player: Player.Black)
    private lazy var bishopPieceLeft: PieceView = self.createPiece(Piece.Bishop, player: Player.Black)
    private lazy var guardPieceLeft: PieceView = self.createPiece(Piece.Guard, player: Player.Black)
    private lazy var kingPiece: PieceView = self.createPiece(Piece.King, player: Player.Black)
    private lazy var guardPieceRight: PieceView = self.createPiece(Piece.Guard, player: Player.Black)
    private lazy var bishopPieceRight: PieceView = self.createPiece(Piece.Bishop, player: Player.Black)
    private lazy var horsePieceRight: PieceView = self.createPiece(Piece.Horse, player: Player.Black)
    private lazy var rookPieceRight: PieceView = self.createPiece(Piece.Rook, player: Player.Black)
    
    // Player: Red
    private lazy var charlotPieceLeft: PieceView = self.createPiece(Piece.Rook, player: Player.Red)
    private lazy var knightPieceLeft: PieceView = self.createPiece(Piece.Horse, player: Player.Red)
    private lazy var elephantPieceLeft: PieceView = self.createPiece(Piece.Bishop, player: Player.Red)
    private lazy var advisorPieceLeft: PieceView = self.createPiece(Piece.Guard, player: Player.Red)
    private lazy var generalPiece: PieceView = self.createPiece(Piece.General, player: Player.Red)
    private lazy var advisorPieceRight: PieceView = self.createPiece(Piece.Guard, player: Player.Red)
    private lazy var elephantPieceRight: PieceView = self.createPiece(Piece.Bishop, player: Player.Red)
    private lazy var knightPieceRight: PieceView = self.createPiece(Piece.Horse, player: Player.Red)
    private lazy var charlotPieceRight: PieceView = self.createPiece(Piece.Rook, player: Player.Red)
    
    private func createPiece(_ piece: Piece, player: Player) -> PieceView {
        let _name: String
        let _color: UIColor
  
        switch player {
        case .Black: _color = .black
        case .Red: _color = .red
        }
        
        switch piece {
        case .King: _name = "将"
        case .Bishop: _name = "象"
        case .Horse: _name = "马"
        case .Guard: _name = "士"
        case .Rook: _name = "車"
        case .Cannon: _name = "炮"
        case .Solder: _name = "兵"
        case .General: _name = "帅"
        }
        
        let piece = PieceView(_name)
        piece.setChessColor(color: _color)
        self.addSubview(piece)
        return piece
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
        
        // Player: Black
        //            positionPiece(piece: rookPieceLeft, center: boardCoordinates["R0C0"]!)
        //            positionPiece(piece: horsePieceLeft, center: boardCoordinates["R0C1"]!)
        //            positionPiece(piece: bishopPieceLeft, center: boardCoordinates["R0C2"]!)
        //            positionPiece(piece: guardPieceLeft, center: boardCoordinates["R0C3"]!)
        //            positionPiece(piece: kingPiece, center: boardCoordinates["R0C4"]!)
        //            positionPiece(piece: guardPieceRight, center: boardCoordinates["R0C5"]!)
        //            positionPiece(piece: bishopPieceRight, center: boardCoordinates["R0C6"]!)
        //            positionPiece(piece: horsePieceRight, center: boardCoordinates["R0C7"]!)
        //            positionPiece(piece: rookPieceRight, center: boardCoordinates["R0C8"]!)
        //
        //            // Player: Red
        //            positionPiece(piece: charlotPieceLeft, center: boardCoordinates["R9C0"]!)
        //            positionPiece(piece: knightPieceLeft, center: boardCoordinates["R9C1"]!)
        //            positionPiece(piece: elephantPieceLeft, center: boardCoordinates["R9C2"]!)
        //            positionPiece(piece: advisorPieceLeft, center: boardCoordinates["R9C3"]!)
        //            positionPiece(piece: generalPiece, center: boardCoordinates["R9C4"]!)
        //            positionPiece(piece: advisorPieceRight, center: boardCoordinates["R9C5"]!)
        //            positionPiece(piece: elephantPieceRight, center: boardCoordinates["R9C6"]!)
        //            positionPiece(piece: knightPieceRight, center: boardCoordinates["R9C7"]!)
        //            positionPiece(piece: charlotPieceRight, center: boardCoordinates["R9C8"]!)

    }
}
