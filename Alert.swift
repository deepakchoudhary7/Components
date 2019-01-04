//
//  Alert.swift
//  SJAlert
//
//  Created by Saurabh on 24/05/17.
//  Copyright © 2017 Aryavrat Infotech. All rights reserved.
//

import UIKit

class Alert: NSObject {
    
    public static func showSimpleAlert(title:String, message:String, actionTitle:String, controller:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
    }
    
    public static func showSingleButtonAlert(title:String, message:String, actionTitle:String, controller:UIViewController, handler:(()-> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { (UIAlertAction) in
            if let hand = handler{
                hand()
            }
        }
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
    }
    
    public static func showDoubleButtonAlert(title:String, message:String, actionTitle1:String, actionTitle2:String, alertStyle:UIAlertControllerStyle, controller:UIViewController, handler1:(()-> Void)?, handler2:(()->Void)?){
       
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let action1 = UIAlertAction(title: actionTitle1, style: .default) { (UIAlertAction) in
            if let hand1 = handler1{
                hand1()
            }
        }
        let action2 = UIAlertAction(title: actionTitle2, style: .default) { (UIAlertAction) in
            if let hand2 = handler2{
                hand2()
            }
        }
        alert.addAction(action1)
        alert.addAction(action2)
        if alertStyle == .actionSheet {
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
        }
        controller.present(alert, animated: true, completion: nil)
    }
    
    public static func showSingleTextAlertWithTitle(title:String, message:String, actionTitle:String, placeHolder:String, controller:UIViewController, handler:((UITextField)->Void)?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = placeHolder
        }
        let action = UIAlertAction(title: actionTitle, style: .default) { (UIAlertAction) in
            let textFiled = alert.textFields?.first
            if let hand = handler{
                hand(textFiled!)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    public static func showDoubleTextAlert(title:String, message:String, actionTitle:String, placeHolder1:String, placeHolder2:String, isPassword:Bool, controller:UIViewController, handler:((UITextField, UITextField)->Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = placeHolder1
        }
        
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = placeHolder2
            if isPassword{
                textField.isSecureTextEntry = true
            }
        }
        
        let action = UIAlertAction(title: actionTitle, style: .default) { (UIAlertAction) in
            let text1 = alert.textFields?.first
            let text2 = alert.textFields?.last
            
            if let hand = handler{
                hand(text1!,text2!)
            }
        }
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
    }

    public static func showDatePicker(dataPicker:UIDatePicker, controller:UIViewController, hander:((Date)->Void)?) {
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(dataPicker)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            if let hand = hander {
                hand(dataPicker.date)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        controller.present(alert, animated: true, completion: nil)
    }
}
