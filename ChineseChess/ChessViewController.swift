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
        // Do any additional setup after loading the view, typically from a nib.
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
}

