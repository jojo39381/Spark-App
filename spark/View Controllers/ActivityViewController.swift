//
//  ActivityViewController.swift
//  spark
//
//  Created by Joseph Yeh on 8/23/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    var users = [String]()
    var uids = [String]()
    var usersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
        usersTableView = UITableView(frame: view.frame, style: .plain)
        usersTableView.register(UserTableViewCell.self, forCellReuseIdentifier: "user")
        usersTableView.isHidden = true
        usersTableView.dataSource = self
        usersTableView.delegate = self
        view.addSubview(usersTableView)
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

extension ActivityViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        usersTableView.isHidden = false
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        users = []
        uids = []
        usersTableView.isHidden = true
        usersTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Utilities.searchUser(str: searchText) { users, uids in
            self.users = users
            self.uids = uids
            self.usersTableView.reloadData()
        }
    }
}

extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "user", for: indexPath as IndexPath)
        cell.textLabel?.text = users[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        storage.reference(withPath: "\(uids[indexPath.row])/profile.jpg").getData(maxSize: 999999999999) { (data, error) in
            var pImage: UIImage!
            if error != nil {
                print(error!)
            }
            if let data = data {
                pImage = UIImage(data: data)
            }
            let docRef = db.collection("users").document(self.uids[indexPath.row])
            docRef.getDocument {(document, error) in
                let profileViewController = ProfileViewController()
                profileViewController.pUsername = document?.get("username") as! String
                profileViewController.pImage = pImage
                profileViewController.pUid = self.uids[indexPath.row]
                self.present(profileViewController, animated: true, completion: nil)
            }
        }
    }
}
