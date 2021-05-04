//
//  SparkTabBarController.swift
//  spark
//
//  Created by Joseph Yeh on 6/22/20.
//  Modified by Tinna Liu, Peter Li on 5/1/21.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class SparkTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        
        let homeViewController = HomeViewController(collectionViewLayout: layout)
        homeViewController.title = "Home"
        let navigation = UINavigationController(rootViewController:homeViewController);
        
        let third = TypesController()
        third.title = "Spark"
        let thirdNav = UINavigationController(rootViewController:third);
       
        let profile = ProfileViewController();
        profile.pUid = auth.currentUser?.uid
        profile.title = "Profile"
        let profileNav = UINavigationController(rootViewController:profile);
        
        self.viewControllers = [navigation, thirdNav, profileNav]
        self.tabBar.items![0].image = UIImage(named:"house")
        self.tabBar.items![1].image = UIImage(named:"plus.circle")
        self.tabBar.items![1].tag = 1
        self.tabBar.items![2].image = UIImage(named:"person.crop.circle")
       
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.barTintColor = .white
        // Do any additional setup after loading the view.
    }
        
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
          print("tap tab")
    }
}
