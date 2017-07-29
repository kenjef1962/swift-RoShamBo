//
//  Utils.swift
//  RoShamBo
//
//  Created by Kendall Jefferson on 7/29/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit
import Foundation

class Utils {
    class func showHistory(_ navController: UINavigationController?, history: [HistoryItem]) {
         let storyBoard : UIStoryboard = UIStoryboard(name: "History", bundle:nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "historyViewController") as? HistoryViewController {
            vc.history = history
            navController?.pushViewController(vc, animated:true)
        }
    }
    
    class func showAlert(_ viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOK = UIAlertAction(title: GlobalStrings.ok, style: .default, handler: nil)
        alert.addAction(alertOK)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
