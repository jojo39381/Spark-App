//
//  TypesController.swift
//  spark
//
//  Created by Joseph Yeh on 5/25/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class TypesController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DescriptionsDelegate, ActivityManagerDelegate, RestaurantsManagerDelegate ,CLLocationManagerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = typeList?.count
        return count!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CategoryCell
        myCell.category.text = typeList?[indexPath.item]
        myCell.contentView.backgroundColor = UIColor.init(randomColorIn: [UIColor.flatBlue(), UIColor.flatBlueColorDark(), UIColor.flatSkyBlue(), UIColor.flatRed(), UIColor.flatRedColorDark()])
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 20, height : 180)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myCell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        filterSelected(key: (typeList?[indexPath.item])!)
        
    }
    
    
    let typesCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right:10)
      
        return cv
    }()
    
    
    let instructions : UILabel = {
        let label = UILabel()
        label.text = "Choose your date"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    let dateModel = DateModel()
    var typeList: [String]?
    var userSelectedModel: UserSelectedModel!
    override func viewDidLoad() {
        view.addSubview(typesCollectionView)
        view.addSubview(instructions)
        view.backgroundColor = .white
        
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: instructions)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: typesCollectionView)
        view.addConstraintsWithFormat(format: "V:|-20-[v0]-20-[v1]-|", views: instructions, typesCollectionView )
     
        typesCollectionView.dataSource = self
        typesCollectionView.delegate = self
        typesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "myCell")
        typeList = dateModel.dateCategories
        setupNav()
        
        
        //user location things
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
        
        
        
    }
    
    func setupNav() {
        let navigationBar = self.navigationController?.navigationBar
        navigationItem.hidesBackButton = true
        navigationBar?.prefersLargeTitles = true
        navigationBar?.tintColor = .white
        navigationBar?.backgroundColor = .white
        self.title = "Spark"
    }
    func didSearchForDates(key: String) {
        
        
        var dict = [String:String]()
        for activity in userSelectedModel.preferences[key]! {
            dict.updateValue("", forKey: activity)
        }
        var manager = ActivityManager(categories: dict)
            manager.delegate = self
            manager.fetchActivities()
        
    }
    
    
    
    var restaurants: RestaurantModel!
    var activities: ActivityModel!
    func didLoadRestaurants(data: RestaurantModel) {
        restaurants = data
       DispatchQueue.main.async {

            let vc = ResultsViewController()
            vc.activityModel = self.activities
            vc.restaurantModel = self.restaurants
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func didLoadActivities(data: ActivityModel) {
        activities = data
        var dict = [String:String]()
        for food in userSelectedModel.preferences["Food"]! {
            dict.updateValue("", forKey: food)
        }
        
        var manager = RestaurantsManager(categories: dict)
        manager.delegate = self
        manager.fetchActivities()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    let descriptions = Descriptions()
    func filterSelected(key: String) {
        descriptions.delegate = self
        descriptions.key = key
        descriptions.showFilters()
        
        
        
        
        
    }
    
    
    //user location things
    var locationManager = CLLocationManager()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        print(userLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

var userLocation: CLLocation!
