//
//  PieceView.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/16/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import UIKit

class PieceView:  UIButton {
    var piece: Piece 
    
    var _textColor: UIColor = UIColor.white
    
    init(_ piece: Piece) {
        self.piece = piece
        super.init(frame: CGRect.zero)
        
        self.setup(piece)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ piece: Piece) {
        let name: String, color: UIColor
        
        switch piece {
        case is Bishop: name = "象"
        case is Horse: name = "马"
        case is Guard: name = "士"
        case is Rook: name = "車"
        case is Cannon: name = "炮"
        case is Pawn: if (piece.owner == .Black) { name = "卒" } else { name = "兵"}
        case is King: if (piece.owner == .Black) { name = "将" } else { name = "帅"}
        default: name = ""
        }
        
        self.setTitle(name, for: .normal)
        
        switch piece.owner {
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
