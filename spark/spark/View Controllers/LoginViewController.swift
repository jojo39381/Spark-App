//
//  LoginViewController.swift
//  spark
//
//  Created by Hugo Zhan on 6/24/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    var firstTimeUser = [String]()
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var backButton: UIButton!
    var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel = UILabel()
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.84).isActive = true
        errorLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.autocapitalizationType = .none
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
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
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(backButton)

        errorLabel.alpha = 0
    
        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleYellowButton(loginButton)
        Utilities.styleBlueButton(backButton)
        
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont(name: "RopaSans-Regular", size: 14)
        errorLabel.textColor = .systemRed
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(self.view.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func backTapped() {
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
      
    @objc func loginTapped() {
        errorLabel.textColor = .systemRed
        errorLabel.alpha = 0
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
               // Couldn't sign in
                self.errorLabel.text = Utilities.handleError(error: error!)
                self.errorLabel.alpha = 1
            } else if !Auth.auth().currentUser!.isEmailVerified {
                self.errorLabel.text = "A verification has been sent to your email, please login after verifying"
                self.errorLabel.textColor = .systemGreen
                self.errorLabel.alpha = 1
                auth.currentUser?.sendEmailVerification{ (error) in
                    if error != nil {
                        self.errorLabel.text = Utilities.handleError(error: error!)
                    } else {
                        try! auth.signOut()
                        self.firstTimeUser.append(self.emailTextField.text!)
                    }
                }
            } else {
                Utilities.fetchProfileData() {
                    let sparkTabBarController = SparkTabBarController()
                    self.view.window!.rootViewController = sparkTabBarController
                    self.view.window?.makeKeyAndVisible()
                    var goToSetupUsername = false
                    for users in self.firstTimeUser {
                        goToSetupUsername = users == self.emailTextField.text!
                    }
                    if goToSetupUsername {
                        sparkTabBarController.selectedIndex = 4
                        let profileNav = sparkTabBarController.selectedViewController as! UINavigationController
                        let setupUsernameViewController = SetupUsernameViewController()
                        setupUsernameViewController.firstTimeUser = true
                        profileNav.pushViewController(setupUsernameViewController, animated: false)
                    }
               }
           }
       }
   }
}

