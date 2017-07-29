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
    class func showAlert(_ viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOK = UIAlertAction(title: GlobalStrings.ok, style: .default, handler: nil)
        alert.addAction(alertOK)
        
        viewController.present(alert, animated: true, completion: nil)

    }
}
