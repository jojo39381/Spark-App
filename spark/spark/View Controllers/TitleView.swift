//
//  ConfirmFooter.swift
//  spark
//
//  Created by Joseph Yeh on 6/15/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
class TitleView: UICollectionReusableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addConstraintsWithFormat(format: "H:|-[v0]-|", views: titleLabel)
        self.addConstraintsWithFormat(format: "V:|-[v0]-|", views: titleLabel)
        
        
       
        
        
        
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
