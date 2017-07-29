//
//  Throw.swift
//  RoShamBo
//
//  Created by Kendall Jefferson on 2/27/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation

enum Player: Int {
    case computer = 0
    case player
    case none
    
    var name: String {
        get {
            switch self {
            case .computer:
                return "computer"
            case .player:
                return "player"
            case .none:
                return "none"
            }
        }
    }
}

enum PlayerThrow: Int {
    case rock = 0
    case paper
    case scissors
    case none
    
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

