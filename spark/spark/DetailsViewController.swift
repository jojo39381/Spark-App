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
        mapView.frame = self.view.frame
        mapView.delegate = self
        placePlaces(dateDict!)
        centerMapOnUserLocation()
        findRoutes(source: locationManager.location!.coordinate, destination: mapView.annotations[0].coordinate)
        for i in 0..<mapView.annotations.count - 1 {
            findRoutes(source: mapView.annotations[i].coordinate, destination: mapView.annotations[i+1].coordinate)
        }
        // Do any additional setup after loading the view.
    }
    
    var arrayOfRoutes: [MKRoute]?
    func findRoutes(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        
        let directionRequest = MKDirections.Request()
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        let sourcePlacemark = MKPlacemark(coordinate: source)
            print("//////////")
            print(locationManager.location!.coordinate)
            directionRequest.source = MKMapItem(placemark: sourcePlacemark)
            directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
            directionRequest.transportType = .automobile
            
            // calculate the directions / route
            let directions = MKDirections(request: directionRequest)
            directions.calculate { (directionsResponse, error) in
                guard let directionsResponse = directionsResponse else {
                    if let error = error {
                        print("error getting directions: \(error.localizedDescription)")
                    }
                    return
                }
                
                let route = directionsResponse.routes[0]
                
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                
                let routeRect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegion(routeRect), animated: true)
            }
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
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
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
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor.orange
        renderer.lineWidth = 4.0
        
        return renderer
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