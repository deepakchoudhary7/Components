//
//  Date+Extension.swift
//  Fantricks
//
//  Created by Subhash Sharma on 25/09/18.
//  Copyright © 2018 OctalSoftware. All rights reserved.
//

import Foundation
extension Date {
    
    //MARK: Seconds Conversion
    static var minuteInSeconds:Double {
        return 60
    }
    
    static var hourInSeconds:Double {
        return 3600
    }
    
    static var dayInSeconds:Double {
        return 86400
    }
    
    static var weekInSeconds:Double {
        return 604800
    }
    
    static var yearInSeconds:Double {
        return 31556926
    }
}
