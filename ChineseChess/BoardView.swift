//
//  BoardView.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/2/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import UIKit

class BoardView: UIView {
    var lineWidth: CGFloat = 2 { didSet { setNeedsDisplay() } }
    var color: UIColor = UIColor.black { didSet { setNeedsDisplay() } }

    // Chinese Chess board has 9 rows and 8 columns
    let boardRowsNumber: CGFloat = 9
    let boardColsNumber: CGFloat = 8

    private var boardHeight: CGFloat {
        return min(bounds.size.width, bounds.size.height)
    }
    
    public var gridWidth: CGFloat {
        return boardHeight / boardRowsNumber
    }
    
    private var boardWidth: CGFloat {
        return gridWidth * boardColsNumber
    }
    
    private var boardCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    public var boardCoordinates = [String : CGPoint]()

    public func resetBoardCoordinates() {
        boardCoordinates.removeAll()
    }
    
    private func pathForLine(startPoint: CGPoint, endPoint: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        path.close()
        path.lineWidth = lineWidth
        return path
    }
    
    override func draw(_ rect: CGRect) {
        color.set()
        
        resetBoardCoordinates()
        
        let startX = boardCenter.x - (boardWidth / 2),
        startY = boardCenter.y - (boardHeight / 2),
        endX = startX + boardWidth,
        endY = startY + boardHeight,
        breakPointY1 = startY + gridWidth * 4,
        breakPointY2 = startY + gridWidth * 5
        
        var indexOfX = 0, indexOfY = 0
        
        for _x in stride(from: startX, through: endX, by: gridWidth) {
            for _y in stride(from: startY, through: endY, by: gridWidth) {
                // Draw the vertical line
                if(_y == startY) {
                    if(_x == startX || _x == endX) {
                        pathForLine(startPoint: CGPoint(x: _x, y: startY), endPoint: CGPoint(x: _x, y: endY)).stroke()
                    } else {
                        pathForLine(startPoint: CGPoint(x: _x, y: startY), endPoint: CGPoint(x: _x, y: breakPointY1)).stroke()
                        pathForLine(startPoint: CGPoint(x: _x, y: breakPointY2), endPoint: CGPoint(x: _x, y: endY)).stroke()
                    }
                }
                
                // Draw the horizontal line
                if(_x == startX) {
                    pathForLine(startPoint: CGPoint(x: startX, y: _y), endPoint: CGPoint(x: endX, y: _y)).stroke()
                }
                
                boardCoordinates["R\(indexOfY)C\(indexOfX)"] = CGPoint(x: _x, y: _y)
                indexOfY += 1
            }
            
            indexOfX += 1
            indexOfY = 0
        }
    }
}
