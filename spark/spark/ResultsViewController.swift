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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(restaurantModel.restaurants.count)
        print(activityModel.restaurants.count)
        
        
        return min(restaurantModel.restaurants.count, activityModel.restaurants.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lol", for: indexPath) as! ResultsCell
        myCell.restaurant.text = "1. " + restaurantModel.restaurants[indexPath.item]
        myCell.contentView.backgroundColor = UIColor.randomFlat()
        myCell.activity.text = "2. " + activityModel.restaurants[indexPath.item]
        myCell.restaurant2.text = "3. " + activityModel.restaurants[Int.random(in: 0..<min(restaurantModel.restaurants.count, activityModel.restaurants.count))]
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.8, height: 400)
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
    
    override func viewDidLoad() {
        view.addSubview(resultsCollectionView)
        resultsCollectionView.frame = CGRect(x:0,y:0,width:view.frame.width, height:view.frame.height)
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
        
    }
    
    
    
    
    
    
    
}

class ResultsCell: UICollectionViewCell {
    let restaurant: UILabel = {
        let label = UILabel()
        label.text = "haha"
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    let activity: UILabel = {
        let label = UILabel()
        label.text = "haha"
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"checkmark")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .white
        image.alpha = 0
        return image
    }()
    
    let score:UILabel = {
        let label = UILabel()
        label.text = "95"
        label.textAlignment = .center
        label.font = label.font.withSize(50)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    let restaurant2: UILabel = {
        let label = UILabel()
        label.text = "haha"
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(restaurant)
        contentView.addSubview(imageView)
        contentView.addSubview(activity)
        contentView.addSubview(score)
        contentView.addSubview(restaurant2)
        imageView.frame = CGRect(x:frame.width - 35,y:20, width:20, height:20)
        restaurant.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height:0)
        activity.anchor(top: restaurant.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: restaurant.frame.height + 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        restaurant2.anchor(top: activity.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: activity.frame.height + 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        score.frame = CGRect(x: 0, y: 20, width:100, height: 50)
        
        
        
        
        
        self.contentView.layer.cornerRadius = 35
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)//CGSizeMake(0, 2.0);
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
        
        
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}
