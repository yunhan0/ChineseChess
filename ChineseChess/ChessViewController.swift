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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(getCoordinates))
        tap.numberOfTapsRequired = 1
        chessView.board.addGestureRecognizer(tap)
        chessView.addSubview(chessView.board)
        
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
    
    func performOperation(sender:UIButton!) {
        if let label = sender.currentTitle {
            print(label)
        }
    }
    
    func getCoordinates(recognizer: UITapGestureRecognizer) {
        let position = recognizer.location(in: chessView.board)
        
        print(round(position.x), round(position.y))
    }
}

