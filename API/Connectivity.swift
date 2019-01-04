//
//  Connectivity.swift
//  FoodyPOS
//
//  Created by rajat on 26/07/18.
//  Copyright © 2018 com.tutist. All rights reserved.
//


import Foundation
import Alamofire

class Connectivity {
    
    static let msgNoNetwork = "The Internet connection appears to be offline"
    
    //  Check if device is connected to internet
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
