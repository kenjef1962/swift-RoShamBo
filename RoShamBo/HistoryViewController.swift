//
//  HistoryViewController.swift
//  RoShamBo
//
//  Created by Kendall Jefferson on 2/27/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {
    var history: [HistoryItem]!
    
    fileprivate let cellIdentifier = "historyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = GlobalStrings.history
        
        tableView.layoutMargins = UIEdgeInsets.zero         // Used to make sure divider lines run full width
        tableView.separatorInset = UIEdgeInsets.zero        // Used to make sure divider lines run full width
        tableView.tableFooterView = UIView(frame: .zero)    // Used to hide divider lines for non-cells
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HistoryViewCell
        cell.configure(historyItem: history[indexPath.row])
        cell.layoutMargins = UIEdgeInsets.zero              // Used to make sure divider lines run full width
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let historyItem = history[indexPath.row]
        var message = ""
        
        switch historyItem.winner {
        case .player:
            message = String(format: GlobalStrings.winDetails, historyItem.playerThrow.name, historyItem.computerThrow.name)
        case .computer:
            message = String(format: GlobalStrings.lossDetails, historyItem.playerThrow.name, historyItem.computerThrow.name)
        case .none:
            message = String(format: GlobalStrings.tieDetails, historyItem.playerThrow.name)
        }
        
        Utils.showAlert(self, title: GlobalStrings.appTitle, message: message)
    }
}
