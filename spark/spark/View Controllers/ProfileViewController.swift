//
//  ProfileViewController.swift
//  spark
//
//  Created by Hugo Zhan on 6/24/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import Firebase

var username: String!
var bio: String!
var image: UIImage!
var firstName: String!
var lastName: String!

class ProfileViewController: UIViewController {
    var usernameLabel: UILabel!
    var bioTextView: UITextView!
    var buttonStack: UIStackView!
    var pastDateButton: UIButton!
    var likedDateButton: UIButton!
    var profileImageView: UIImageView!
    var dateCollectionView: UICollectionView!
    var sortByTableView: UITableView!
    var sortByButton: UIButton!
    var sortByLabel: UILabel!
    var showSortBy = false
    var sortBy = ["Recent", "Oldest", "Favorite", "$-$$$$", "$$$$-$"]
    
    override func viewWillAppear(_ animated: Bool) {
        usernameLabel.text = username
        bioTextView.text = bio
        profileImageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        setupProfileInfo()
        setupButtonStack()
        setupSortByTableView()
        setupDateCollection()
    }
    
    @objc func settingsButtonTapped() {
        navigationController?.pushViewController(SettingsViewController(), animated: false)
    }
    
    func setupProfileInfo() {
        profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.backgroundColor = .lightGray
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width * 0.25).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.2).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = view.frame.width * 0.2
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true

        usernameLabel = UILabel()
        usernameLabel.font = UIFont(name: "RopaSans-Regular", size: 18)
        usernameLabel.textColor = UIColor(red: 23/255, green: 50/255, blue: 69/255, alpha: 1)
        usernameLabel.textAlignment = .left
        usernameLabel.lineBreakMode = .byTruncatingTail
        usernameLabel.numberOfLines = 1
        usernameLabel.sizeToFit()
        stackView.addArrangedSubview(usernameLabel)
        
        bioTextView = UITextView()
        bioTextView.isEditable = false
        bioTextView.isScrollEnabled = false
        bioTextView.font = UIFont(name: "RopaSans-Regular", size: 14)
        bioTextView.textColor = UIColor(red: 23/255, green: 50/255, blue: 69/255, alpha: 1)
        stackView.addArrangedSubview(bioTextView)
    }
    
    func setupButtonStack() {
        pastDateButton = UIButton()
        pastDateButton.setTitle("Past Dates", for: .normal)
        pastDateButton.setTitleColor(.black, for: .normal)
        pastDateButton.titleLabel?.font = UIFont(name: "RopaSans-Regular", size: 32)
//        pastDateButton.addTarget(self, action: #selector(something), for: .touchUpInside)
        
        likedDateButton = UIButton()
        likedDateButton.setTitle("Liked Dates", for: .normal)
        likedDateButton.setTitleColor(.black, for: .normal)
        likedDateButton.titleLabel?.font = UIFont(name: "RopaSans-Regular", size: 32)
//        likedDateButton.addTarget(self, action: #selector(somethingElse), for: .touchUpInside)
        
        buttonStack = UIStackView()
        view.addSubview(buttonStack)
        buttonStack.distribution = .fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.center = buttonStack.center
        buttonStack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        buttonStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.08).isActive = true
        buttonStack.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        
        buttonStack.addArrangedSubview(pastDateButton)
        buttonStack.addArrangedSubview(likedDateButton)
    }
    
    func setupSortByTableView() {
        sortByTableView = UITableView()
        sortByTableView.delegate = self
        sortByTableView.dataSource = self
        sortByTableView.backgroundColor = .clear
        sortByTableView.translatesAutoresizingMaskIntoConstraints = false
        sortByTableView.separatorStyle = .none
        sortByTableView.isScrollEnabled = false
        sortByTableView.rowHeight = 50

        sortByTableView.register(UITableViewCell.self, forCellReuseIdentifier: "sort")

        view.addSubview(sortByTableView)
        sortByTableView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor).isActive = true
        sortByTableView.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width * 0.25).isActive = true
        sortByTableView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.2).isActive = true
        sortByTableView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.16 / 6).isActive = true
        
        sortByLabel = UILabel()
        sortByLabel.text = "Sort by:"
        sortByLabel.font = UIFont(name: "RopaSans-Regular", size: 14)
        view.addSubview(sortByLabel)
        sortByLabel.translatesAutoresizingMaskIntoConstraints = false
        sortByLabel.topAnchor.constraint(equalTo: buttonStack.bottomAnchor).isActive = true
        sortByLabel.rightAnchor.constraint(equalTo: sortByTableView.leftAnchor).isActive = true
        sortByLabel.heightAnchor.constraint(equalToConstant: view.frame.height * 0.16 / 6).isActive = true
    }
    
    @objc func handleDropDown() {
        showSortBy = !showSortBy
        var indexPaths = [IndexPath]()
        for i in 0..<sortBy.count {
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        if showSortBy {
            sortByTableView.removeConstraint(sortByTableView.constraints[1])
            sortByTableView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.16).isActive = true
            sortByTableView.insertRows(at: indexPaths, with: .none)
        } else {
            sortByTableView.deleteRows(at: indexPaths, with: .none)
            sortByTableView.removeConstraint(sortByTableView.constraints[1])
            sortByTableView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.16 / 6).isActive = true
        }
    }
    
    func setupDateCollection() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: view.frame.width * 0.1, bottom: view.frame.width * 0.1, right: view.frame.width * 0.1)
        layout.itemSize = CGSize(width: view.frame.width * 0.35, height: view.frame.width * 0.35)

        dateCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
        dateCollectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: "dates")
        dateCollectionView.showsVerticalScrollIndicator = false
        dateCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(dateCollectionView)

        dateCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dateCollectionView.topAnchor.constraint(equalTo: sortByLabel.bottomAnchor).isActive = true
        dateCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dateCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dateCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.bringSubviewToFront(sortByTableView)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height * 0.16 / 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.16 / 6
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        sortByButton = UIButton(type: .system)
        sortByButton.setTitle("Recent", for: .normal)
        sortByButton.setTitleColor(.black, for: .normal)
        sortByButton.titleLabel?.font = UIFont(name: "RopaSans-Regular", size: 14)
        sortByButton.addTarget(self, action: #selector(handleDropDown), for: .touchUpInside)
        
        return sortByButton
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showSortBy ? sortBy.count: 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sort", for: indexPath)
        cell.textLabel?.textAlignment = .center
        cell.textLabel!.text = sortBy[indexPath.item]
        cell.textLabel!.font = UIFont(name: "RopaSans-Regular", size: 14)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sortByButton.setTitle(sortBy[indexPath.item], for: .normal)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dateCollectionView.dequeueReusableCell(withReuseIdentifier: "dates", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = .gray
        return cell
    }
       
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
