//
//  ViewController.swift
//  ChineseChess
//
//  Created by Yunhan Li on 4/25/17.
//  Copyright © 2017 Yunhan Li. All rights reserved.
//

import UIKit

class ChessViewController: UIViewController {

    @IBOutlet weak var chessView: ChessView!
    private var boardView: BoardView {
        return chessView.board
    }
    
    private var boardCoordinates: [[CGPoint]] {
        return boardView.boardCoordinates
    }
    
    private var gridWidth: CGFloat {
        return boardView.gridWidth
    
    }
    
    private var boardOrigin: CGPoint {
        return boardCoordinates[0][0]
    }
    
    private var boardTermination: CGPoint {
        return boardCoordinates[9][8]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(getCoordinates))
        tap.numberOfTapsRequired = 1
        boardView.addGestureRecognizer(tap)
        chessView.addSubview(boardView)
        
        for piece in chessView.pieceViews {
            piece.addTarget(self,action: #selector(performOperation(sender:)), for: .touchUpInside)
            chessView.addSubview(piece)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private var brain = ChessBrain()
    
    func performOperation(sender: PieceView!) {
        brain.setPiece(piece: sender)
    }
    
    func getCoordinates(recognizer: UITapGestureRecognizer) {
        let position = recognizer.location(in: boardView),
            x = round(position.x),
            y = round(position.y)
        
        if(y < boardOrigin.y - gridWidth / 2 || y > boardTermination.y + gridWidth / 2) {
            return
        }

        let col = Int(round((x - boardOrigin.x) / gridWidth)),
            row = Int(round((y - boardOrigin.y) / gridWidth))

        brain.performMovement(coordinate: boardCoordinates[row][col], row, col)
    }
}

