//
//  LocationManager.swift
//  SweaterCustomer
//
//  Created by Subhash Sharma on 14/03/18.
//  Copyright © 2018 OctalSoftware. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    static let sharedInstance = LocationManager()
    
    var latitude:Double = 28.518153
    var longitude:Double = 76.20569
    
    let locationManager = CLLocationManager()
    
    var isLocationPermissionOn:Bool {
        return ((CLLocationManager.authorizationStatus() == .authorizedAlways) || (CLLocationManager.authorizationStatus() == .authorizedWhenInUse))
    }
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func getDistanceOf(dLatitude:Double, dLongitude:Double, inMiles:Bool) -> Double {
        var distance = 0.0
        let sourceCoordinate = CLLocation(latitude: latitude, longitude: longitude)
        let destinationCoordinate = CLLocation(latitude: dLatitude, longitude: dLongitude)
        distance = destinationCoordinate.distance(from: sourceCoordinate)
        if inMiles {
            distance = distance/1609
        }
        return distance
    }
//    func getAddressFrom(klatitute:Double, klongitute:Double, withCompletion completion:@escaping (_ address:String, _ latitute:Double, _ longitute:Double)->()) {
//        let geoCoder = CLGeocoder()
//
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//       // Global.showHud()
//        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
//            if error == nil {
//                if let placemarks = placemarks {
//                    if placemarks.count > 0 {
//                        let pm = placemarks[0]
//                        var address = ""
//
//                        if let sublocality = pm.subLocality {
//                            address = address + sublocality + ", "
//                        }
//
//                        if let throughFare = pm.thoroughfare {
//                            address = address + throughFare + ", "
//                        }
//
//                        if let locality = pm.locality {
//                            address = address + locality + ", "
//                        }
//
//                        if let country = pm.country {
//                            address = address + country + ", "
//                        }
//
//                        if let postalCode = pm.postalCode {
//                            address = address + postalCode
//                        }
//
//                        print(address)
//                        //Global.hideHud()
//                        completion(address, coordinate.latitude, coordinate.longitude)
//                    }else {
//                      //  Global.hideHud()
//                        completion("error",0.0,0.0)
//                    }
//                }else {
//                  //  Global.hideHud()
//                    completion("error",0.0,0.0)
//                }
//
//            }else {
//                print(error?.localizedDescription)
//                //Global.hideHud()
//                completion("error",0.0,0.0)
//
//            }
//        }
//    }
}

extension LocationManager:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            //latitude = location.coordinate.latitude
            //longitude = location.coordinate.longitude
            print("latitude:\(latitude),longitude:\(longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Fail to update location error:\(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorizationStatus")
        
        switch status {
        case .notDetermined:
            print(".NotDetermined")
            break
            
        case .authorizedAlways:
            print(".Authorized")
            locationManager.startUpdatingLocation()
            break
            
        case .denied:
            print(".Denied")
            break
            
        default:
            print("Unhandled authorization status")
            break
            
        }
    }
}
