//
//  GameEngine.swift
//  RoShamBo
//
//  Created by Kendall Jefferson on 2/27/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

class GameEngine {
    
    var history: [HistoryItem] = []
    
    var winner: Player { get { return history.first?.winner ?? .none } }
    
    var playerWins: Int { get { return history.first?.playerWins ?? 0 } }
    var playerThrow: PlayerThrow { get { return history.first?.playerThrow ?? .none } }
    var playerThrowImage: UIImage? { get { return UIImage(named: "\(playerThrow.name)") } }

    var computerWins: Int { get { return history.first?.computerWins ?? 0 } }
    var computerThrow: PlayerThrow { get { return history.first?.computerThrow ?? .none } }
    var computerThrowImage: UIImage? { get { return UIImage(named: "\(computerThrow.name)2") } }
    
    var lastThrow: PlayerThrow? = nil
    
    func reset() {
        history.removeAll()
    }
    
    func throwDown(playerThrow: PlayerThrow?) {
        guard let playerThrow = playerThrow else { fatalError() }
        guard let computerThrow = generateThrow() else { fatalError() }

        var historyItem = HistoryItem()
        historyItem.playerWins = playerWins
        historyItem.playerThrow = playerThrow
        historyItem.computerWins = computerWins
        historyItem.computerThrow = computerThrow
        
        switch (playerThrow, computerThrow) {
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            historyItem.winner = .player
            historyItem.playerWins += 1
        case (.scissors, .rock), (.rock, .paper), (.paper, .scissors):
            historyItem.winner = .computer
            historyItem.computerWins += 1
        default:
            historyItem.winner = .none
        }
        
        history.insert(historyItem, at: 0)
    }
    
    fileprivate func generateThrow() -> PlayerThrow? {
        var computerThrow = PlayerThrow.random

        while lastThrow == computerThrow {
            computerThrow = PlayerThrow.random
        }
        
        lastThrow = computerThrow
        
        return computerThrow    }
}
