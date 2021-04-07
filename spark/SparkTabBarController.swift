//
//  SparkTabBarController.swift
//  spark
//
//  Created by Joseph Yeh on 6/22/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class SparkTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let layout = UICollectionViewFlowLayout()
        let homeViewController = HomeViewController(collectionViewLayout: layout)
        let navigation = UINavigationController(rootViewController:homeViewController);
       
        
        let secondNav = UINavigationController(rootViewController:UIViewController());
        secondNav.title = "Activities"
        
        let third = TypesController()
        third.title = "Add"
        let thirdNav = UINavigationController(rootViewController:third);
        let fourth = ProfileViewController();
        fourth.pUid = auth.currentUser?.uid
        fourth.title = "Profile"
        let fourthNav = UINavigationController(rootViewController:fourth);
        
        
        
        self.viewControllers = [navigation, secondNav, thirdNav, fourthNav]
        self.tabBar.items![0].image = UIImage(named:"house")
        self.tabBar.items![1].image = UIImage(named:"calendar")
        self.tabBar.items![2].image = UIImage(named:"plus.circle")
        self.tabBar.items![2].tag = 1
        self.tabBar.items![3].image = UIImage(named:"envelope")
       
        
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.barTintColor = .white
        // Do any additional setup after loading the view.
    }
        
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        

          print("hello)")
    
       
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
