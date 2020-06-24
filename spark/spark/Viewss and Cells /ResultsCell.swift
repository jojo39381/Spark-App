//
//  ResultsCell.swift
//  spark
//
//  Created by Joseph Yeh on 6/1/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//
    
import UIKit

protocol ResultsDelegate {
    func goToDetails(dateArray: [String])
}

class ResultsCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! DatesCell
        myCell.activity.text = dateArray[indexPath.item]
        print(dateArray)
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       print(self.contentView.frame.height/CGFloat(numberOfItems))
        
        return CGSize(width: self.contentView.frame.width, height: (self.contentView.frame.height - 70)/CGFloat(numberOfItems))
    }

    
    let score: UILabel = {
        let label = UILabel()
        label.text = "95"
        label.textAlignment = .center
        label.font = label.font.withSize(50)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
  
    let dateCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.allowsSelection = true
        cv.isScrollEnabled = false
        return cv
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
        score.frame = CGRect(x: 0, y: 20, width:100, height: 50)
        contentView.addSubview(dateCollectionView)
        
        dateCollectionView.frame = CGRect(x:0, y: 70, width: self.frame.width, height: self.frame.height - 70)
        dateCollectionView.register(DatesCell.self, forCellWithReuseIdentifier: "myCell")
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self
        
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
        delegate?.goToDetails(dateArray: dateArray)
        
    }
    
    
}
