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
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! SelectCell
        return myCell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        
        
    }
    
    var catCollectionView : UICollectionView = {
        let layout = CustomViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 27, green: 108, blue: 168)
        
        
        return cv
        
        
        
    }()
   
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    func setupView() {
 
        addSubview(catCollectionView)
        self.backgroundColor = .blue
        catCollectionView.backgroundColor = .black
       
        addConstraintsWithFormat(format:"H:|-20-[v0]-20-|", views: catCollectionView)
        addConstraintsWithFormat(format:"V:|-10-[v0]-10-|", views: catCollectionView)
        
        catCollectionView.delegate = self
        catCollectionView.dataSource = self
        catCollectionView.register(SelectCell.self, forCellWithReuseIdentifier: "myCell")
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


