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
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
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
            self.updateWeatherInfo(location.coordinate.latitude, longitude: location.coordinate.longitude)
            locationMgr.stopUpdatingLocation()
        }
    }
    
    func updateWeatherInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let mgr = AFHTTPRequestOperationManager()
        let url = "http://api.openweathermap.org/data/2.5/weather"
        let params = ["lat": -37.88, "lon": 20.00, "cnt": 0]
        
        mgr.GET(url, parameters: params, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
            println("JSON: " + responseObject.description!)
            self.updateUISuccess(responseObject as! NSDictionary!)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error: " + error.localizedDescription)
            })
    }
    
    func updateUISuccess(jsonResult: NSDictionary!) {
        if let tempResult = jsonResult["main"]?["temp"] as? Double {
            var temp: Double
            if(jsonResult["sys"]?["country"] as? String == "US") {
                temp = round(((tempResult - 273.15) * 1.8 ) + 32)
            } else {
                temp = round(tempResult - 273.15)
            }
            
            self.temperature.text = "\(temp)"
            self.temperature.font = UIFont.boldSystemFontOfSize(60.0)
            
            var name = jsonResult["name"] as? String
            self.location.font = UIFont.boldSystemFontOfSize(25.0)
            self.location.text = "\(name)"
        }
        else {
            
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error.description)
    }

}

