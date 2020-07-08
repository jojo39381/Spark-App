//
//  SetupProfileViewController.swift
//  spark
//
//  Created by Hugo Zhan on 6/24/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class SetupProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var firstTimeUser = false
    var profileTableView: UITableView!
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var doneButton: UIButton!
    
    override func viewDidLoad() {
        if firstTimeUser {
            navigationItem.hidesBackButton = true
        }
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        profileTableView = UITableView()
        profileTableView.frame = view.frame
        view.addSubview(profileTableView)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UITableViewCell.self, forCellReuseIdentifier: "profile")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileTableView.reloadData()
    }
    
    func pfpImageTapped() {
        imagePicker.delegate = self
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            image = pickedImage
        }
        let changeRequest = auth.currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = info[.imageURL] as? URL
        changeRequest?.commitChanges { (error) in
            self.imagePicker.dismiss(animated: true, completion: nil)
        }
        profileTableView.reloadData()
    }
    
    @objc func doneButtonTapped() {
        if auth.currentUser?.photoURL != nil {
            storage.reference(withPath: "\(auth.currentUser!.uid)/profile.jpg").putFile(from: (auth.currentUser?.photoURL)!, metadata: nil) { (data, error) in
                db.collection("users").document(auth.currentUser!.uid).updateData(["firstName": firstName!, "lastName": lastName!, "username": username!, "bio": bio!]) { (error) in
                    self.navigate()
                }
            }
        } else {
            db.collection("users").document(auth.currentUser!.uid).updateData(["firstName": firstName!, "lastName": lastName!, "username": username!, "bio": bio!]) { (error) in
                self.navigate()
            }
        }
    }
    
    func navigate() {
        if firstTimeUser {
            self.navigationController?.pushViewController(QuestionsViewController(), animated: false)
        } else {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
}

extension SetupProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item {
        case 0:
            return view.frame.height * 0.15
        case 3:
            return view.frame.height * 0.15
        default:
            return view.frame.height * 0.1
        }
    }
    
    func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{


        let scale = CGFloat(max(size.width/image.size.width,
            size.height/image.size.height))
        let width:CGFloat  = image.size.width * scale
        let height:CGFloat = image.size.height * scale

        let rr:CGRect = CGRect( x: 0, y: 0, width: width, height: height)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.draw(in: rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch indexPath.item {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath)
            let newImage = resizeImage(image: image, toTheSize: CGSize(width: cell.contentView.frame.height * 0.9, height: cell.contentView.frame.height * 0.9))
            cell.imageView?.layer.cornerRadius = cell.contentView.frame.height * 0.45
            cell.imageView?.layer.masksToBounds = true
            cell?.imageView?.image = newImage
            cell.textLabel?.text = "Tap to change profile picture"
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath)
            cell.textLabel?.text = "name: " + firstName + " " + lastName
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath)
            cell.textLabel?.text = "username: " + username
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath)
            cell.textLabel?.text = "bio: " + bio
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            pfpImageTapped()
        case 1:
            navigationController?.pushViewController(SetupNameViewController(), animated: false)
        case 2:
            navigationController?.pushViewController(SetupUsernameViewController(), animated: false)
        case 3:
            navigationController?.pushViewController(SetupBioViewController(), animated: false)
//
//        case 4:
//
        default:
            print("nothing")
        }
    }
    
}
