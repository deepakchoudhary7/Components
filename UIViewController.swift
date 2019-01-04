//
//  UIViewController.swift
//  SweaterCustomer
//
//  Created by Subhash Sharma on 08/03/18.
//  Copyright © 2018 OctalSoftware. All rights reserved.
//

import Foundation
import UIKit
import Toaster

extension UIViewController {
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showTextAlert(title:String, message:String, placeHolder:String, completion:@escaping (_ textField:UITextField)->()) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textFiled) in
            textFiled.placeholder = placeHolder
            textFiled.keyboardType = .numberPad
        }
        
        let ok = UIAlertAction(title: "OK".localized, style: .default) { (action) in
            let textField = alert.textFields?.first
            completion(textField!)
        }
        
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSingleButtonAlert(title:String, message:String, completion:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK".localized, style: .default) { (action) in
            completion()
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func showDoubleButtonAlert(title:String, message:String, action1:String, action2:String, isActionSheet:Bool = false, completion1:@escaping ()->(), completion2:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: isActionSheet ? .actionSheet : .alert)
        let act1 = UIAlertAction(title: action1, style: .default) { (action) in
            completion1()
        }
        let act2 = UIAlertAction(title: action2, style: .default) { (action) in
            completion2()
        }
        alert.addAction(act1)
        alert.addAction(act2)
        if isActionSheet {
            alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        }
        present(alert, animated: true, completion: nil)
    }
    
    func reloadToRootViewController() {
        appDelegate.window?.rootViewController = self.storyboard?.instantiateInitialViewController()
    }
    
    func showToast(_ text:String) {
        if let currentToast = ToastCenter.default.currentToast {
            currentToast.cancel()
        }
        Toast(text: text).show()
    }
    
    func showToast(text:String,delay:TimeInterval,duration:TimeInterval) {
        if let currentToast = ToastCenter.default.currentToast {
            currentToast.cancel()
        }
        Toast(text: text, delay: delay, duration: duration).show()
    }
}
