//
//  FoodViewController.swift
//  spark
//
//  Created by Joseph Yeh on 5/17/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import ChameleonFramework
import Alamofire
class FoodViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MenuViewDelegate, UISearchBarDelegate,UISearchControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:180, height:190)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! CategoryCell
        
        myCell.layer.cornerRadius = 35
        
        myCell.backgroundColor = UIColor(randomFlatColorOf: UIShadeStyle.dark)
        
        
        
        

        return myCell
    }
    
    
    
    
    
    
        
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    let foodCollectionView:UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "mycell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    
    let timeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Time", for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    let budgetButton: UIButton = {
        let button = UIButton()
        button.setTitle("$$$", for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let foodLabel: UILabel = {
        let label = UILabel()
        label.text = "Preferences"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
        self.definesPresentationContext = true

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        

        setupNav()
        
        
       
        
        
        
        
        
        foodCollectionView.dataSource = self
        foodCollectionView.delegate = self
        view.addSubview(foodCollectionView)
        foodCollectionView.frame = CGRect(x:0,y:0,width:view.frame.width, height:view.frame.height)
        foodCollectionView.contentInset = UIEdgeInsets(top: 60, left: 20, bottom: 10, right: 20)
        foodCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        
        setupMenuBar()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    func setupMenuBar() {
        
        let redView = UIView()
        redView.backgroundColor = .white
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuBar.isUserInteractionEnabled = true
        menuBar.delegate = self
    }

    let filters = Filters()
    func filterSelected() {
        filters.showFilters()
    }
    

    
    
    
    func setupNav() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = "Preferences"
        navigationBar.isTranslucent = false;
        foodLabel.frame = CGRect(x:0, y:0, width:view.frame.width - 32, height:view.frame.height)
        navigationItem.titleView = foodLabel
        navigationItem.hidesSearchBarWhenScrolling = false
        setupSearch()
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    @objc func setupSearch() {
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.keyboardType = UIKeyboardType.asciiCapable
        searchController.searchBar.searchTextField.placeholder = "search for categories"
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        self.navigationItem.searchController = searchController
    
        
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        
    }
  
    
    
    func filterOptions() {
        
    }
}




class CategoryCell: UICollectionViewCell {
    let category: UILabel = {
        let label = UILabel()
        label.text = "haha"
        label.textAlignment = .center
        label.font = label.font.withSize(30)
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(category)
        category.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height:0)
        self.contentView.layer.cornerRadius = 35
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)//CGSizeMake(0, 2.0);
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
        
        
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}





extension UINavigationController {

    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }

}


