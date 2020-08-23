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
var preferences = [String: [String]]()
class ProfileViewController: UIViewController {
    var usernameLabel: UILabel!
    var bioTextView: UITextView!
    var stack: UIStackView!
    var posts: UILabel!
    var adventures: UILabel!
    var friends: UILabel!
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var profileImageView: UIImageView!
    var dateTableView: UITableView!
    var friendButton: UIButton!
    var numPos: Int = 10
    var numAdv: Int = 10
    var numFri: Int = 10
    override func viewWillAppear(_ animated: Bool) {
        usernameLabel.text = username
        bioTextView.text = bio
        profileImageView.image = image
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imagePicker.delegate = self
        setupProfileInfo()
        setupStack()
        setupDateTable()
        let gear = UIBarButtonItem(title: NSString(string: "\u{2699}\u{0000FE0E}") as String, style: .plain, target: self, action: #selector(settingsButtonTapped))
        gear.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36), NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        navigationItem.rightBarButtonItem = gear
    }
    @objc func settingsButtonTapped() {
        navigationController?.pushViewController(SetupProfileViewController(), animated: false)
    }
    @objc func friendButtonTapped() {
        print("friends!")
    }
    @objc func pfpImageTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
               self.openCamera()
           }))
        alert.addAction(UIAlertAction(title: "Library", style: .default, handler: { _ in
               self.openLibrary()
           }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func openCamera() {
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    func openLibrary() {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    func setupProfileInfo() {
        profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.backgroundColor = .lightGray
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width * 0.35).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.2).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.2).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.2).isActive = true
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = view.frame.width * 0.1
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pfpImageTapped)))
        friendButton = UIButton()
        view.addSubview(friendButton)
        let image = UIImage(systemName: "person.badge.plus.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        friendButton.setImage(image, for: .normal)
        friendButton.addTarget(self, action: #selector(friendButtonTapped), for: .touchUpInside)
        friendButton.translatesAutoresizingMaskIntoConstraints = false
        friendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width * 0.35).isActive = true
        friendButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.2).isActive = true
        friendButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.2).isActive = true
        friendButton.heightAnchor.constraint(equalToConstant: view.frame.width * 0.2).isActive = true
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true
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
    func setupStack() {
        posts = UILabel()
        posts.text = "\(numPos)\nPosts"
        posts.textAlignment = .center
        posts.numberOfLines = 2
        adventures = UILabel()
        adventures.text = "\(numAdv)\nAdventures"
        adventures.textAlignment = .center
        adventures.numberOfLines = 2
        friends = UILabel()
        friends.text = "\(numFri)\nFriends"
        friends.textAlignment = .center
        friends.numberOfLines = 2
        stack = UIStackView()
        view.addSubview(stack)
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        stack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.08).isActive = true
        stack.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        stack.addArrangedSubview(posts)
        stack.addArrangedSubview(adventures)
        stack.addArrangedSubview(friends)
    }
    func setupDateTable() {
        dateTableView = UITableView()
        dateTableView.dataSource = self
        dateTableView.delegate = self
        dateTableView.register(DateTableViewCell.self, forCellReuseIdentifier: "dates")
        dateTableView.showsVerticalScrollIndicator = false
        dateTableView.backgroundColor = UIColor.white
        self.view.addSubview(dateTableView)
        dateTableView.translatesAutoresizingMaskIntoConstraints = false
        dateTableView.rowHeight = view.frame.height * 0.2
        dateTableView.topAnchor.constraint(equalTo: stack.bottomAnchor).isActive = true
        dateTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.frame.width * 0.1).isActive = true
        dateTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width * 0.08).isActive = true
        dateTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numPos
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dates", for: indexPath as IndexPath)
        return cell
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
           image = pickedImage
        }
        let changeRequest = auth.currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = info[.imageURL] as? URL
        changeRequest?.commitChanges { (error) in
            storage.reference(withPath: "\(auth.currentUser!.uid)/profile.jpg").putFile(from: (auth.currentUser?.photoURL)!, metadata: nil) { (data, error) in
            }
        }
        self.profileImageView.image = image
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
}
