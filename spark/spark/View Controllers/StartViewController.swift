//
//  StartViewController.swift
//  spark
//
//  Created by Hugo Zhan on 6/24/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    var signUpButton: UIButton!
    var loginButton: UIButton!
    var buttonStack: UIView!
    var background: UIImageView!
    var logo: UIImageView!
    var logoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBackground()
        setupButtons()
    }
    
    func setupBackground() {
        background = UIImageView(frame: view.frame)
        background.image = UIImage(named: "background-1")
        view.addSubview(background)
        
        logo = UIImageView(image: UIImage(named: "spark logo"))
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height * 0.14).isActive = true
        logo.widthAnchor.constraint(equalToConstant: view.frame.width / 1.6).isActive = true
        logo.heightAnchor.constraint(equalToConstant: view.frame.width / 1.6).isActive = true
        logo.clipsToBounds = true
        logo.layer.cornerRadius = view.frame.width / 3.2
    }
    
    func setupButtons() {
        buttonStack = UIView()
        view.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonStack.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height * 0.2).isActive = true
        buttonStack.widthAnchor.constraint(equalToConstant: view.frame.width * 0.84).isActive = true
        buttonStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.16).isActive = true
        buttonStack.layer.cornerRadius = view.frame.height * 0.04
        buttonStack.layer.masksToBounds = true
        
        let stackView = UIStackView()
        buttonStack.addSubview(stackView)
        stackView.frame = buttonStack.bounds
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.center = buttonStack.center
        stackView.widthAnchor.constraint(equalTo: buttonStack.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: buttonStack.heightAnchor).isActive = true
        
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor(red: 23/255, green: 50/255, blue: 69/255, alpha: 1), for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "RopaSans-Regular", size: 36)
        loginButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 74/255, alpha: 1)
        stackView.addArrangedSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "RopaSans-Regular", size: 36)
        signUpButton.backgroundColor = UIColor(red: 23/255, green: 50/255, blue: 69/255, alpha: 1)
        stackView.addArrangedSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        logoLabel = UILabel()
        view.addSubview(logoLabel)
        logoLabel.text = "Let's ignite one."
        logoLabel.font = UIFont(name: "RopaSans-Regular", size: 36)
        logoLabel.textColor = UIColor(red: 23/255, green: 50/255, blue: 69/255, alpha: 1)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -view.frame.height * 0.08 * 0.25).isActive = true
    }
    
    @objc func signUpButtonTapped() {
        let signUpNavigationController = UINavigationController(rootViewController: SignUpNameViewController())
        signUpNavigationController.modalPresentationStyle = .fullScreen
        present(signUpNavigationController, animated: false, completion: nil)
    }
    
    @objc func loginButtonTapped() {
        let loginPage = LoginViewController()
        loginPage.modalPresentationStyle = .fullScreen
        present(loginPage, animated: false, completion: nil)
    }
    
}

