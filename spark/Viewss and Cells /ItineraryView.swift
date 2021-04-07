//
//  ItineraryView.swift
//  spark
//
//  Created by Joseph Yeh on 6/3/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class ItineraryView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    var placeTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    
    var descriptionLabel: UILabel = {
        let label =  UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.isUserInteractionEnabled = true
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 15
        self.clipsToBounds = false
        self.addSubview(placeTitle)
        self.addSubview(descriptionLabel)
        placeTitle.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        descriptionLabel.anchor(top: placeTitle.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    
    
}
