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
    
    private var nextPossibleMovesView: [UIImageView] = []
    
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
            pendingView?.setSelection()
            showPossibleMovesView(piece.nextPossibleMoves(boardStates: brain.gameStates))
            
        } else {
  
            if pendingView != nil {
                let x = pendingView!.piece.position.x, y = pendingView!.piece.position.y
                pendingView?.center = boardCoordinates[x][y]
                
                if sender.piece.status == .Died { // It means sender has been eaten
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
        
        if brain.checkMovementAvailability(destination: Vector2(x: row, y: col)) {
            pendingView?.center = boardCoordinates[row][col]
            clearPendingPieceView()
        }
    }
    
    private func showPossibleMovesView(_ possibleMoves: [Vector2]) {
        for move in possibleMoves {
            nextPossibleMovesView.append(
                chessView.createHint(center: boardCoordinates[move.x][move.y])
            )
        }
    }
    
    private func clearPossibleMovesView() {
        for hint in nextPossibleMovesView {
            chessView.removeHint(hintView: hint)
        }
        
        nextPossibleMovesView = []
    }
    
    private func clearPendingPieceView() {
        if pendingView != nil {
            pendingView?.removeSelection()
            pendingView = nil
        }
        
        clearPossibleMovesView()
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
            pv.center = boardCoordinates[pv.piece.position.x][pv.piece.position.y]
            pv.isHidden = false
        }
    }

}
