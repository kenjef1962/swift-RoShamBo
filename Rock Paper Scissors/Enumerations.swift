//
//  Throw.swift
//  Rock Paper Scissors
//
//  Created by Kendall Jefferson on 2/27/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation

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

