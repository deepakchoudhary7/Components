//
//  Facebook.swift
//  
//
//  Created by Rajat on 03/01/18.
//  Copyright © 2018 Tutist. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin
import FBSDKCoreKit


class Facebook {
    
    var getFields = [String:String]()
    var fbAccessToken:String!
    var controller:UIViewController!
    
    private let loginManager = LoginManager()
    
    typealias loginSuccess = (_ token:String, _ responseDic:[String:Any]) -> Void
    typealias loginFaliure = (_ responseDic:[String:Any]) -> Void
    
    func logIn(success:@escaping loginSuccess, faliure:@escaping loginFaliure) {
        
        func getFacebookProfileInfo(accessToken:String) {
            FBSDKGraphRequest(graphPath: "me", parameters: getFields).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.fbAccessToken = accessToken
                    let fbDetails = result as! [String:Any]
                    print(fbDetails)
                    success(accessToken,fbDetails)
                }
            })
        }
        if let accessToken = AccessToken.current {
            getFacebookProfileInfo(accessToken: accessToken.authenticationToken)
        } else {
            loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: controller) { loginResult in
                switch loginResult {
                case .failed(let error):
                    print("Error to login:\(error)")
                    let data = ["msg":error.localizedDescription]
                    faliure(data)
                    
                case .cancelled:
                    print("User cancelled login.")
                    let data = ["msg":"User cancelled login."]
                    faliure(data)
                    
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    print("Logged in!\(grantedPermissions),\(declinedPermissions),\(accessToken)")
                    getFacebookProfileInfo(accessToken: accessToken.authenticationToken)
                }
            }
        }
    }
    
    
    func logOut() {
        loginManager.logOut()
    }
}
