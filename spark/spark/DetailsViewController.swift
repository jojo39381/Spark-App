//
//  DetailsViewController.swift
//  spark
//
//  Created by Joseph Yeh on 6/2/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import MapKit
class DetailsViewController: UIViewController, MKMapViewDelegate {

    var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    var dateDict: [String: [Float]]?
    let locationManager = CLLocationManager()
    let regionRadius: Double = 20000
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if CLLocationManager.locationServicesEnabled() {
           checkLocationAuthorization()
        } else {
           // Do something to let users know why they need to turn it on.
        }
        view.addSubview(mapView)
        setupNav()
        mapView.frame = CGRect(x:0, y: 0, width: self.view.frame.width, height: 500)
        mapView.delegate = self
        placePlaces(dateDict!)
        centerMapOnUserLocation()
        // Do any additional setup after loading the view.
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
            case .denied: // Show alert telling users how to turn on permissions
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                mapView.showsUserLocation = true
            case .restricted: // Show an alert letting them know what’s up
                break
            case .authorizedAlways:
                break
        }
    }
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }



    func setupNav() {
        let navigationBar = self.navigationController?.navigationBar
        navigationItem.hidesBackButton = true
        
        navigationBar?.backgroundColor = .clear
       navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "Spark"
    }
    func placePlaces(_ places: [String: [Float]]) {
      for (key, value) in places {
        print(key)
        let annotations = MKPointAnnotation()
        annotations.title = key
        annotations.coordinate = CLLocationCoordinate2D(latitude:
            CLLocationDegrees(value[0]), longitude: CLLocationDegrees(value[1]))
        mapView.addAnnotation(annotations)
      }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
