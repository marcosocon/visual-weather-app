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

    var locationManager: CLLocationManager?
    override func viewDidLoad() {
        super.viewDidLoad()

        //location manager setup
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
    //function to handle when the user has opted in or out of our location request.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
    
        case .notDetermined:
            print("notDetermined")        // location permission not asked for yet
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationLabel.text = "Thanks for authorizing our app to use your location!"
        case .authorizedAlways:
            print("authorizedAlways")     // location authorized
        case .restricted:
            print("restricted")           // TODO: handle
        case .denied:
            print("denied")
            locationLabel.text = "Our app cannot function properly without location permissions"
        @unknown default:
            print("unable to handle this scenario")
        }
    }
}

