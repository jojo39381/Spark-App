//
//  DayView.swift
//  spark
//
//  Created by Joseph Yeh on 6/25/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class DayView: UIView {
    
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    var viewButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 23
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.setTitle("View Dates", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    var inviteButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 23
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.setTitle("Invite Friends", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    var remindButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 23
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.setTitle("Set Reminder", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
           super.init(frame:frame)
           setupCell()
               
           
       }
       
       
       func setupCell() {
        self.addSubview(dateLabel)
        
        self.addConstraintsWithFormat(format: "H:|-10-[v0]", views: dateLabel)
        self.addConstraintsWithFormat(format: "V:|-10-[v0]", views: dateLabel)
        self.addSubview(viewButton)
        self.addSubview(inviteButton)
         self.addSubview(remindButton)
        self.addConstraintsWithFormat(format: "H:[v0(200)]", views: viewButton)
        self.addConstraintsWithFormat(format: "V:|-100-[v0(50)]-10-[v1(50)]-10-[v2(50)]", views: viewButton, inviteButton, remindButton)
        self.addConstraints([NSLayoutConstraint(item: viewButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        
        self.addConstraintsWithFormat(format: "H:[v0(200)]", views: inviteButton)
        
        self.addConstraints([NSLayoutConstraint(item: inviteButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.layer.cornerRadius = 20
     
        self.addConstraintsWithFormat(format: "H:[v0(200)]", views: remindButton)
        
        self.addConstraints([NSLayoutConstraint(item: remindButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.layer.cornerRadius = 20
           
           
           
           
           
           
       }
       required init?(coder: NSCoder) {
           fatalError("error")
       }
    
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
