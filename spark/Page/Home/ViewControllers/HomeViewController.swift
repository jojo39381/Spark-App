//
//  HomeViewController.swift
//  spark
//
//  Created by Joseph Yeh on 6/30/20.
//  Modified by Tinna Liu, Peter Li on 5/1/21.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var userLocation: CLLocation!
var radius = 40000



class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITabBarDelegate, CLLocationManagerDelegate, ActivityManagerDelegate{
    
    let cellId = "cellId"
    var allAdventures = [Array<Place>]()
    var locationManager = CLLocationManager()
    var locationSet: Bool? {
        didSet {
            didSearchForDates(key: "")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        locationSet = true
        print(userLocation)
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
       
        collectionView?.register(ExploreViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(IntroHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    }
    
    func goToPlace(place: Place) {
        print("go to place")
        DispatchQueue.main.async {

            let vc = PlaceViewController()
            vc.place = place
        
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
   
    func didSearchForDates(key: String) {
        var dict = ["chill":"", "romantic":"", "casual":"", "adventurous":"", "tourist":"", "random":""]
            
    //        for activity in userSelectedModel.preferences[key]! {
    //            dict.updateValue("", forKey: activity)
    //        }
            var manager = ActivityManager(categories: dict, budget:["2"])
                manager.delegate = self
                manager.fetchActivities()
        }

        var activities: ActivityModel!
        var popularArray = [Place]()
        var nearbyArray = [Place]()
        var ratingArray = [Place]()
        func didLoadActivities(data: ActivityModel) {
            activities = data
    //        var dict = [String:String]()
    //        for food in userSelectedModel.preferences["Food"]! {
    //            dict.updateValue("", forKey: food)
    //        }
            for place in self.activities.activities {
                if place.numReviews > 200 && !popularArray.contains(place) {
                    popularArray.append(place)
                }
                if findRadius(place: place) < 2 && !nearbyArray.contains(place) {
                    nearbyArray.append(place)
                }
                if place.ratings > 4.5 && findRadius(place: place) < 30 {
                    ratingArray.append(place)
                }
            }
            allAdventures = [popularArray, nearbyArray, ratingArray]
//            datesArray = self.activities.activities
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                        print(self.activities)
            }
    }
    
    func findRadius(place: Place) -> Float {
        let placeLat = place.coordinates.latitude
        let placeLon = place.coordinates.longitude
        let userLat = userLocation.coordinate.latitude
        let userLon = userLocation.coordinate.longitude
        let radiusMiles = pow((pow(placeLat - Float(userLat), 2) + pow(placeLon - Float(userLon), 2)), 1/2) * 69
        return radiusMiles
    }
        
    var dateCategories = ["Popular Adventures", "Nearby Adventures", "High Rating Adventures"]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreViewCell
        cell.homeViewController = self
        if allAdventures.count == 3 {
            cell.datesArray = allAdventures[indexPath.item]
        } else {
            cell.datesArray = nearbyArray
        }
        cell.catLabel.text = dateCategories[indexPath.item]
        cell.catCollectionView.reloadData()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width)
        return CGSize(width: width, height: width/2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! IntroHeader
        header.updateCellWithName(name: username)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
}
