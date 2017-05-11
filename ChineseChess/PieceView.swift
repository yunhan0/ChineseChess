//
//  PieceView.swift
//  ChineseChess
//
//  Created by Yunhan Li on 4/29/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import UIKit

class PieceView: UIButton {
    public var player: Player
    public var pieceType: Piece
    public var row: Int
    public var column: Int
    
    var _textColor: UIColor = UIColor.white
    
    init(_ player: Player,_ piece: Piece, row: Int, column: Int) {
        self.player = player
        self.pieceType = piece
        self.row = row
        self.column = column
        super.init(frame: CGRect.zero)
       
        self.setup(player, piece)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(_ player: Player, _ piece: Piece) {
        let name: String, color: UIColor
        
        switch piece {
        case .King: name = "将"
        case .Bishop: name = "象"
        case .Horse: name = "马"
        case .Guard: name = "士"
        case .Rook: name = "車"
        case .Cannon: name = "炮"
        case .Soldier: name = "兵"
        case .General: name = "帅"
        case .Pawn: name = "卒"
        }
        
        self.setTitle(name, for: .normal)
        
        switch player {
        case .Black: color = .black; transform = transform.rotated(by: CGFloat.pi)
        case .Red: color = .red
        }
        
        self.backgroundColor = color
        self.setTitleColor(_textColor, for: .normal)
        self.layer.masksToBounds = true
        self.layer.display()
    }
    
    func setRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func setBorder(width: CGFloat, color: CGColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color
    }
    
    func removeBorder() {
        self.layer.borderWidth = 0.0
    }
}
