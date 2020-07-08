//
//  HomeViewController.swift
//  spark
//
//  Created by Joseph Yeh on 6/30/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import MapKit


class HomeViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        print(userLocation)
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
    var userLocation: CLLocation!
    var radius = 30000

