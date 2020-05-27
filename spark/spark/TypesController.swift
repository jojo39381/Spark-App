//
//  TypesController.swift
//  spark
//
//  Created by Joseph Yeh on 5/25/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation
import UIKit
class TypesController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = typeList?.count
        return count!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CategoryCell
        myCell.category.text = typeList?[indexPath.item]
        myCell.contentView.backgroundColor = UIColor.init(randomColorIn: [UIColor.flatBlue(), UIColor.flatBlueColorDark(), UIColor.flatSkyBlue(), UIColor.flatRed(), UIColor.flatRedColorDark()])
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3 - 20, height : 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myCell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        filterSelected()
        
    }
    
    
    let typesCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        cv.contentInset = UIEdgeInsets(top: 60, left: 20, bottom: 10, right: 20)
        return cv
    }()
    
    
    
    
    
    let dateModel = DateModel()
    var typeList: [String]?
    override func viewDidLoad() {
        view.addSubview(typesCollectionView)
        typesCollectionView.frame = view.frame
        typesCollectionView.dataSource = self
        typesCollectionView.delegate = self
        typesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "myCell")
        typeList = dateModel.dateCategories
        
        
        
        
        
        
        
        
    }
    
    let descriptions = Descriptions()
    func filterSelected() {
        descriptions.showFilters()
        
        
        
        
        
    }
    


}
