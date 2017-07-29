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
    
    let presenter = MainViewPresenter()
    
    fileprivate let storyboardName = "History"
    fileprivate let viewControllerIdentifier = "historyViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDisplay()
    }
    
    @IBAction func throwButtonTapped(_ sender: UIButton) {
        throwDown(PlayerThrow(rawValue: sender.tag))
    }
    
    @IBAction func resetButtonTapped(_ sender: UIBarButtonItem) {
        reset()
    }
    
    @IBAction func historyButtonTapped(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyboardName, bundle:nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? HistoryViewController {
            vc.history = presenter.history
            navigationController?.pushViewController(vc, animated:true)
        }
    }
}

extension MainViewController {
    func throwDown(_ playerThrow: PlayerThrow?) {
        presenter.throwDown(playerThrow: playerThrow)
        
        playerImageView.reset()
        computerImageView.reset()
        
        enableThrowButtons(false)
        
        animateThrowDown()
    }
    
    func animateThrowDown() {
        playerImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        computerImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        
        UIView.transition(with: playerImageView,
                          duration: 0.5,
                          options: .transitionFlipFromLeft,
                          animations: { self.playerImageView.image = self.presenter.playerThrowImage },
                          completion: nil)
        
        UIView.transition(with: computerImageView,
                          duration: 0.5,
                          options: .transitionFlipFromRight,
                          animations: { self.computerImageView.image = self.presenter.computerThrowImage },
                          completion: { _ in self.animateWinner() })
    }
    
    func animateWinner() {
        playerLabel.text = String(format: GlobalStrings.player, presenter.playerWins)
        computerLabel.text = String(format: GlobalStrings.computer, presenter.computerWins)
        
        if presenter.winner != .none {
            UIView.animate(withDuration: 0.5,
                           animations: { self.updateDisplay(scale: 1.25, showBorder: false) },
                           completion: { _ in self.updateDisplay() })
        }
        
        enableThrowButtons(true)
    }
    
    func enableThrowButtons(_ isEnabled: Bool) {
        rockButton.isEnabled = isEnabled
        paperButton.isEnabled = isEnabled
        scissorsButton.isEnabled = isEnabled
    }
    
    func reset() {
        presenter.reset()
        
        playerLabel.text = String(format: GlobalStrings.player, presenter.playerWins)
        computerLabel.text = String(format: GlobalStrings.computer, presenter.computerWins)

        playerImageView.reset()
        computerImageView.reset()
    }
    
    func updateDisplay(scale: CGFloat = 1.00, showBorder: Bool = true) {
        var winnerLabel: UILabel? = nil
        var winnerImageView: UIImageView? = nil
        var loserImageView: UIImageView? = nil
        
        switch presenter.winner {
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

