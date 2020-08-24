//
//  TypesController.swift
//  spark
//
//  Created by Joseph Yeh on 5/25/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation
import UIKit

class TypesController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DescriptionsDelegate, ActivityManagerDelegate, RestaurantsManagerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = typeList?.count
        return count!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CategoryCell
        myCell.category.text = typeList?[indexPath.item]
        myCell.contentView.backgroundColor = colors[indexPath.item]
        
        return myCell
    }
    
    var colors = [UIColor.flatBlueColorDark(), UIColor.flatRed(), UIColor.flatMint(), UIColor.flatPowderBlueColorDark(), UIColor.flatYellowColorDark(), UIColor.flatTeal()]
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 20, height : 180)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
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
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right:10)
      
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
    var userSelectedModel = UserSelectedModel()
    override func viewDidLoad() {
        userSelectedModel.preferences = preferences
        view.addSubview(typesCollectionView)
        view.addSubview(instructions)
        view.backgroundColor = .white
        
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: instructions)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: typesCollectionView)
        view.addConstraintsWithFormat(format: "V:|-50-[v0]-20-[v1]|", views: instructions, typesCollectionView )
        typesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
     
        typesCollectionView.dataSource = self
        typesCollectionView.delegate = self
        typesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "myCell")
        typeList = dateModel.dateCategories
        setupNav()
        
        
        
        
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
        
        
        var dict = ["tourist":""]
        
//        for activity in userSelectedModel.preferences[key]! {
//            dict.updateValue("", forKey: activity)
//        }
        var manager = ActivityManager(categories: dict, budget:["2"])
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
            
        
        
        
        
        
        
        
        
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func didLoadActivities(data: ActivityModel) {
        activities = data
//        var dict = [String:String]()
//        for food in userSelectedModel.preferences["Food"]! {
//            dict.updateValue("", forKey: food)
//        }
        
        DispatchQueue.main.async {

                   let vc = ResultsViewController()
                   vc.activityModel = self.activities
                    vc.dateTitles = Array(self.activities.restaurants.keys)
            
                  
                   self.navigationController?.pushViewController(vc, animated: true)
               }
        
//        var manager = RestaurantsManager(categories: dict, budget:userSelectedModel.preferences["Budget"]! )
//        manager.delegate = self
//        manager.fetchActivities()
//
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    let descriptions = Descriptions()
    func filterSelected(key: String) {
        descriptions.delegate = self
        descriptions.key = key
        descriptions.showFilters()
        
        
        
    }
}
