//
//  ViewController.swift
//  spark
//
//  Created by Joseph Yeh on 5/16/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class PlanningViewController: UIViewController {

    let searchButton: UIButton = {
        let button = UIButton();
        button.backgroundColor = .red;
        button.setTitle("Search", for: .normal);
        button.backgroundColor = UIColor.rgb(red: 214, green: 52, blue: 71);
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
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 245, green: 123, blue: 81);
       
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
    
        searchButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -70, paddingRight: 0, width: 250, height: 50);
        searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        searchButton.layer.cornerRadius = 25;
        
        // Do any additional setup after loading the view.
    }


}


