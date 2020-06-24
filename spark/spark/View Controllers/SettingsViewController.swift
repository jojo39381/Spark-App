//
//  SettingsViewController.swift
//  spark
//
//  Created by Hugo Zhan on 6/24/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var settingsTableView: UITableView!
    var settings = ["Edit Profile", "Log Out"]
    
    override func viewDidLoad() {
        navigationItem.title = "Settings"
        super.viewDidLoad()
        settingsTableView = UITableView()
        settingsTableView.frame = view.frame
        view.addSubview(settingsTableView)
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "settings")
        // Do any additional setup after loading the view.
    }
    
    func editButtonTapped() {
        navigationController?.pushViewController(SetupProfileViewController(), animated: false)
    }
     
    func logoutButtonTapped() {
        try! auth.signOut()
        self.view.window?.rootViewController = StartViewController()
        self.view.window?.makeKeyAndVisible()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath)
        cell.textLabel!.text = settings[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            editButtonTapped()
        case 1:
            logoutButtonTapped()
        default:
            print("nothing")
        }
    }
}
