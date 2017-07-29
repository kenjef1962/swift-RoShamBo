//
//  HistoryItem.swift
//  RoShamBo
//
//  Created by Kendall Jefferson on 2/27/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation

struct HistoryItem {
    var winner = Player.none
    
    var computerThrow = PlayerThrow.none
    var playerThrow = PlayerThrow.none
    
    var computerWins = 0
    var playerWins = 0
}
