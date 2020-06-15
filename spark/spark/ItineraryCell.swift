//
//  ItineraryCell.swift
//  spark
//
//  Created by Joseph Yeh on 6/3/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import MapKit
class ItineraryCell: UICollectionViewCell  {
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage()
        return image
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        return label
    }()
    var star: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        return imageView
    }()
    
    
     var review: UILabel = {
           let label = UILabel()
           label.textColor = .black
           label.font = UIFont.systemFont(ofSize: 15)
           return label
       }()
    
    
    
     var address: UILabel = {
           let label = UILabel()
           label.textColor = .black
           label.font = UIFont.systemFont(ofSize: 15)
           label.numberOfLines = 0
           
           return label
       }()
    var category: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    var goButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 3, green: 90, blue: 166)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    var deleteButton: UIButton = {
        let button = UIButton()
        let origImage = UIImage(named: "delete")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        contentView.addSubview(star)
        contentView.backgroundColor = .white
        let info = UIView(frame:.zero)
        
    
        contentView.addSubview(info)
        contentView.addSubview(deleteButton)
        deleteButton.frame = CGRect(x:6, y:6, width: 30, height: 30)
        
        
       contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: info)
       contentView.addConstraintsWithFormat(format: "V:|[v0(200)][v1]|", views: imageView, info)
        
        info.addSubview(title)
        
        
        info.addSubview(star)
        
        info.addSubview(review)
        
        info.addSubview(address)
        
       
       
        info.addSubview(goButton)
        
       
        
        info.addConstraintsWithFormat(format:"H:|-[v0]-|", views: title)
       
        info.addConstraintsWithFormat(format:"H:|-[v0]", views: address)
        info.addConstraintsWithFormat(format:"H:[v0(80)]-20-|", views: goButton)
        info.addConstraintsWithFormat(format:"V:[v0(50)]", views: goButton)
        info.addConstraints([NSLayoutConstraint(item: goButton, attribute: .centerY, relatedBy: .equal, toItem: address, attribute: .centerY, multiplier: 1, constant: 0)])
        info.addConstraintsWithFormat(format: "H:|-[v0(20)]-10-[v1]", views: star, review)
        info.addConstraintsWithFormat(format: "V:|-[v0][v1]-[v2(20)]-|", views: title, address, star)
        info.addConstraintsWithFormat(format: "V:[v0]-[v1(20)]-|", views: address, review)
        
      
        
        
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
       contentView.layer.cornerRadius = 15
       contentView.layer.borderWidth = 1.0
       contentView.layer.borderColor = UIColor.clear.cgColor
       contentView.layer.masksToBounds = true;
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 7.0)//CGSizeMake(0, 2.0);
        self.layer.shadowRadius = 17
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
   
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}
