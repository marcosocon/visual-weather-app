//
//  ViewController.swift
//  VisualWeather
//
//  Created by Marcos Ocon on 24/04/2020.
//  Copyright © 2020 Marcos Ocon. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    var soon = Date()

    var locationManager: CLLocationManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        //location manager setup
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.startUpdatingLocation()
        }
    }
    
    //function to handle when the user has opted in or out of our location request.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .denied:
            print("asdasds")
        case .notDetermined:
            print("notDetermined")
        @unknown default:
                print("unable to handle this scenario")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if location.timestamp > soon {
                let geocoder = CLGeocoder()
                geocoder
                    .reverseGeocodeLocation(
                        location,
                        completionHandler: { (placemarks, error) in
                            if error == nil {
                                let firstLocation = placemarks?[0]
                                self.locationLabel.text = "\(firstLocation?.locality ?? ""), \(firstLocation?.country ?? "")"
                            }
                })
                // set next call in 30'
                soon = Date().addingTimeInterval(1800)
            }
        }
    }
}

