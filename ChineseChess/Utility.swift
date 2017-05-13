//
//  Utility.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/13/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import Foundation

class Utility {
    static func isEqual<T: Equatable>(type: T.Type, a: Any, b: Any) -> Bool? {
        guard let a = a as? T, let b = b as? T else { return nil }
        
        return a == b
    } 
}
