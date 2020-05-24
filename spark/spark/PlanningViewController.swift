//
//  ViewController.swift
//  spark
//
//  Created by Joseph Yeh on 5/16/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import SpriteKit
import Magnetic
class PlanningViewController: UIViewController, FoodViewControllerDelegate, ActivityViewControllerDelegate, RestaurantsManagerDelegate, ActivityManagerDelegate {
    func didAddSelected(foodSelected: String, foodAlias: String) {
        selected.foodSelected.updateValue(foodAlias, forKey: foodSelected)
        
        let node = Node(text: foodSelected, image:nil, color: UIColor.rgb(red:245, green:123, blue:81), radius: 30)
        node1?.addChild(node)
       
    
        
    }
    func didAddActivity(activity: String, alias: String) {
        selected.activitySelected.updateValue(alias, forKey: activity)
        

    }
    
    let transition = CircularTransition()
    var center = CGPoint.zero
    let searchButton: UIButton = {
        let button = UIButton();
        button.backgroundColor = .red;
        button.setTitle("Search", for: .normal);
        button.backgroundColor = UIColor.rgb(red: 214, green: 52, blue: 71);
        button.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        
        return button;
    }()
    
    let foodbutton: UIButton = {
        let button = UIButton();
        button.backgroundColor = .red;
        button.setTitle("Search", for: .normal);
        button.backgroundColor = UIColor.rgb(red: 214, green: 52, blue: 71);
        return button;
    }()
    
    let activitiesButton: UIButton = {
        let button = UIButton();
        button.backgroundColor = .red;
        button.setTitle("Search", for: .normal);
        button.backgroundColor = UIColor.rgb(red: 214, green: 52, blue: 71);
        return button;
    }()
    
    
    
    
    
    
    
    var magnetic: Magnetic?
    var magnetic2: Magnetic?
    
    var node1: Node?
    var node2: Node?
    
    
    
    var selected = SelectedModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let magneticView = MagneticView(frame:self.view.bounds)
        magnetic = magneticView.magnetic
        magnetic?.magneticDelegate = self
        
        self.view.addSubview(magneticView)

        node1 = Node(text: "Food", image: UIImage(named: "food"), color: UIColor.rgb(red:173, green:105, blue:137), radius: 140)
        node1?.fontSize = 50.0;
        
        // custom code refactor and make permanent later
        node1?.setImage()
        node2 = Node(text: "Activities", image:UIImage(named:"activity"), color: UIColor.rgb(red:245, green:123, blue:81), radius: 140)
        node2?.fontSize = 50.0;
        
        // custom code refactor and make permanent later
        node2?.setImage()
        magnetic?.addChild(node1!)
        magnetic?.addChild(node2!)
        
        
        
        
        
        
        
        self.title = "Spark";
        self.navigationController?.navigationBar.prefersLargeTitles = true;
        var image = UIImage(named:"profile");
        image = image?.withRenderingMode(.alwaysOriginal);
        let profile = UIButton();
        profile.setBackgroundImage(UIImage(named:"profile"), for: .normal);
        self.navigationController?.navigationBar.addSubview(profile);
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        profile.layer.cornerRadius = 32 / 2
        profile.clipsToBounds = true
        profile.anchor(top: nil, left: nil, bottom: navigationBar.bottomAnchor, right: navigationBar.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -12, paddingRight: -16, width: 0, height: 0);
        profile.widthAnchor.constraint(equalTo: profile.heightAnchor).isActive = true;
        
        view.addSubview(searchButton);
    
        searchButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -35, paddingRight: 0, width: 250, height: 50);
        searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        searchButton.layer.cornerRadius = 25;
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func searchAction(sender: UIButton!) {
        print("lol")
        var manager = RestaurantsManager(categories: selected.foodSelected)
        manager.delegate = self
        manager.fetchRestaurants()
        
        
        
        
        
        
    }
    var restaurants: RestaurantModel!
    var activities: ActivityModel!
    func didLoadRestaurants(data: RestaurantModel) {
        restaurants = data
        print("///////////")
        var manager = ActivityManager(categories: selected.activitySelected)
        manager.delegate = self
        manager.fetchActivities()
        
    }
    func didLoadActivities(data: ActivityModel) {
        activities = data
        
        DispatchQueue.main.async {

            let vc = ResultsViewController()
            vc.activityModel = self.activities
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    



}

extension PlanningViewController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        if node.text == "Food" {
            let vc = FoodViewController()
            vc.modalPresentationStyle = .custom
            vc.delegate = self
            vc.foodList = selected.foodSelected
            let nav = UINavigationController(rootViewController:vc)
        
    
            self.navigationController?.present(nav, animated: true, completion: nil)
            
        }
        else {
            let vc = ActivityViewController()
            vc.modalPresentationStyle = .custom
            vc.delegate = self
            vc.activityList = selected.activitySelected
            let nav = UINavigationController(rootViewController:vc)
                
            
            self.navigationController?.present(nav, animated: true, completion: nil)
        }
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        print("didDeselect -> \(node)")
    }
    
    func magnetic(_ magnetic: Magnetic, didRemove node: Node) {
        print("didRemove -> \(node)")
    }
    
}

class ImageNode: Node {
    override var image: UIImage? {
        didSet {
            
            texture = image.map { SKTexture(image: $0) }
        
        }
    }
    override func selectedAnimation() {
    }
    override func deselectedAnimation() {}
}
