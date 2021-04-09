//
//  CollectionViewCell.swift
//  spark
//
//  Created by Joseph Yeh on 5/28/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit


class ExploreViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return datesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CategoryCell
        myCell.backgroundColor = .white
//        myCell.category.text = Array(datesArray.keys)[indexPath.item]
        let name = datesArray[indexPath.item].name
        myCell.dateInfo = datesArray[indexPath.item]
        return myCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:190, height:150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        homeViewController?.goToPlace(place: datesArray[indexPath.item])
        
        
        
    }
    var homeViewController: HomeViewController?
    var catCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        
        
        return cv
        
        
        
    }()
   
    
    
    
    var datesArray = [Place]()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 5, right: 0)
    }
    
    let catLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular Adventures"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let exploreArray = ["Exploratorium", "Golden gate", "California museum of art", "Soma", "Lmao", "Sorry", "hio"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    func setupView() {
 
        addSubview(catCollectionView)
        addSubview(catLabel)
       
        self.backgroundColor = UIColor.white
        
        catLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        catCollectionView.anchor(top: catLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        catCollectionView.delegate = self
        catCollectionView.dataSource = self
        catCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "myCell")
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


