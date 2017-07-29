//
//  MainViewController.swift
//  RoShamBo
//
//  Created by Kendall Jefferson on 2/14/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var computerLabel: UILabel!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var computerImageView: UIImageView!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var winnerIsLabel: UILabel!
    
    let gameEngine = GameEngine()
    
    var isThrowingDown = false {
        didSet {
            rockButton?.isEnabled = !isThrowingDown
            paperButton?.isEnabled = !isThrowingDown
            scissorsButton?.isEnabled = !isThrowingDown
            
            winnerIsLabel?.alpha = isThrowingDown ? 0 : 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = GlobalStrings.appTitle
        resetButton.title = GlobalStrings.reset
        
        updateWinTotals()
        updateThrowDown()
    }
    
    @IBAction func throwButtonTapped(_ sender: UIButton) {
        throwDown(PlayerThrow(rawValue: sender.tag))
    }
    
    @IBAction func resetButtonTapped(_ sender: UIBarButtonItem) {
        reset()
    }
    
    @IBAction func historyButtonTapped(_ sender: UIBarButtonItem) {
        Utils.showHistory(navigationController, history: gameEngine.history)
    }
}

extension MainViewController {
   func reset() {
        gameEngine.reset()
        resetImages()
    
        updateWinTotals()
        updateThrowDown()
    }
    
    func resetImages() {
        playerImageView.reset()
        computerImageView.reset()
        
    }
    
    func throwDown(_ playerThrow: PlayerThrow?) {
        gameEngine.throwDown(playerThrow: playerThrow)
        animateThrowDown()
    }
}

extension MainViewController {
    func animateThrowDown() {
        isThrowingDown = true
        
        resetImages()
        
        UIView.transition(with: playerImageView,
                          duration: 0.5,
                          options: .transitionFlipFromLeft,
                          animations: { self.playerImageView.image = self.gameEngine.playerThrowImage },
                          completion: nil)
        
        UIView.transition(with: computerImageView,
                          duration: 0.5,
                          options: .transitionFlipFromRight,
                          animations: { self.computerImageView.image = self.gameEngine.computerThrowImage },
                          completion: { _ in self.animateWinner() })
    }
    
    func animateWinner() {
        updateWinTotals()
        
        if gameEngine.winner != .none {
            UIView.animate(withDuration: 0.5,
                           animations: { self.updateThrowDown(scale: 1.25, showBorder: false) },
                           completion: { _ in self.updateThrowDown() })
        }
        
        isThrowingDown = false
    }
}

extension MainViewController {
    func updateWinTotals() {
        playerLabel.text = String(format: GlobalStrings.playerWins, gameEngine.playerWins)
        computerLabel.text = String(format: GlobalStrings.computerWins, gameEngine.computerWins)

        var winnerIsLabelText = GlobalStrings.winnerIs

        switch gameEngine.winner {
        case .player:
            winnerIsLabelText += " \(GlobalStrings.player)"
        case .computer:
            winnerIsLabelText += " \(GlobalStrings.computer)"
        default:
            break
        }
        
        winnerIsLabel.text = winnerIsLabelText

    }
    
    func updateThrowDown(scale: CGFloat = 1.00, showBorder: Bool = true) {
        var winnerLabel: UILabel? = nil
        var winnerImageView: UIImageView? = nil
        var loserImageView: UIImageView? = nil
        
        switch gameEngine.winner {
        case .player:
            winnerLabel = playerLabel
            winnerImageView = playerImageView
            loserImageView = computerImageView
        case .computer:
            winnerLabel = computerLabel
            winnerImageView = computerImageView
            loserImageView = playerImageView
        default:
            break
        }
        
        winnerLabel?.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        winnerImageView?.alpha = 1.0
        winnerImageView?.setBorder(on: showBorder)
        winnerImageView?.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        loserImageView?.alpha = 0.25
    }
}

