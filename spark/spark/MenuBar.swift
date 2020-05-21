//
//  MenuBar.swift
//  spark
//
//  Created by Joseph Yeh on 5/20/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation
import UIKit

protocol MenuViewDelegate: class {
    func filterSelected()
}
class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("lmao")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FilterCell
        cell.menuButton.setTitle(buttonName[indexPath.item], for: .normal)
        cell.menuButton.addTarget(self, action: #selector(menuButtonPressed(_:)), for: .touchUpInside)
        return cell
    }
    @objc func pressed(_ sender: UIButton) {
        print("lol")
    }
    @objc func menuButtonPressed(_ sender: UIButton) {
        delegate?.filterSelected()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(frame.width - 60)/2, height:frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    let cellId = "cellId"
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    let timeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Time", for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    let budgetButton: UIButton = {
        let button = UIButton()
        button.setTitle("$$$", for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    
    var delegate: MenuViewDelegate?
    var button: UIButton!
    let buttonName = ["time", "$$$"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(FilterCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
}




class FilterCell: UICollectionViewCell {
    let menuButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.gray, for: .selected)
        button.layer.cornerRadius = 15
        
        return button
    }()
    override init(frame:CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    
    func setupViews() {
        
        contentView.addSubview(menuButton)
        
        addConstraintsWithFormat(format: "H:[v0(120)]", views: menuButton)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: menuButton)
        addConstraints([NSLayoutConstraint(item: menuButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: menuButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        
    }
    required init?(coder aDecoder:NSCoder){
        fatalError("error")
    }
}
