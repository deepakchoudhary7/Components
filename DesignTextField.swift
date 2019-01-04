//
//  DesignTextField.swift
//  Ride Share
//
//  Created by Saurabh on 11/12/17.
//  Copyright © 2017 Aryavrat. All rights reserved.
//

import UIKit

//@IBDesignable
class DesignTextField: UITextField {
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.bounds.origin.x, y: self.bounds.height
            - 0.5))
        path.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.height
            - 0.5))
        path.lineWidth = 0.5
        self.bottomColor.setStroke()
        path.stroke()
       
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += padding
        return textRect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= padding
        return textRect
    }
    
    @IBInspectable var placeHolderColor: UIColor = UIColor.gray {
        didSet {
             self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: placeHolderColor])
        }
    }
    
    @IBInspectable var bottomColor:UIColor = UIColor.clear {
        didSet {
            self.borderStyle = .bezel
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var padding:CGFloat = 0
    
    @IBInspectable var image:UIImage? {
        didSet {
            if let img = image {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height:20 ))
                imageView.image = img
                rightViewMode = .always
                rightView = imageView
            } else {
                leftViewMode = .never
                leftView = nil
            }
        }
    }
}

private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = prospectiveText.substring(to: maxCharIndex)
        selectedTextRange = selection
    }
}

