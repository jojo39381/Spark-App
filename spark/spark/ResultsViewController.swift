//
//  ResultsViewController.swift
//  spark
//
//  Created by Joseph Yeh on 5/23/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ResultsViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, ResultsDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 45
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dates.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lol", for: indexPath) as! ResultsCell
        myCell.numberOfItems = numActivities + 1
        myCell.setupViews()
        myCell.dateArray = dates[sortedDateScores[indexPath.item].key]!
        myCell.score.text = String(sortedDateScores[indexPath.item].value)
        myCell.contentView.backgroundColor = .white
        myCell.delegate = self
        
//        var activity = Array(activityModel.restaurants.keys)[Int.random(in: 0..<min(restaurantModel.restaurants.count, activityModel.restaurants.count))]
//        while (activityModel.restaurants[activity]?.filter () { (activityModel.restaurants[activity1]?.contains($0))!}.count)! > 0
//            {
//
//
//
//
//
//            let random = Int.random(in: 0..<min(restaurantModel.restaurants.count, activityModel.restaurants.count))
//            activity = Array(activityModel.restaurants.keys)[random]
//
//        }
//        
//
//        myCell.restaurant2.text = activity
        return myCell
    }
    
    
    
    var foodCentric = true
    var numActivities = 2
    var startDict: [String: [Any]]!
    var endDict: [String: [Any]]!
    var sortedDateScores = [Dictionary<String, Int>.Element]()
    var dates = [String: [String]]()
    
    func rateDates() {
        if foodCentric {
            startDict = restaurantModel.restaurants
            endDict = activityModel.restaurants
        } else {
            startDict = activityModel.restaurants
            endDict = restaurantModel.restaurants
        }
        var i = 0
        var dateScores = [String: Int]()
        for initialPlace in calculateScore(startName: "userLocation", startLocation: userLocation, startDict: ["userLocation": [["userLocation"]]], endDict: startDict).sorted(by: {$0.1 > $1.1}) {
            let date = makeDate(initialPlace: initialPlace)
            dateScores["Date \(i)"] = date[0] as? Int
            dates["Date \(i)"] = Array(date[1..<date.count]) as? [String]
            i += 1
        }
        sortedDateScores = dateScores.sorted {$0.1 > $1.1}
    }
    
    func makeDate(initialPlace: Dictionary<String, Int>.Element) -> [Any] {
        var startP = startDict!
        var endP = endDict!
        var date = [Any]()
        var startPlace = initialPlace
        date.append(startPlace.value)
        date.append(startPlace.key)
        for _ in 1...self.numActivities {
            let startCord = startP[startPlace.key]![3] as! [Float]
            startPlace = self.calculateScore(startName: startPlace.key, startLocation: CLLocation(latitude: CLLocationDegrees(startCord[0]), longitude: CLLocationDegrees(startCord[1])), startDict: startP, endDict: endP).sorted {$0.1 > $1.1}.first!
            date[0] = date[0] as! Int + startPlace.value
            date.append(startPlace.key)
            startP = endP
            endP = activityModel.restaurants
        }
        date[0] = date[0] as! Int / (self.numActivities + 1)
        return date
    }
    
    func calculateScore(startName: String, startLocation: CLLocation, startDict: [String: [Any]], endDict: [String: [Any]]) -> [String: Int] {
        var dateScore = [String: Int]()
        for end in endDict {
            if (startName != end.key) {
                let startCats = startDict[startName]![0] as! [String]
                let endCats = end.value[0] as! [String]
                var same = false
                for startCat in startCats {
                    for endCat in endCats {
                        same = (startCat == endCat) || same
                    }
                }
                if !same {
                    let endCord = end.value[3] as! [Float]
                    let distance = Int(calculateDistance(startLocation: startLocation, endLocation: CLLocation(latitude: CLLocationDegrees(endCord[0]), longitude: CLLocationDegrees(endCord[1]))))
                    let distanceScore = (1 - distance * 1000 / radius) * 33
                    let ratingScore = end.value[1] as! Float / 5 * 33
                    let reviewScore = min(end.value[2] as! Float / 500 * 33, 33)
                    dateScore[end.key] = Int(Float(distanceScore) + ratingScore + reviewScore)
                    print(dateScore[end.key])
                }
            }
        }
        return dateScore
    }
    
    func calculateDistance(startLocation: CLLocation, endLocation: CLLocation) -> Double {
        let lat1 = startLocation.coordinate.latitude
        let lon1 = startLocation.coordinate.longitude
        let lat2 = endLocation.coordinate.latitude
        let lon2 = endLocation.coordinate.longitude
        
        let p = 0.017453292519943295;    // Math.PI / 180
        let a = 0.5 - cos((lat2 - lat1) * p)/2 +
              cos(lat1 * p) * cos(lat2 * p) *
              (1 - cos((lon2 - lon1) * p))/2

      return 12742 * asin(sqrt(a)) // 2 * R; R = 6371 km
    }
    
    func calculateTime(startLocation: CLLocation, endLocation: CLLocation, completion: @escaping (Int) -> ()) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: startLocation.coordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: endLocation.coordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = false // if you want multiple possible routes
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        directions.calculate {(response, error) in

            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }

          // Lets Get the first suggested route and its travel time
            if response.routes.count > 0 {
                let route = response.routes[0]
                completion(Int(route.expectedTravelTime))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.8, height: 500)
    }
    
    
    let resultsCollectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.register(ResultsCell.self, forCellWithReuseIdentifier: "lol")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    
    
    
    var restaurantModel:RestaurantModel!
    var activityModel: ActivityModel!
    var userSelectedModel: UserSelectedModel!
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        rateDates()
        
        view.addSubview(resultsCollectionView)
        
        
        
        resultsCollectionView.frame = CGRect(x:0,y:0,width:view.frame.width, height:view.frame.height)
        
        resultsCollectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
        setupNav()
        
        print(restaurantModel.restaurants)
    }
    
    
    func setupNav() {
        let navigationBar = self.navigationController?.navigationBar
        navigationItem.hidesBackButton = true
        navigationBar?.prefersLargeTitles = true
        navigationBar?.tintColor = .white
        navigationBar?.backgroundColor = .white
        self.title = "Spark"
    }
    
    
    func goToDetails(dateArray : [String]) {
        let vc = DetailsViewController()
        var dateDict = [String: [Float]]()
        
        for act in dateArray {
            if activityModel.restaurants[act] != nil {
                dateDict.updateValue(activityModel.restaurants[act]![3] as! [Float], forKey: act)
            }
            else {
                dateDict.updateValue(restaurantModel.restaurants[act]![3] as! [Float], forKey: act)
            }
        }
            
        vc.dateDict = dateDict
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}

