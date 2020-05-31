//
//  Filters.swift
//  spark
//
//  Created by Joseph Yeh on 5/20/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class Filters: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame:.zero, collectionViewLayout: layout)
        
        cv.backgroundColor = UIColor.flatBlue()
        
        return cv
        
    }()
    let cellId = "cellId"
    let blackView = UIView()
    
    
    
    
    
    
    func showFilters() {
        if let window = UIApplication.shared.keyWindow {
            
            self.blackView.backgroundColor = UIColor(white:0, alpha: 0.5)
            self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let height: CGFloat = 300
            let y = window.frame.height - height
            collectionView.frame = CGRect(x:0, y:window.frame.height, width:window.frame.width, height:height)
            self.blackView.frame = window.frame
            self.blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x:0, y:y, width:self.collectionView.frame.width, height:self.collectionView.frame.height)
            }, completion: nil)
            
            
        }
    }
    
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x:0, y:window.frame.height, width:self.collectionView.frame.width,
                                                   height:self.collectionView.frame.height)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    var selectionArray = ["Breakfast", "Lunch", "Dinner", "Snacc"]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FilterScreenCell
        cell.timeButton.backgroundColor = .init(randomFlatColorOf: .light)
        cell.timeLabel.text = selectionArray[indexPath.item]
        cell.selectButton.addTarget(self, action: #selector(selectTime(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func selectTime(_ sender: UIButton) {
        if !sender.isSelected {
            print("aaaaaaa")
            sender.backgroundColor = .black
            sender.isSelected = true
        }
        else {
            print("bbbbbbbbbbb")
            sender.backgroundColor = .clear
            sender.isSelected = false
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width, height:70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FilterScreenCell.self, forCellWithReuseIdentifier: cellId)
        
    }
}