//
//  ResultsViewController.swift
//  spark
//
//  Created by Joseph Yeh on 5/23/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 45
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(restaurantModel.restaurants.count)
        print(activityModel.restaurants.count)
        
        
        return min(restaurantModel.restaurants.count, activityModel.restaurants.count)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lol", for: indexPath) as! ResultsCell
        myCell.sections = 5
        myCell.setupViews()
        myCell.restaurant.text = Array(restaurantModel.restaurants.keys)[indexPath.item]
        myCell.contentView.backgroundColor = UIColor.white
        let activity1 = Array(activityModel.restaurants.keys)[indexPath.item]
        myCell.activity.text = activity1
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
    
    
    
//    var food: bool + true/false
//    var numActivities = ??????
//
//
//
//    dates : [["steakhouse" 95, "beaches" 95, "movie1" 100]]
//    food : ["steakhouse", "top dog", "super duper", "riceful", "sweatheart", "kimchi garden", "t toust"]
//
//
//    activitity: ["beaches", "movie1", "movie2", "museum1", "park", "observatory", "theater", "hiking"]
//
//
//
//    dateScoreArray = sorted date activities
//
//    for act in number of activities {
//
//        func sort(dict: dict) {
//
//            return dateScoreArray
//
//        }
//
//        for act in activity {
//
//            if act != pointer | string comparison == false {
//            calculate(act, pointer, act.rating, act.popularity)
//            return [act:datescore]
//        }
//
//        }
//
//
//    }
//
//    func calculate() {
//
//    }
//
//
    
    
    
    
    
    
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
    override func viewDidLoad() {
        view.addSubview(resultsCollectionView)
        resultsCollectionView.frame = CGRect(x:0,y:0,width:view.frame.width, height:view.frame.height)
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
    
    
    
    
    
    
}

class ResultsCell: UICollectionViewCell {
    let restaurant: UILabel = {
        let label = UILabel()
        label.text = "haha"
        label.textAlignment = .center
        label.font = label.font.withSize(25)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    let activity: UILabel = {
        let label = UILabel()
        label.text = "haha"
        label.textAlignment = .center
        label.font = label.font.withSize(25)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"dining")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .black
        image.alpha = 1
        return image
    }()
    
    let score:UILabel = {
        let label = UILabel()
        label.text = "95"
        label.textAlignment = .center
        label.font = label.font.withSize(50)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    let restaurant2: UILabel = {
        let label = UILabel()
        label.text = "haha"
        label.textAlignment = .center
        label.font = label.font.withSize(25)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    let imageView2: UIImageView = {
           let image = UIImageView()
           image.image = UIImage(named:"activity1")?.withRenderingMode(.alwaysTemplate)
           image.tintColor = .black
           image.alpha = 1
           return image
       }()
    let imageView3: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"activity1")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .black
        image.alpha = 1
        return image
    }()
    
    
    var sections = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
            
    }
    
    
    func setupViews() {

         contentView.addSubview(activity)
         contentView.addSubview(score)
         contentView.addSubview(restaurant2)
         score.frame = CGRect(x: 0, y: 20, width:100, height: 50)
         let view1 = UIView(frame: CGRect(x:0,y:70,width:self.frame.width,height:(self.frame.height - 70)/CGFloat(sections)))
         contentView.addSubview(view1)
         
         view1.addSubview(imageView)
         view1.addSubview(restaurant)
         print("//////////////")
         print((self.frame.height - 70)/CGFloat(sections) + 70)
         addConstraintsWithFormat(format: "H:|-20-[v0(50)]-[v1]-20-|", views: imageView, restaurant)
       
         addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: view1, attribute: .centerY, multiplier: 1, constant: 0)])
         addConstraints([NSLayoutConstraint(item: restaurant, attribute: .centerY, relatedBy: .equal, toItem: view1, attribute: .centerY, multiplier: 1, constant: 0)])
         let view2 = UIView(frame: CGRect(x:0,y:(self.frame.height - 70)/CGFloat(sections) + 70,width:self.frame.width,height:(self.frame.height - 70)/CGFloat(sections)))
         contentView.addSubview(view2)
         
         view2.addSubview(imageView2)
         view2.addSubview(activity)
        
         addConstraintsWithFormat(format: "H:|-20-[v0(50)]-[v1]-20-|", views: imageView2, activity)
         addConstraints([NSLayoutConstraint(item: imageView2, attribute: .centerY, relatedBy: .equal, toItem: view2, attribute: .centerY, multiplier: 1, constant: 0)])
         addConstraints([NSLayoutConstraint(item: activity, attribute: .centerY, relatedBy: .equal, toItem: view2, attribute: .centerY, multiplier: 1, constant: 0)])
         
         let view3 = UIView(frame: CGRect(x:0,y:(self.frame.height - 70)/CGFloat(sections) * 2 + 70,width:self.frame.width,height:(self.frame.height - 70)/CGFloat(sections)))
         contentView.addSubview(view3)
         
         view3.addSubview(imageView3)
         view3.addSubview(restaurant2)
         addConstraintsWithFormat(format: "H:|-20-[v0(50)]-[v1]-20-|", views: imageView3, restaurant2)
         addConstraints([NSLayoutConstraint(item: imageView3, attribute: .centerY, relatedBy: .equal, toItem: view3, attribute: .centerY, multiplier: 1, constant: 0)])
         addConstraints([NSLayoutConstraint(item: restaurant2, attribute: .centerY, relatedBy: .equal, toItem: view3, attribute: .centerY, multiplier: 1, constant: 0)])
         
         
         self.contentView.layer.cornerRadius = 35
         self.contentView.layer.borderWidth = 1.0
         self.contentView.layer.borderColor = UIColor.clear.cgColor
         self.contentView.layer.masksToBounds = true

         
         self.layer.shadowColor = UIColor.gray.cgColor
         self.layer.shadowOffset = CGSize(width: 0, height: 7.0)//CGSizeMake(0, 2.0);
         self.layer.shadowRadius = 17
         self.layer.shadowOpacity = 0.5
         self.layer.masksToBounds = false
         self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}
