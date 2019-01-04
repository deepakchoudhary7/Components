//
//  AppDelegate.swift
//  FoodyPOS
//
//  Created by rajat on 26/07/18.
//  Copyright © 2018 com.tutist. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //set text field tint color
        UITextField.appearance().tintColor = UIColor.themeColor

        // Handling for push notifications
        registerForPushNotifications()
        
        //killed app notificaltion handle
//        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
//            if let apsDic = notification["aps"] as? NSDictionary {
//                if let alert = apsDic.value(forKey: "alert") as? NSDictionary {
//                        goToDetailVC(body: alert["body"] as! String)
//                }
//            }
//        }
        // Show dashboard screen if user is already logged in
        if UserManager.isRemember && UserManager.isLogin {
            Global.showRootView(withIdentifier: StoryboardConstant.DashboardVC)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate {
    
    /// Ask users for push notification permission and get cloud key
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                print("Permission granted: \(granted)")
                // 1. Check if permission granted
                guard granted else { return }
                // 2. Attempt registration for remote notifications on the main thread
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    // called when user allows push notification
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 1. Convert device token to string
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
        UserManager.token = token
        if token.trim() != "" {
            DispatchQueue.global().async {
                Global.callLoginApi()
            }
        }
    }
    
    
    // called when user deny push notification
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // 1. Print out error if PNs registration not successful
        print("Failed to register for remote notifications with error: \(error)")
    }
    
    
    // Called when a notification is received
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        
        if let apsDic = userInfo["aps"] as? NSDictionary {
            if let alert = apsDic.value(forKey: "alert") as? NSDictionary {
                if UIApplication.shared.applicationState == .active {
                    goToDetailVC(body: alert["body"] as! String)
                }else if (UIApplication.shared.applicationState == .background) || (UIApplication.shared.applicationState == .inactive) {
                    goToDetailVC(body: alert["body"] as! String)
                }
                completionHandler(.newData)
            }
        }
    }
}

extension AppDelegate {
    func goToDetailVC(body:String) {
        guard let navVC = self.window?.rootViewController as? UINavigationController else {
            return
        }
        if navVC.visibleViewController is OrderDetailVC {
            let info = ["orderNo":body]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kOrderDetailNotification), object: nil, userInfo: info)
        } else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryboardConstant.OrderDetailVC) as! OrderDetailVC
            vc.orderNo = body
            navVC.pushViewController(vc, animated: true)
        }
    }
}

extension UIApplication {
    class var build: String? {
        get {
            return Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String
        }
    }
    
    class var version: String? {
        get {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        }
    }
    
    class var appId: String? {
        get {
            return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
        }
    }
}
