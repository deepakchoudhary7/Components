//
//  Google.swift
//  Ride Share
//
//  Created by Azhar on 04/01/18.
//  Copyright © 2018 Aryavrat. All rights reserved.
//

import Foundation
import GoogleSignIn

enum Result {
    case success(user:GIDGoogleUser)
    case failure(responseDic:[String:Any])
}

protocol GoogleDelegate {
    func loginResult(result:Result)
}

class Google:NSObject {
    
    fileprivate var controller:UIViewController!
    var googleDelegate:GoogleDelegate!
    
    
     func initWith(controller:UIViewController) {
        self.controller = controller
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func logIn() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func logOut() {
        GIDSignIn.sharedInstance().signOut()
    }
}

extension Google:GIDSignInUIDelegate {

    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        controller.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        controller.dismiss(animated: (viewController != nil), completion: nil)
    }
}

extension Google:GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            let userId = user.userID
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            print(userId ?? "!usreId",idToken ?? "!idToken",fullName ?? "!fullName",givenName ?? "!givenName",familyName ?? "familyName",email ?? "email")
            googleDelegate.loginResult(result: .success(user: user))
        } else {
            let data = ["msg":error.localizedDescription]
            googleDelegate.loginResult(result: .failure(responseDic: data))
            print("\(error.localizedDescription)")
        }
    }
}
