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
    
    // Bind piece model with piece view together
    private var pieceModelViewReference : Dictionary<Int, PieceView> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(getCoordinates))
        tap.numberOfTapsRequired = 1
        boardView.addGestureRecognizer(tap)
        chessView.addSubview(boardView)
        
        for pieceView in chessView.pieceViews {
            pieceView.addTarget(self,action: #selector(performOperation(sender:)), for: .touchUpInside)
            chessView.addSubview(pieceView)
            
            pieceModelViewReference[pieceView.piece.pid] = pieceView
        }
    }
    
    private var brain = ChessBrain()
    
    private var pendingView : PieceView?
    
    func performOperation(sender: PieceView!) {
        brain.setPiece(piece: sender.piece)
        
        if let piece = brain.pending {
            // Clear last piece view if exists
            clearPendingPieceView()
            
            // Set the latest piece view
            pendingView = pieceModelViewReference[piece.pid]
            pendingView?.setBorder(width: 2.0, color: UIColor.white.cgColor)
            
        } else {
            if pendingView != nil {
                let x = pendingView!.piece.locationX, y = pendingView!.piece.locationY
                pendingView?.center = boardCoordinates[x][y]
                
                if sender.piece.locationX == -1 { // It means sender has been eaten
                    sender.isHidden = true
                }
            }
            clearPendingPieceView()
        }
        
        checkWinner()
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
        
        // Error handling: If coordinate has piece.
        if let piece = brain.gameStates[row][col] {
            performOperation(sender: pieceModelViewReference[piece.pid])
            return
        }
        
        if (brain.checkMovementAvailability(destinationX: row, destinationY: col)) {
            pendingView?.center = boardCoordinates[row][col]
            clearPendingPieceView()
        }
    }
 
    private func clearPendingPieceView() {
        if pendingView != nil {
            pendingView?.removeBorder()
            pendingView = nil
        }
    }
    
    private func checkWinner() {
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
        clearPendingPieceView()
        
        for (_, pv) in pieceModelViewReference {
            pv.center = boardCoordinates[pv.piece.locationX][pv.piece.locationY]
            pv.isHidden = false
        }
    }

}
