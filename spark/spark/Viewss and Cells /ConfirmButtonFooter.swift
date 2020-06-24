//
//  ConfirmFooter.swift
//  spark
//
//  Created by Joseph Yeh on 6/15/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
class ConfirmButtonFooter: UICollectionReusableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("confirm", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 251, green: 228, blue: 85)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(confirmButton)
        self.addConstraintsWithFormat(format: "H:|-100-[v0]-100-|", views: confirmButton)
        self.addConstraintsWithFormat(format: "V:|-90-[v0]-50-|", views: confirmButton)
        
        
       
        
        
        
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
