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
        let first = HomeViewController();
        first.title = "Home"
        let navigation = UINavigationController(rootViewController:first);
        
        
       
        
        let secondNav = UINavigationController(rootViewController:ActivityViewController());
        secondNav.title = "Activities"
        
        let third = UIViewController();
        third.title = "Inbox"
        let thirdNav = UINavigationController(rootViewController:third);
        
        let fourth = ProfileViewController();
        fourth.title = "Profile"
        let fourthNav = UINavigationController(rootViewController:fourth);
        
        
        
        self.viewControllers = [navigation, secondNav, third, fourthNav]
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
    
        if item.tag == 1 {
            let third = TypesController()
            third.title = "Add"
            let thirdNav = UINavigationController(rootViewController:third);
            
            thirdNav.modalPresentationStyle = .fullScreen
            
            self.present(thirdNav, animated: true, completion: nil)
          }
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
