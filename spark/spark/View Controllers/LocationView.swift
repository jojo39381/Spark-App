//
//  LocationView.swift
//  spark
//
//  Created by Joseph Yeh on 7/6/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class LocationView: UIView {

    var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"library")!.alpha(0.5)
        
        return imageView
    }()
    var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Berkeley"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
   
       
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addSubview(image)
        self.addConstraintsWithFormat(format: "H:[v0]", views: image)
        self.addConstraintsWithFormat(format: "V:|-[v0]-|", views: image)
       
        image.addSubview(locationLabel)
       
        image.addConstraintsWithFormat(format: "H:|-[v0]", views: locationLabel)
        image.addConstraintsWithFormat(format: "V:|-[v0]", views: locationLabel)
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension UIImageView
{
    func makeBlurImage(targetImageView:UIImageView?)
    {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView!.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        targetImageView?.addSubview(blurEffectView)
    }
}
extension UIImage {

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
