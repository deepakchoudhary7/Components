//
//  Queue.swift
//  Fantricks
//
//  Created by Subhash Sharma on 25/09/18.
//  Copyright © 2018 OctalSoftware. All rights reserved.
//

import Foundation

func delay(seconds:Int, completion:@escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds)) {
        completion()
    }
}

func mainQueue(completion:@escaping ()->Void) {
    DispatchQueue.main.async(execute: completion)
}

func backgroundQueue(completion:@escaping ()->Void) {
    DispatchQueue.global(qos: .background).async(execute: completion)
}
