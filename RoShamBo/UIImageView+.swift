//
//  UIImageView+.swift
//  RoShamBo
//
//  Created by Kendall Jefferson on 2/27/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setBorder(on visible: Bool) {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = visible ? 1 : 0
        self.layer.borderColor = UIColor.gray.cgColor
        self.clipsToBounds = true
    }
    
    func reset() {
        self.alpha = 1.0
        self.image = nil
        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.setBorder(on: false)
    }
}
