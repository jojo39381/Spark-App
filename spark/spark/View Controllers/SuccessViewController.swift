//
//  SuccessViewController.swift
//  spark
//
//  Created by Joseph Yeh on 6/18/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {
    
    
    
    
    
    var successLabel: UILabel = {
        let label = UILabel()
        label.text = "Date is saved to your calendar"
        label.textColor = .black
        return label
    }()
    
    var inviteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send Invite", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 251, green: 228, blue: 85)
        view.addSubview(successLabel)
       
        
        view.addSubview(inviteButton)
        
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: successLabel)
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: inviteButton)
        view.addConstraintsWithFormat(format: "V:|-20-[v0]-10-[v1(50)]-100-|", views: successLabel, inviteButton)
        
        
        
        
        
        
        // Do any additional setup after loading the view.
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
