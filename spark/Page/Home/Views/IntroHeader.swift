//
//  UserProfileHeader.swift
//  InstagramFirebase
//
//  Created by Brian Voong on 3/22/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit


class IntroHeader: UICollectionViewCell {
    let introLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal;
        return sb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.addSubview(introLabel)
        self.addSubview(searchBar)
        introLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 25, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        searchBar.anchor(top: introLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -10, paddingRight: -20, width: 0, height: 0)
    }
    
    func updateCellWithName(name: String) {
        introLabel.text = "Hi \(name)!\nLet's start your adventure."
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
