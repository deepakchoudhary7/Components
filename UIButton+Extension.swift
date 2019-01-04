//
//  UIButton+Extension.swift
//  Fantricks
//
//  Created by Subhash Sharma on 05/10/18.
//  Copyright © 2018 OctalSoftware. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func roundCorners(corners:UIRectCorner, cornerRadii radii:Double) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
}
