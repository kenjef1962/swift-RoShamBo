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
    
    fileprivate let historyStoryboardName = "History"
    fileprivate let historyViewControllerIdentifier = "historyViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = GlobalStrings.appTitle
        resetButton.title = GlobalStrings.reset
        
        updateWinTotals()
        updateThrowDown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateThrowDown()
    }
    
    @IBAction func throwButtonTapped(_ sender: UIButton) {
        throwDown(PlayerThrow(rawValue: sender.tag))
    }
    
    @IBAction func resetButtonTapped(_ sender: UIBarButtonItem) {
        reset()
    }
    
    @IBAction func historyButtonTapped(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: historyStoryboardName, bundle:nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: historyViewControllerIdentifier) as? HistoryViewController {
            vc.history = gameEngine.history
            navigationController?.pushViewController(vc, animated:true)
        }
    }
}

extension MainViewController {
   func reset() {
        gameEngine.reset()
 
        playerImageView.reset()
        computerImageView.reset()
    
        updateWinTotals()
        updateThrowDown()
    }
    
    func throwDown(_ playerThrow: PlayerThrow?) {
        gameEngine.throwDown(playerThrow: playerThrow)
        animateThrowDown()
    }
}

extension MainViewController {
    func animateThrowDown() {
        enableThrowButtons(false)
        
        playerImageView.reset()
        computerImageView.reset()
        
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
        
        enableThrowButtons(true)
    }
}

extension MainViewController {
    func enableThrowButtons(_ isEnabled: Bool) {
        rockButton.isEnabled = isEnabled
        paperButton.isEnabled = isEnabled
        scissorsButton.isEnabled = isEnabled
        
        winnerIsLabel.alpha = isEnabled ? 1 : 0
    }
    
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

