//
//  CategoryCell.swift
//  spark
//
//  Created by Hugo Zhan on 4/7/21.
//  Copyright © 2021 Joseph Yeh. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    let category: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var dateInfo:Place? {
        didSet {
            downloadImage()
        }
    }
    
    func downloadImage() {
        guard let url = URL(string: dateInfo!.image_url) else { return }
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
                self.imageView.image = image
            }
        }.resume()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(category)
        self.addSubview(imageView)
        
        imageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        category.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        self.layer.cornerRadius = 2
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        self.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    var gradientLayer: CAGradientLayer!
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.rgb(red: 241, green: 39, blue: 17).cgColor, UIColor.rgb(red: 245, green: 175, blue: 25).cgColor]
        self.layer.addSublayer(gradientLayer)
    }
}
