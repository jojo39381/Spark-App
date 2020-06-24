//
//  SignUpNameViewController.swift
//  spark
//
//  Created by Hugo Zhan on 6/24/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

import UIKit

class SignUpNameViewController: UIViewController {
    var firstNameTextField: UITextField!
    var lastNameTextField: UITextField!
    var nextButton: UIButton!
    var backButton: UIButton!
    var errorLabel: UILabel!
    
    override func viewDidLoad() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController!.navigationBar.compactAppearance = navigationBarAppearance
        navigationController!.navigationBar.standardAppearance = navigationBarAppearance
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        errorLabel = UILabel()
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.84).isActive = true
        errorLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        
        firstNameTextField = UITextField()
        firstNameTextField.placeholder = "First Name"
        lastNameTextField = UITextField()
        lastNameTextField.placeholder = "Last Name"
        nextButton = UIButton()
        nextButton.setTitle("Next", for: .normal)
        backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.84).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.08 * 5).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: errorLabel.bottomAnchor).isActive = true
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = view.frame.height * 0.02
        stackView.addArrangedSubview(firstNameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(nextButton)
        stackView.addArrangedSubview(backButton)

        errorLabel.alpha = 0
    
        // Style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleYellowButton(nextButton)
        Utilities.styleBlueButton(backButton)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont(name: "RopaSans-Regular", size: 14)
        errorLabel.textColor = .systemRed
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(self.view.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    func validateFields() -> String? {

        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "*Please fill in all fields."
        }
        
        return nil
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.dismiss(animated: false, completion: nil)
    }
    
    @objc func nextButtonTapped() {
        errorLabel.alpha = 0
        // Validate the fields
        let error = validateFields()

        if error != nil {
            // There's something wrong with the fields, show error message
            self.errorLabel.text = error!
            self.errorLabel.alpha = 1
        }
        else {
            let signUpAccountViewController = SignUpAccountViewController()
            signUpAccountViewController.firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            signUpAccountViewController.lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            self.navigationController?.pushViewController(signUpAccountViewController, animated: true)
        }
    }
}
