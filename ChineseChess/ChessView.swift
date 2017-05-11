//
//  ChessView.swift
//  ChineseChess
//
//  Created by Yunhan Li on 4/25/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

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
    private lazy var rookPieceLeft: PieceView = self.createPiece(Piece.Rook, player: Player.Black)
    private lazy var horsePieceLeft: PieceView = self.createPiece(Piece.Horse, player: Player.Black)
    private lazy var bishopPieceLeft: PieceView = self.createPiece(Piece.Bishop, player: Player.Black)
    private lazy var guardPieceLeft: PieceView = self.createPiece(Piece.Guard, player: Player.Black)
    private lazy var kingPiece: PieceView = self.createPiece(Piece.King, player: Player.Black)
    private lazy var guardPieceRight: PieceView = self.createPiece(Piece.Guard, player: Player.Black)
    private lazy var bishopPieceRight: PieceView = self.createPiece(Piece.Bishop, player: Player.Black)
    private lazy var horsePieceRight: PieceView = self.createPiece(Piece.Horse, player: Player.Black)
    private lazy var rookPieceRight: PieceView = self.createPiece(Piece.Rook, player: Player.Black)
    private lazy var cannonPieceLeft: PieceView = self.createPiece(Piece.Cannon, player: Player.Black)
    private lazy var cannonPieceRight: PieceView = self.createPiece(Piece.Cannon, player: Player.Black)
    private lazy var soldierOne: PieceView = self.createPiece(Piece.Soldier, player: Player.Black)
    private lazy var soldierTwo: PieceView = self.createPiece(Piece.Soldier, player: Player.Black)
    private lazy var soldierThree: PieceView = self.createPiece(Piece.Soldier, player: Player.Black)
    private lazy var soldierFour: PieceView = self.createPiece(Piece.Soldier, player: Player.Black)
    private lazy var soldierFive: PieceView = self.createPiece(Piece.Soldier, player: Player.Black)
    
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
    private lazy var ordnancePieceLeft: PieceView = self.createPiece(Piece.Cannon, player: Player.Red)
    private lazy var ordnancePieceRight: PieceView = self.createPiece(Piece.Cannon, player: Player.Red)
    private lazy var pawnOne: PieceView = self.createPiece(Piece.Pawn, player: Player.Red)
    private lazy var pawnTwo: PieceView = self.createPiece(Piece.Pawn, player: Player.Red)
    private lazy var pawnThree: PieceView = self.createPiece(Piece.Pawn, player: Player.Red)
    private lazy var pawnFour: PieceView = self.createPiece(Piece.Pawn, player: Player.Red)
    private lazy var pawnFive: PieceView = self.createPiece(Piece.Pawn, player: Player.Red)
    
    /** Todo: need to be lazy evaluated list, right now is just ugly. **/
    public var pieceViews: [PieceView] {
        return [rookPieceLeft, horsePieceLeft, bishopPieceLeft, guardPieceLeft, kingPiece, guardPieceRight,
        bishopPieceRight, horsePieceRight, rookPieceRight, cannonPieceLeft, cannonPieceRight, soldierOne,
        soldierTwo, soldierThree, soldierFour, soldierFive,
        charlotPieceLeft, knightPieceLeft, elephantPieceLeft, advisorPieceLeft, generalPiece, advisorPieceRight,
        elephantPieceRight, knightPieceRight, charlotPieceRight, ordnancePieceLeft, ordnancePieceRight, pawnOne,
        pawnTwo, pawnThree, pawnFour, pawnFive]
    }
    
    private func createPiece(_ piece: Piece, player: Player) -> PieceView {
        let piece = PieceView(player, piece)
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
        
        let m = board.boardCoordinates
        
        // Player: Black
        positionPiece(piece: rookPieceLeft, center: m[0][0])
        positionPiece(piece: horsePieceLeft, center: m[0][1])
        positionPiece(piece: bishopPieceLeft, center: m[0][2])
        positionPiece(piece: guardPieceLeft, center: m[0][3])
        positionPiece(piece: kingPiece, center: m[0][4])
        positionPiece(piece: guardPieceRight, center: m[0][5])
        positionPiece(piece: bishopPieceRight, center: m[0][6])
        positionPiece(piece: horsePieceRight, center: m[0][7])
        positionPiece(piece: rookPieceRight, center: m[0][8])
        positionPiece(piece: cannonPieceLeft, center: m[2][1])
        positionPiece(piece: cannonPieceRight, center: m[2][7])
        
        positionPiece(piece: soldierOne, center: m[3][0])
        positionPiece(piece: soldierTwo, center: m[3][2])
        positionPiece(piece: soldierThree, center: m[3][4])
        positionPiece(piece: soldierFour, center: m[3][6])
        positionPiece(piece: soldierFive, center: m[3][8])
        
        // Player: Red
        positionPiece(piece: charlotPieceLeft, center: m[9][0])
        positionPiece(piece: knightPieceLeft, center: m[9][1])
        positionPiece(piece: elephantPieceLeft, center: m[9][2])
        positionPiece(piece: advisorPieceLeft, center: m[9][3])
        positionPiece(piece: generalPiece, center: m[9][4])
        positionPiece(piece: advisorPieceRight, center: m[9][5])
        positionPiece(piece: elephantPieceRight, center: m[9][6])
        positionPiece(piece: knightPieceRight, center: m[9][7])
        positionPiece(piece: charlotPieceRight, center: m[9][8])
        positionPiece(piece: ordnancePieceLeft, center: m[2][1])
        positionPiece(piece: ordnancePieceLeft, center: m[7][1])
        positionPiece(piece: ordnancePieceRight, center: m[7][7])
        
        positionPiece(piece: pawnOne, center: m[6][0])
        positionPiece(piece: pawnTwo, center: m[6][2])
        positionPiece(piece: pawnThree, center: m[6][4])
        positionPiece(piece: pawnFour, center: m[6][6])
        positionPiece(piece: pawnFive, center: m[6][8])
    }
}
