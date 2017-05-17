//
//  ChessViewController.swift
//  ChineseChess
//
//  Created by Yunhan Li on 5/16/17.
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
    
    private var pieceViews = [PieceView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(getCoordinates))
        tap.numberOfTapsRequired = 1
        boardView.addGestureRecognizer(tap)
        chessView.addSubview(boardView)
        
        for pieceView in chessView.pieceViews {
            pieceView.addTarget(self,action: #selector(performOperation(sender:)), for: .touchUpInside)
            chessView.addSubview(pieceView)
            
            pieceViews.append(pieceView)
        }
    }
    
    private var brain = ChessBrain()
    
    private var pending : PieceView?
    
    func performOperation(sender: PieceView!) {        
        if pending != nil {
            if (pending?.piece.owner == sender.piece.owner) {
                return
            }
            
            let x = sender.piece.locationX, y = sender.piece.locationY

            if (brain.checkMovementAvailability(destinationX: x, destinationY: y)) {
                
                pending?.center = boardCoordinates[x][y]
                sender.isHidden = true
                
                if (sender.piece is King) {
                    if (sender.piece.owner == .Black) {
                        brain.winner = .Red
                    } else {
                        brain.winner = .Black
                    }
                    
                    congratulateWinner()
                }
                
            }
            
            pending?.removeBorder()
            pending = nil
        } else {
            if (sender.piece.owner == brain.currentPlayer) {
                brain.setPiece(piece: sender.piece)
                pending = sender
                pending?.setBorder(width: 2.0, color: UIColor.white.cgColor)
            }
        }
        
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
        
        if (brain.checkMovementAvailability(destinationX: row, destinationY: col)) {
            pending?.center = boardCoordinates[row][col]
        }
        
        if pending != nil {
            pending?.removeBorder()
            pending = nil
        }
    }

    func congratulateWinner() {
        if let result = brain.winner {
            let msg : String
            switch result {
            case .Black:
                msg = "㊗️恭喜黑队大获全胜，大侠们请重新来过"
            case .Red:
                msg = "㊗️恭喜红队大获全胜，大侠们请重新来过"
            }
            let alert =
                UIAlertController(title: "游戏结束", message: msg, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "确认", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func replay(_ sender: UIBarButtonItem) {
        brain.replay()

        for pv in pieceViews {
            pv.center = boardCoordinates[pv.piece.locationX][pv.piece.locationY]
            pv.isHidden = false
        }
    }

}
