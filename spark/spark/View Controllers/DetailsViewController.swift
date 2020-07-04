//
//  DetailsViewController.swift
//  spark
//
//  Created by Joseph Yeh on 6/2/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import MapKit
class DetailsViewController: UIViewController, MKMapViewDelegate, ItineraryDelegate {
    
    
    func displaySuccessView() {
        let vc = SuccessViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    var dateDict: [String: [Float]]?
    var imageDict: [String : String]?
    var dateInfo: [String: [Any]]?
    var dateOrder : [String]?
    var dateScores:[Int]!
    var showScores = false
    var scoresTableView: UITableView!
    var scoreButton: UIButton!
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
        
        
        setupView()
        
        scoresTableView = UITableView()
        navigationController!.navigationBar.addSubview(scoresTableView)
        scoresTableView.delegate = self
        scoresTableView.dataSource = self
        scoresTableView.backgroundColor = .clear
        scoresTableView.isScrollEnabled = false
        scoresTableView.register(UITableViewCell.self, forCellReuseIdentifier: "scores")
        scoresTableView.translatesAutoresizingMaskIntoConstraints = false
        scoresTableView.topAnchor.constraint(equalTo: (navigationController?.navigationBar.topAnchor)!, constant: view.frame.height * 0.025).isActive = true
        scoresTableView.rightAnchor.constraint(equalTo: (navigationController?.navigationBar.rightAnchor)!, constant: -view.frame.height * 0.025).isActive = true
        scoresTableView.widthAnchor.constraint(equalToConstant: view.frame.height * 0.1).isActive = true
        scoresTableView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.1).isActive = true
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
        findRoutes(source: locationManager.location!.coordinate, destination: mapView.annotations[0].coordinate)
        
        print(mapView.annotations[0].title)
        for i in 0..<mapView.annotations.count - 1 {
            print(mapView.annotations[i].title)
            findRoutes(source: mapView.annotations[i].coordinate, destination: mapView.annotations[i+1].coordinate)
        }
    }



    func setupNav() {
        let navigationBar = self.navigationController?.navigationBar
        navigationItem.hidesBackButton = false
        
        navigationBar?.backgroundColor = .clear
       navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "Spark"
        
        
        
        
        
    }
    func placePlaces(_ places: [String: [Float]]) {
        for date in dateOrder! {
            let annotations = MKPointAnnotation()
            annotations.title = date
            annotations.coordinate = CLLocationCoordinate2D(latitude:
                CLLocationDegrees(places[date]![0]), longitude: CLLocationDegrees(places[date]![1]))
            mapView.addAnnotation(annotations)
        }
        centerMapOnUserLocation()
        
     
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor.rgb(red: 0, green: 166, blue: 215)
        renderer.lineWidth = 6.0
        
        return renderer
    }
    
    func setupView() {
        
        
        let iView = ItineraryView(frame: CGRect(x:0, y:self.view.frame.height * 0.8, width:self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(iView)
        let vc = ItineraryViewController()
        vc.delegate = self
        let navController = UINavigationController(rootViewController: vc)
        self.addChild(navController)
        iView.addSubview(navController.view)
        vc.imageDict = imageDict
        vc.dateInfo = dateInfo
        vc.dateOrder = dateOrder
        
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

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height * 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.05
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        scoreButton = UIButton()
        scoreButton.layer.cornerRadius = view.frame.height * 0.05
        scoreButton.backgroundColor = .gray
        scoreButton.setTitle(String(dateScores.reduce(0, +) / 3), for: .normal)
        scoreButton.addTarget(self, action: #selector(handleDropDown), for: .touchUpInside)
        return scoreButton
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showScores ? dateScores.count: 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var type: String
        let cell = tableView.dequeueReusableCell(withIdentifier: "scores", for: indexPath)
        switch indexPath.item {
        case 0:
            type = "Rating: "
        case 1:
            type = "Popularity: "
        case 2:
            type = "Distance: "
        default:
            type = ""
        }
        cell.textLabel?.font = .systemFont(ofSize: 8)
        cell.textLabel?.text = type + String(dateScores[indexPath.item])
        return cell
    }
        
    @objc func handleDropDown() {
        showScores = !showScores
        var indexPaths = [IndexPath]()
        for i in 0..<dateScores.count {
           indexPaths.append(IndexPath(row: i, section: 0))
        }
        if showScores {
           scoresTableView.removeConstraint(scoresTableView.constraints[1])
           scoresTableView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.25).isActive = true
           scoresTableView.insertRows(at: indexPaths, with: .none)
        } else {
           scoresTableView.deleteRows(at: indexPaths, with: .none)
           scoresTableView.removeConstraint(scoresTableView.constraints[1])
           scoresTableView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.1).isActive = true
        }
    }
}

extension UINavigationBar {
open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tapNavigationBar"), object: nil, userInfo: ["point": point, "event": event as Any])
    return super.hitTest(point, with: event)
    }
}
