//
//  HomeViewController.swift
//  spark
//
//  Created by Joseph Yeh on 6/30/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! ExploreViewCell
        
        return myCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.view.frame.width * 0.8, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }

    var exploreView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame:.zero, collectionViewLayout: layout)
        
        
        return cv
    }()
    
    
    
    
    let activities = ["Swimming", "Walking", "Walking", "Walking", "Walking", "Walking", "Walking", "Walking", "Walking", "Walking", "Walking", "Walking", "Walking", "Walking"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationView = LocationView()
        view.backgroundColor = .white
        view.addSubview(locationView)
        view.addConstraintsWithFormat(format: "H:[v0]", views: locationView)
        view.addSubview(exploreView)
        exploreView.frame = view.frame
        exploreView.backgroundColor = .red
        exploreView.delegate = self
        exploreView.dataSource = self
        exploreView.register(ExploreViewCell.self, forCellWithReuseIdentifier: "myCell")
        exploreView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        exploreView.register(TitleView.self, forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: exploreView)
        view.addConstraintsWithFormat(format: "V:|-[v0(200)]-[v1]-|", views: locationView, exploreView)
       
   
        
        
        
        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {


        case UICollectionView.elementKindSectionHeader:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! TitleView
            footer.titleLabel.text = activities[indexPath.item]
            
            return footer

        default:
            fatalError("Unexpected element kind")
           
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 60)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
