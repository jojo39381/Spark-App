//
//  CollectionViewCell.swift
//  spark
//
//  Created by Joseph Yeh on 5/28/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit


class BudgetCell: UICollectionViewCell{

       
    var array : [String]?
    var key = "Food"
    var selectedModel = UserSelectedModel()
    var selectedItems = [String]()
    var questionTitle : UILabel = {
        let label = UILabel()
        label.text = "What are some of you or your partner's favorite food?"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25)
        label.numberOfLines = 0
        return label
    }()
    
    var instruction : UILabel = {
        let label = UILabel()
        label.text = "Choose up to 3 (You can change this later)"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    var nextButton : UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        
       
       
        return button
    }()
    
    
    var costSlider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 4
        slider.minimumValue = 1
        slider.tintColor = .white
        slider.maximumTrackTintColor = .white
        slider.minimumTrackTintColor = .black
        
       
        
        return slider
    }()
    
    
    @objc func valueChanged(_ sender: UISlider) {
        
        sender.setValue(roundf(sender.value), animated: false)
        costLabel.text = costs[Int(sender.value) - 1]
        print("lmaooooo")
        print(sender.value)
        selectedItems[0] = String(Int(sender.value))
    }
    
    var costLabel: UILabel = {
        let label = UILabel()
        label.text = "$: Budget"
        return label
    }()
    
    
    
    
    
    
    
    
    var costs = ["$: Budget", "$$: Pricey", "$$$: Expensive", "$$$$: Most Expensive"]
    let theme = UIColor.rgb(red: 27, green: 108, blue: 168)
    
    var delegate : SelectedDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    func setupView() {
        backgroundColor = theme
        addSubview(questionTitle)
        addSubview(instruction)
        
        addSubview(nextButton)
        
        addSubview(costSlider)
        
        addSubview(costLabel)
        costSlider.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        addConstraintsWithFormat(format:"H:|-20-[v0]-20-|", views: questionTitle)
        addConstraintsWithFormat(format:"H:|-30-[v0]-30-|", views: costSlider)
        addConstraintsWithFormat(format:"H:|-20-[v0]-20-|", views: costLabel)
        addConstraintsWithFormat(format:"H:|-20-[v0]-20-|", views: instruction)
        addConstraintsWithFormat(format:"H:[v0]-50-|", views: nextButton)
        
        addConstraintsWithFormat(format: "V:|-50-[v0]-100-[v1]-100-[v2]-20-[v3]", views: questionTitle, instruction, costLabel, costSlider  )
        addConstraintsWithFormat(format:"V:[v0]-100-|", views: nextButton)
        selectedItems.append("1")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
