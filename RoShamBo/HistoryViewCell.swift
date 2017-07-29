//
//  HistoryViewCell.swift
//  RoShamBo
//
//  Created by Kendall Jefferson on 2/27/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit

class HistoryViewCell: UITableViewCell {
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var computerImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    
    func configure(historyItem: HistoryItem) {
        playerImageView?.image = UIImage(named: historyItem.playerThrow.name)
        computerImageView?.image = UIImage(named: "\(historyItem.computerThrow.name)2")
        recordLabel?.text = "\(historyItem.playerWins) - \(historyItem.computerWins)"
        accessoryType = .detailButton
        
        switch historyItem.winner {
        case .player:
            resultLabel?.text = "Won"
            resultLabel?.textColor = .green
            computerImageView.alpha = 0.25
        case .computer:
            resultLabel?.text = "Lost"
            resultLabel?.textColor = .red
            playerImageView.alpha = 0.25
        case .none:
            resultLabel?.text = "Tie"
            playerImageView.alpha = 0.5
            computerImageView.alpha = 0.5
        }
    }
}
