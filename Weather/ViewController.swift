//
//  ViewController.swift
//  Weather
//
//  Created by Lei Gu on 15/7/6.
//  Copyright (c) 2015年 Skunk. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationMgr = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationMgr.desiredAccuracy = kCLLocationAccuracyBest
        locationMgr.delegate = self
//        
//        if(isIOS8()) {
//            locationMgr.requestAlwaysAuthorization()
//        }
        locationMgr.requestAlwaysAuthorization()

        locationMgr.startUpdatingLocation()
    }
    
    func isIOS8() -> Bool{
        return UIDevice.currentDevice().systemVersion == "8.0"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location:CLLocation = locations[locations.count - 1] as! CLLocation
        
        if(location.horizontalAccuracy > 0) {
            println(location.coordinate.latitude)
            println(location.coordinate.longitude)
            
            locationMgr.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error.description)
    }

}

