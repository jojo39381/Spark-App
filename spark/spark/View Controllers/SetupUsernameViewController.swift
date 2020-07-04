//
//  SetupUsernameViewController.swift
//  spark
//
//  Created by Hugo Zhan on 6/24/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import Firebase

class SetupUsernameViewController: UIViewController {
    var firstTimeUser = false
    var stackView: UIStackView!
    var errorLabel: UILabel!
    var usernameTextField: UITextField!
    var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if firstTimeUser {
            navigationItem.hidesBackButton = true
        }
        view.backgroundColor = .white
        stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.84).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.08 * 3.5).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = view.frame.height * 0.02

        errorLabel = UILabel()
        errorLabel.text = "Pick a unique username"
        errorLabel.font = UIFont(name: "RopaSans-Regular", size: 24)
        errorLabel.textColor = UIColor(red: 23/255, green: 50/255, blue: 69/255, alpha: 1)
        errorLabel.numberOfLines = 2
        
        usernameTextField = UITextField()
        usernameTextField.placeholder = "Username"
        usernameTextField.text = username
        usernameTextField.addTarget(self, action: #selector(textfieldEditing), for: .editingChanged)
        
        confirmButton = UIButton()
        confirmButton.setTitle("Check", for: .normal)
        confirmButton.addTarget(self, action: #selector(checkUsername), for: .touchUpInside)
        
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(confirmButton)
        
        Utilities.styleTextField(usernameTextField)
        Utilities.styleYellowButton(confirmButton)
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: view, action: #selector(self.view.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func checkUsername() {
        self.view.endEditing(true)
        Utilities.checkUsername(username: usernameTextField.text!, uid: auth.currentUser!.uid) { same in
            if same {
                self.errorLabel.textColor = .systemRed
                if self.usernameTextField.text == username {
                    self.errorLabel.text = "This is your current username"
                } else {
                    self.errorLabel.text = "Username unavalaible"
                }
            } else {
                self.self.errorLabel.text = "Username is avalaible"
                self.errorLabel.textColor = .systemGreen
                self.confirmButton.setTitle("Confirm", for: .normal)
                self.confirmButton.removeTarget(self, action: #selector(self.checkUsername), for: .touchUpInside)
                self.confirmButton.addTarget(self, action: #selector(self.confirmButtonTapped), for: .touchUpInside)
            }
        }
    }
    
    @objc func confirmButtonTapped() {
        username = usernameTextField.text
        if firstTimeUser {
            let setupProfileViewController = SetupProfileViewController()
            setupProfileViewController.firstTimeUser = true
            navigationController?.pushViewController(setupProfileViewController, animated: true)
        } else {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @objc func textfieldEditing() {
        errorLabel.text = "Pick a unique username"
        errorLabel.textColor = UIColor(red: 23/255, green: 50/255, blue: 69/255, alpha: 1)
        confirmButton.setTitle("Check", for: .normal)
        confirmButton.removeTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(checkUsername), for: .touchUpInside)
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
