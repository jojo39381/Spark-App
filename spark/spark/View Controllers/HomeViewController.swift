//
//  HomeViewController.swift
//  spark
//
//  Created by Joseph Yeh on 6/30/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import MapKit

<<<<<<< HEAD
class HomeViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
=======
class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! ExploreViewCell
        myCell.backgroundColor = .white
        return myCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
>>>>>>> 3fbdaa845bbb5f85a6e65637e780cef65416b4fb

    var exploreView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame:.zero, collectionViewLayout: layout)
        
        return cv
    }()
    
    let activities = ["Swimming", "Walking"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(exploreView)
        exploreView.frame = view.frame
        exploreView.backgroundColor = .red
        exploreView.delegate = self
        exploreView.dataSource = self
        exploreView.register(ExploreViewCell.self, forCellWithReuseIdentifier: "myCell")
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: exploreView)
        view.addConstraintsWithFormat(format: "V:|-[v0]-|", views: exploreView)
      
        
        
        // Do any additional setup after loading the view.
        
        //user location things
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
        
    }
    
<<<<<<< HEAD
      //user location things
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
=======

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
>>>>>>> 3fbdaa845bbb5f85a6e65637e780cef65416b4fb
    }

        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        print(userLocation)
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
    var userLocation: CLLocation!
    var radius = 30000

