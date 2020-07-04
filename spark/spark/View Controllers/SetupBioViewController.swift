//
//  SetupBioViewController.swift
//  spark
//
//  Created by Hugo Zhan on 6/24/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class SetupBioViewController: UIViewController {
    
    var bioTextField: UITextField!
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        super.viewDidLoad()
        bioTextField = UITextField()
        bioTextField.text = bio
        bioTextField.sizeToFit()
        view.addSubview(bioTextField)
        bioTextField.translatesAutoresizingMaskIntoConstraints = false
        bioTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        bioTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // Do any additional setup after loading the view.
    }
    
    @objc func doneButtonTapped() {
        bio = bioTextField.text
        self.navigationController?.popViewController(animated: false)
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
