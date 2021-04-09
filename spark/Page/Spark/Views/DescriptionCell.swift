//
//  FilterCell.swift
//  spark
//
//  Created by Joseph Yeh on 5/21/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class DescriptionCell: UICollectionViewCell {
    
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Imagine going to that boba shop that you guys both know, then going to see the city stars, staring into the night sky ;) ."
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Chill"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        
        return label
    }()
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("next", for: .normal)
        button.backgroundColor = .blue
        
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupCell()
            
        
    }
    
    
    func setupCell() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(nextButton)
        
        
        addConstraintsWithFormat(format: "H:|-20-[v0]", views: titleLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0(25)]-[v1(80)]-[v2(25)]", views: titleLabel, descriptionLabel, nextButton)
        addConstraintsWithFormat(format: "H:|-20-[v0]-10-|", views: descriptionLabel)
        addConstraintsWithFormat(format: "H:[v0(70)]-20-|", views: nextButton)
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}
