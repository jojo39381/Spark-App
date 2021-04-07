//
//  HomeViewController.swift
//  spark
//
//  Created by Joseph Yeh on 6/30/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var userLocation: CLLocation!
var radius = 40000



class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITabBarDelegate, CLLocationManagerDelegate, ActivityManagerDelegate{
    
    let cellId = "cellId"
    var locationManager = CLLocationManager()
    var locationSet: Bool? {
        didSet {
            didSearchForDates(key: "")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("/////////////////////")
        userLocation = locations.last
        locationSet = true
        print(userLocation)
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        collectionView?.backgroundColor = .white
        
       
        collectionView?.register(ExploreViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(IntroHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
        
    
    }
    
    func goToPlace(place: Place) {
        print("/asdasd")
        DispatchQueue.main.async {

            let vc = PlaceViewController()
            vc.place = place
        
            self.navigationController?.pushViewController(vc, animated: true)
                    
                  
                   
               }
        
    }
   
    func didSearchForDates(key: String) {
            
            
            var dict = ["tourist":""]
            
    //        for activity in userSelectedModel.preferences[key]! {
    //            dict.updateValue("", forKey: activity)
    //        }
            var manager = ActivityManager(categories: dict, budget:["2"])
                manager.delegate = self
                manager.fetchActivities()
            
        }
        

        var activities: ActivityModel!
        var datesArray = [Place]()
        func didLoadActivities(data: ActivityModel) {
            activities = data
    //        var dict = [String:String]()
    //        for food in userSelectedModel.preferences["Food"]! {
    //            dict.updateValue("", forKey: food)
    //        }
            datesArray = self.activities.activities
            DispatchQueue.main.async {

                self.collectionView.reloadData()
                
                        print(self.activities)
                        
                      
                       
                   }
            
    
    }
    
 
        
    var dateCategories = ["Popular Adventures", "Nearby Adventures", "Shopping", "Food"]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreViewCell
        cell.homeViewController = self
        cell.datesArray = datesArray
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
        header.updateCellWithName(name: "John")
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }


}
