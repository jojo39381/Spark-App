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
        
        
        let second = CalendarViewController();
        second.title = "Calendar"
        let secondNav = UINavigationController(rootViewController:second);
        
        let third = UIViewController()
        third.title = "Add"
        let thirdNav = UINavigationController(rootViewController:third);
        
        let fourth = UIViewController();
        fourth.title = "Notifications"
        let fourthNav = UINavigationController(rootViewController:fourth);
        
        let fifth = ProfileViewController();
        fifth.title = "Profile"
        let fifthNav = UINavigationController(rootViewController:fifth);
        
        
        
        self.viewControllers = [navigation, secondNav, third, fourthNav, fifthNav]
        self.tabBar.items![0].image = UIImage(named:"house")
        self.tabBar.items![1].image = UIImage(named:"calendar")
        self.tabBar.items![2].image = UIImage(named:"plus.circle")
        self.tabBar.items![2].tag = 1
        self.tabBar.items![3].image = UIImage(named:"envelope")
        self.tabBar.items![4].image = UIImage(named:"person.crop.circle")
        
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.barTintColor = .white
        // Do any additional setup after loading the view.
    }
        
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
          print("hello)")
    
        if item.tag == 1 {
            let third = QuestionsViewController()
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
