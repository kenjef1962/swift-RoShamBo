//
//  ViewController.swift
//  Rock Paper Scissors
//
//  Created by Kendall Jefferson on 2/14/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Throw: Int {
        case rock = 0
        case paper = 1
        case scissors = 2
        case none = 3
        
        var name: String {
            get {
                switch self {
                case .rock:
                    return "rock"
                case .paper:
                    return "paper"
                case .scissors:
                    return "scissors"
                case .none:
                    return "none"
                }
            }
        }
    }
    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var computerLabel: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var computerImageView: UIImageView!
    @IBOutlet weak var restartButton: UIButton!
    
    var playerCount = 0
    var computerCount = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateDisplay(winner: "", player: .none, computer: .none)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func throwButtonTapped(_ sender: UIButton) {
        
        guard let player = Throw(rawValue: sender.tag) else { return }
        guard let computer = Throw(rawValue: Int(arc4random_uniform(3))) else { return }
        
        var winner = ""
        
        if player != computer {
            switch (player, computer) {
            case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
                winner = "p"
                playerCount += 1
            default:
                winner = "c"
                computerCount += 1
            }
        }
        
        updateDisplay(winner: winner, player: player, computer: computer)
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        playerCount = 0
        computerCount = 0
        
        updateDisplay(winner: "", player: .none, computer: .none)
    }
    
    func updateDisplay(winner: String, player: Throw, computer: Throw) {
        
        let playerImage = player == .none ? nil : UIImage(named: player.name)
        let computerImage = computer == .none ? nil : UIImage(named: "\(computer.name)2")
        
        playerImageView.resetForAnimation()
        computerImageView.resetForAnimation()
        
        UIView.transition(with: playerImageView,
                          duration: 0.5,
                          options: .transitionFlipFromLeft,
                          animations: { self.playerImageView.image = playerImage },
                          completion: nil)
        
        UIView.transition(with: computerImageView,
            duration: 0.5,
            options: .transitionFlipFromRight,
            animations: { self.computerImageView.image = computerImage },
            completion: { _ in
                self.playerLabel.text = "Player: \(self.playerCount)"
                self.computerLabel.text = "Computer: \(self.computerCount)"
                
                if !winner.isEmpty {
                    UIView.animate(withDuration: 0.5,
                        animations: {
                            self.updateWinner(winner: winner, color: .red, scale: 1.25, showBorder: false)
                        },
                        completion: { _ in
                            self.updateWinner(winner: winner, color: .black, scale: 1.00, showBorder: true)
                        })
                }
            })
    }
    
    func updateWinner(winner: String, color: UIColor, scale: CGFloat, showBorder: Bool) {
        let winnerLabel = (winner == "p") ? self.playerLabel : self.computerLabel
        let winnerImageView = (winner == "p") ? self.playerImageView : self.computerImageView
        let loserImageView = (winner == "c") ? self.playerImageView : self.computerImageView
        
        winnerLabel?.textColor = .red
        winnerLabel?.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        winnerImageView?.alpha = 1.0
        winnerImageView?.setBorder(on: showBorder)
        winnerImageView?.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        loserImageView?.alpha = 0.25
    }
}

extension UIImageView {
    func setBorder(on visible: Bool) {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = visible ? 1 : 0
        self.layer.borderColor = UIColor.gray.cgColor
        self.clipsToBounds = true
    }
    
    func resetForAnimation() {
        self.alpha = 1.0
        self.image = nil
        self.setBorder(on: false)
        
    }
}

