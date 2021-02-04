//
//  InfoCollectionViewCell.swift
//  spark
//
//  Created by Joseph Yeh on 11/30/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    
    
    var iconImage: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    var infoLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    var infoDetail: UILabel = {
        var label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupCell()
        
        
    }
    
    func setupCell() {
        self.addSubview(iconImage)
        self.addSubview(infoLabel)
        self.addSubview(infoDetail)
        iconImage.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        infoLabel.anchor(top: iconImage.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        infoDetail.anchor(top: infoLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}
