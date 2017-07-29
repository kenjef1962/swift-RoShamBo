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
                return GlobalStrings.computer
            case .player:
                return GlobalStrings.player
            case .none:
                return GlobalStrings.none
            }
        }
    }
}

enum PlayerThrow: Int {
    case rock = 0
    case paper
    case scissors
    case none
    
    static var random: PlayerThrow {
        get {
            return PlayerThrow(rawValue: Int(arc4random_uniform(3))) ?? .none
        }
    }
    
    var name: String {
        get {
            switch self {
            case .rock:
                return GlobalStrings.rock
            case .paper:
                return GlobalStrings.paper
            case .scissors:
                return GlobalStrings.scissors
            case .none:
                return GlobalStrings.none
            }
        }
    }
}

