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
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CategoryCell
        myCell.backgroundColor = .white
        myCell.category.text = exploreArray[indexPath.row]
        return myCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:140, height:140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        
        
    }
    
    var catCollectionView : UICollectionView = {
        let layout = CustomViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.flatSkyBlueColorDark()
        
        
        return cv
        
        
        
    }()
   
    
    
    
    
    
    
    
    
    
    let exploreArray = ["Exploratorium", "Golden gate", "California museum of art", "Soma", "Lmao", "Sorry", "hio"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    func setupView() {
 
        addSubview(catCollectionView)
        self.backgroundColor = UIColor.flatSkyBlueColorDark()
        
       
        addConstraintsWithFormat(format:"H:|-[v0]-|", views: catCollectionView)
        addConstraintsWithFormat(format:"V:|-[v0]-|", views: catCollectionView)
        
        catCollectionView.delegate = self
        catCollectionView.dataSource = self
        catCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "myCell")
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


