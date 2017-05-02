//
//  PieceView.swift
//  ChineseChess
//
//  Created by Yunhan Li on 4/29/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import UIKit

class PieceView: UILabel {
    var _textColor: UIColor = UIColor.white
    
    init(_ name: String) {
        super.init(frame: CGRect.zero)
        self.setup(name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(_ name: String) {
        self.text = name
        self.textAlignment = .center
        self.textColor = _textColor
        self.layer.masksToBounds = true
        self.layer.display()
    }
    
    func setRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func setChessColor(color: UIColor) {
        self.backgroundColor = color
    }

}
