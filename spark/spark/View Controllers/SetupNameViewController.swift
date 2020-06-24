//
//  SetupNameViewController.swift
//  spark
//
//  Created by Hugo Zhan on 6/24/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class SetupNameViewController: UIViewController {
    var stackView: UIStackView!
    var errorLabel: UILabel!
    var firstNameTextField: UITextField!
    var lastNameTextField: UITextField!
    var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.84).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.08 * 4.75).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = view.frame.height * 0.02

        errorLabel = UILabel()
        errorLabel.text = "Change your first and last name"
        errorLabel.font = UIFont(name: "RopaSans-Regular", size: 24)
        errorLabel.textColor = UIColor(red: 23/255, green: 50/255, blue: 69/255, alpha: 1)
        errorLabel.numberOfLines = 2
        
        firstNameTextField = UITextField()
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.text = firstName
        
        lastNameTextField = UITextField()
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.text = lastName
        
        confirmButton = UIButton()
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(firstNameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(confirmButton)
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleYellowButton(confirmButton)
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: view, action: #selector(self.view.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func confirmButtonTapped() {
        firstName = firstNameTextField.text
        lastName = lastNameTextField.text
        for viewController in navigationController!.viewControllers {
            if viewController is SetupProfileViewController {
                navigationController?.popToViewController(viewController, animated: true)
            }
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
