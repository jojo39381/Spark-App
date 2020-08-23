//
//  ResultsCell.swift
//  spark
//
//  Created by Joseph Yeh on 6/1/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//
    
import UIKit

protocol ResultsDelegate {
    func goToDetails(dateTitle: String)
}

class ResultsCell: UICollectionViewCell, UIGestureRecognizerDelegate {
   
    
    let score: UILabel = {
        let label = UILabel()
        label.text = "95"
        label.textAlignment = .center
        label.font = label.font.withSize(30)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
  
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    
    
    var numberOfItems = 0
    var dateArray = [String]()
    var tapGestureRecognizer : UITapGestureRecognizer!
    var delegate: ResultsDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
            
    }
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    
    
    func setupViews() {
        
        contentView.addSubview(score)
        score.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: score.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        contentView.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
         self.contentView.layer.cornerRadius = 35
         self.contentView.layer.borderWidth = 1.0
         self.contentView.layer.borderColor = UIColor.clear.cgColor
         self.contentView.layer.masksToBounds = true

         
         self.layer.shadowColor = UIColor.gray.cgColor
         self.layer.shadowOffset = CGSize(width: 0, height: 7.0)//CGSizeMake(0, 2.0);
         self.layer.shadowRadius = 17
         self.layer.shadowOpacity = 0.5
         self.layer.masksToBounds = false
         self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.tapGestureRecognizer.delegate = self
        self.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func handleTap() {
        delegate?.goToDetails(dateTitle: titleLabel.text!)
        
    }
    
    
    
}
