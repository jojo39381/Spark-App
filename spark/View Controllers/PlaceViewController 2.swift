//
//  PlaceViewController.swift
//  spark
//
//  Created by Joseph Yeh on 11/25/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoCollectionViewCell
        cell.infoLabel.text = categories[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    
    
    var placeImageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    var ratingLabel: UILabel = {
        var label = UILabel()
        label.text = "4.5"
        return label
    }()
    
    var priceLabel: UILabel = {
        var label = UILabel()
        label.text = "$$$"
        return label
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Place"
        return label
    }()
    
    var infoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        return collectionView
    }()
    
    var descriptionView: UITextView = {
        var textView = UITextView()
        textView.text = "deescription"
        textView.isScrollEnabled = false
        return textView
    }()
    
    var categories = ["Hours", "Location", "Phone", "Website"]
    
    
    
    
    var place: Place? {
        didSet {
            
            setImage(imageURL:place!.image_url)
            
            
            
            
            
            setupView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        view.addSubview(placeImageView)
        view.addSubview(ratingLabel)
        view.addSubview(priceLabel)
        view.addSubview(titleLabel)
        view.addSubview(infoCollectionView)
        view.addSubview(descriptionView)
        
        placeImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
        
        ratingLabel.anchor(top: placeImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        priceLabel.anchor(top: placeImageView.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: -20, width: 0, height: 0)
        
        titleLabel.anchor(top: ratingLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: -20, width: 0, height: 0)
    
        descriptionView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: -20, width: 0, height: 0)
        
        infoCollectionView.anchor(top: descriptionView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: -20, width: 0, height: 0)
        
        setupCollectionView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        print("name" + place!.name)
        titleLabel.text = place?.name
        ratingLabel.text = String(place!.ratings)
        
        descriptionView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        
    }
    
    
    
    
    
    
    
    let cellId = "cellId"
    func setupCollectionView() {
        infoCollectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func setupNav() {
        
        self.view.backgroundColor = .white
        
        let navigationBar = self.navigationController?.navigationBar
        navigationItem.hidesBackButton = false
        
        navigationBar?.backgroundColor = .clear
       navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "Spark"
        
        
        
        
        
    }
    
    func setImage(imageURL:String) {
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check for the error, then construct the image using data
            if let err = err {
                print("Failed to fetch profile image:", err)
                return
            }
            
            //perhaps check for response status of 200 (HTTP OK)
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            
            //need to get back onto the main UI thread
            DispatchQueue.main.async {
                self.placeImageView.image = image
            }
            
            }.resume()
        
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
