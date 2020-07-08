//
//  DatesCell.swift
//  spark
//
//  Created by Joseph Yeh on 6/2/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class DatesCell: UICollectionViewCell {
    
    
   
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(activity)
        contentView.addSubview(imageView)
        addConstraintsWithFormat(format: "H:|-20-[v0(50)]-[v1]-20-|", views: imageView, activity)
        
        addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: activity, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
         
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    
   
       
    
    
    
    
    
    
    
    
}
