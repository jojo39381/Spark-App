//
//  CollectionViewCell.swift
//  spark
//
//  Created by Joseph Yeh on 5/28/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

protocol SelectedDelegate {
    func didAdvance(selectedItems: [String])
}
class QuestionCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return array!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! SelectCell
        
        myCell.selectLabel.text = array![indexPath.item]
        myCell.layer.borderColor = UIColor.white.cgColor
        myCell.layer.borderWidth = 1
        myCell.layer.masksToBounds = true
        myCell.layer.cornerRadius = 20
    
        if selectedItems.contains(array![indexPath.item]) {
            myCell.backgroundColor = UIColor.rgb(red: 31, green: 64, blue: 104)
        }
        else {
            myCell.backgroundColor = UIColor.rgb(red: 27, green: 108, blue: 168)
        }
        
        return myCell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = array![indexPath.row]
        let itemSize = item.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30)
        ])
        return CGSize(width:itemSize.width, height:40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myCell = collectionView.cellForItem(at: indexPath) as! SelectCell
        myCell.backgroundColor = UIColor.rgb(red: 31, green: 64, blue: 104)
        if !selectedItems.contains(array![indexPath.item]) {
            selectedItems.append(array![indexPath.item])
        }
        
        
        
        
    }
       
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
    
    var catCollectionView : UICollectionView = {
        let layout = CustomViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 27, green: 108, blue: 168)
        
        
        return cv
        
        
        
    }()
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
        addSubview(catCollectionView)
        addSubview(nextButton)
        catCollectionView.contentInsetAdjustmentBehavior = .always
        addConstraintsWithFormat(format:"H:|-20-[v0]-20-|", views: questionTitle)
        addConstraintsWithFormat(format:"H:|-20-[v0]-20-|", views: catCollectionView)
        addConstraintsWithFormat(format:"H:|-20-[v0]-20-|", views: instruction)
        addConstraintsWithFormat(format:"H:[v0]-50-|", views: nextButton)
        
        addConstraintsWithFormat(format: "V:|-50-[v0]-100-[v1]-20-[v2]-100-[v3]-100-|", views: questionTitle, instruction, catCollectionView, nextButton)
        
        catCollectionView.delegate = self
        catCollectionView.dataSource = self
        catCollectionView.register(SelectCell.self, forCellWithReuseIdentifier: "myCell")
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class SelectCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupCell()
        
    }
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    var selectLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label

    }()
    
    func setupCell() {
        self.contentView.addSubview(selectLabel)
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: selectLabel)
        addConstraintsWithFormat(format: "V:|-[v0]-|", views: selectLabel)
        
        
        
        
       
       
        
        
    }
}
class CustomViewFlowLayout: UICollectionViewFlowLayout {

let cellSpacing:CGFloat = 10

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 4.0
            self.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        let attributes = super.layoutAttributesForElements(in: rect)
        guard let attributesArray = NSArray(array: attributes!, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }
        

            var leftMargin = sectionInset.left
            var maxY: CGFloat = -1.0
            attributesArray.forEach { layoutAttribute in
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + cellSpacing
                maxY = max(layoutAttribute.frame.maxY , maxY)
            }
            return attributesArray
    }
}
