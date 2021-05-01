//
//  ResultsCell.swift
//  spark
//
//  Created by Joseph Yeh on 6/1/20.
//  Modified by Tinna Liu, Peter Li on 5/1/21.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//
    
import UIKit


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
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15)
       
        return label
    }()
    
    
    let placeImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    
    let stack : UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
       
    let ratingLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .gray
        
        return label
    }()
    
    let reviewLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        
        return label
    }()
    
    var numberOfItems = 1
    var dateArray = [String]()
    var tapGestureRecognizer : UITapGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    func setupViews() {
        self.addSubview(placeImageView)
        self.addSubview(stack)
        stack.addArrangedSubview(placeImageView)
        stack.backgroundColor = .white
        let sv2 = UIStackView()
        placeImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        placeImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        placeImageView.backgroundColor = .white
        sv2.alignment = .fill
        sv2.distribution = .fill
        sv2.axis = .vertical
        sv2.addArrangedSubview(titleLabel)
        sv2.addArrangedSubview(descriptionLabel)
        stack.addArrangedSubview(sv2)
        stack.spacing = 20
        stack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: -10, width: 0, height: 0)
        self.addSubview(ratingLabel)
        self.addSubview(reviewLabel)
        ratingLabel.anchor(top: stack.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        reviewLabel.anchor(top: stack.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: -20, width: 0, height: 0)
        self.backgroundColor = .white
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(roundedRect: CGRect(x: -shadowSize / 2,
        y: -shadowSize / 2,
        width: self.frame.size.width
            + shadowSize,
        height: self.frame.size.height + shadowSize), cornerRadius: 15)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.5
                self.layer.shadowRadius = 2
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 15
                self.clipsToBounds = false
            self.layer.shadowPath = shadowPath.cgPath
    }
}
