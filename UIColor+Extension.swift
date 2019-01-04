//
//  UIColor+Extension.swift
//  Fantricks
//
//  Created by Subhash Sharma on 25/09/18.
//  Copyright © 2018 OctalSoftware. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: a)
    }
    
    convenience init(hex: Int) {
        self.init(r: (hex & 0xff0000) >> 16, g: (hex & 0xff00) >> 8, b: (hex & 0xff), a: 1)
    }
    
    static var theme:UIColor {
        return UIColor(r: 29, g: 73, b: 104, a: 1.0)
    }
}
