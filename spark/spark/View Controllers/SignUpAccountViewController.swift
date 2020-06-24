//
//  SignUpAccountViewController.swift
//  spark
//
//  Created by Hugo Zhan on 6/24/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import Firebase

class SignUpAccountViewController: UIViewController {
    var firstName: String!
    var lastName: String!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var passwordAgainTextField: UITextField!
    var signUpButton: UIButton!
    var cancelButton: UIButton!
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
        passwordAgainTextField = UITextField()
        passwordAgainTextField.placeholder = "Confirm Password"
        passwordAgainTextField.isSecureTextEntry = true
        signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.84).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.08 * 6.25).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: errorLabel.bottomAnchor).isActive = true
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = view.frame.height * 0.02
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordAgainTextField)
        stackView.addArrangedSubview(signUpButton)
        stackView.addArrangedSubview(cancelButton)

        // Hide the error label
        errorLabel.alpha = 0
    
        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(passwordAgainTextField)
        Utilities.styleYellowButton(signUpButton)
        Utilities.styleBlueButton(cancelButton)
        
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont(name: "RopaSans-Regular", size: 14)
        errorLabel.textColor = .systemRed
        let tap = UITapGestureRecognizer(target: view, action: #selector(self.view.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func cancelButtonTapped() {
        self.navigationController?.dismiss(animated: false, completion: nil)
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {

        // Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordAgainTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "*Please fill in all fields."
        }

        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "*Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        if passwordTextField.text != passwordAgainTextField.text {
            return "*Passwords did not match."
        }

        return nil
    }


    @objc func signUpTapped() {
        errorLabel.alpha = 0
        // Validate the fields
        let error = validateFields()

        if error != nil {
            // There's something wrong with the fields, show error message
            self.errorLabel.text = error!
            self.errorLabel.alpha = 1
        }
        else {
            // Create cleaned versions of the data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            //Create the user
            auth.createUser(withEmail: email, password: password) { (result, err) in

                // Check for errors
                if err != nil {

                    // There was an error creating the user
                    self.errorLabel.text = Utilities.handleError(error: err!)
                    self.errorLabel.alpha = 1
                }
                else {
                    // User was created successfully, now store the first name and last name
                    db.collection("users").document(result!.user.uid).setData(["firstName": self.firstName!, "lastName": self.lastName!, "username": "", "bio": ""]) { (error) in
                        if error != nil {
                            // Show error message
                            self.errorLabel.text = Utilities.handleError(error: error!)
                            self.errorLabel.alpha = 1
                        }
                    }
                   
                    try! Auth.auth().signOut()

                    let loginViewController = LoginViewController()
                    self.present(loginViewController, animated: false, completion: nil)
                    loginViewController.emailTextField.text = email
                    loginViewController.passwordTextField.text = password
                    loginViewController.loginTapped()
                }
            }
        }
    }
}
