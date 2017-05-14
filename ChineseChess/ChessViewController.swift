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
    
    @IBAction func replay(_ sender: UIBarButtonItem) {
        let initialGameStates = Rules.GameStates
        let pieces = chessView.pieceViews
        var idx = 0
        
        for i in 0...Int(Board.rows) {
            for j in 0...Int(Board.columns) {
                if (initialGameStates[i][j] != nil) {
                    pieces[idx].setLocation(row: i, col: j)
                    pieces[idx].center = boardCoordinates[i][j]
                    pieces[idx].isHidden = false
                    idx += 1
                }
            }
        }
        
        brain.replay()
    }
    
}
