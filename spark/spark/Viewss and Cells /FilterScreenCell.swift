//
//  FilterCell.swift
//  spark
//
//  Created by Joseph Yeh on 5/21/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class FilterScreenCell: UICollectionViewCell {
    
    
    
    let timeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Breakfast", for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.gray, for: .selected)
        button.layer.cornerRadius = 25
       
        return button
    }()
    
    
    
    
    
    
    let selectButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(.black, for: .normal)
        button.isUserInteractionEnabled = true
        
        
        button.layer.cornerRadius = 15
        
        return button
    }()
    

    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "yeet"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = UIColor.white
        
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupCell()
        
    }
    
    func setupCell() {
        addSubview(timeLabel)
        addSubview(selectButton)
        addConstraintsWithFormat(format: "H:|-90-[v0(30)]-15-[v1(200)]", views: selectButton, timeLabel)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: timeLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: selectButton)
        addConstraints([NSLayoutConstraint(item: selectButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: timeLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
    }
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}
