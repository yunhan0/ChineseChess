//
//  Board.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/14/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation
import UIKit

class Board {
    // Chinese Chess board has 9 rows and 8 columns
    static let rows: CGFloat = 9
    static let columns: CGFloat = 8
    
    // Each player got 5 rows as his/her territory
    static let riverBorderIndex: Int = 5
    
    public static func isForbidden(row: Int, col: Int) -> Bool {
        if ((0...2 ~= row && 3...5 ~= col)) {
            return true
        }
        
        if (7...9 ~= row && 3...5 ~= col) {
            return true
        }
        return false
    }
    
    public static func getTerritoryOwner(row: Int) -> Player {
        if (row < riverBorderIndex) {
            return .Black
        } else {
            return .Red
        }
    }
    
}
