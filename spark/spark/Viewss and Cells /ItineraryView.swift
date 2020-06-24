//
//  ItineraryView.swift
//  spark
//
//  Created by Joseph Yeh on 6/3/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class ItineraryView: UIView, UIGestureRecognizerDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.isUserInteractionEnabled = true
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(handleDrag(_:)))
        swipeGestureUp.direction = .up
        swipeGestureUp.delegate = self
        
        let swipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(handleDrag(_:)))
        swipeGestureDown.direction = .down
        swipeGestureDown.delegate = self
        
        self.addGestureRecognizer(swipeGestureUp)
        self.addGestureRecognizer(swipeGestureDown)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleDrag(_ sender: UISwipeGestureRecognizer) {
        print("///////")
        if sender.direction == .up {

            if let viewToDrag = sender.view {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    viewToDrag.frame = CGRect(x:0, y:300, width: self.frame.width, height: self.frame.height)
                }, completion: nil)
                
                
            }
            
        }
        
        else if sender.direction == .down {
            if let viewToDrag = sender.view {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                                   viewToDrag.frame = CGRect(x:0, y:self.frame.height - 110, width: self.frame.width, height: self.frame.height)
                               }, completion: nil)
                
                
            }
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    
}
