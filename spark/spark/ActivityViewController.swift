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

protocol ActivityViewControllerDelegate {
    func didAddActivity(activity: String, alias: String)
}
class ActivityViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MenuViewDelegate, UISearchBarDelegate,UISearchControllerDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:180, height:190)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return categories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! CategoryCell
        
        myCell.layer.cornerRadius = 35
        
        myCell.backgroundColor = UIColor(randomFlatColorOf: UIShadeStyle.dark)
        
        
        myCell.category.text = Array(categories.keys)[indexPath.item]
        print(activityList)
        if activityList.keys.contains(myCell.category.text!) {
            print(myCell.category.text!)
            myCell.imageView.alpha = 1
        }
        else {
            myCell.imageView.alpha = 0
        }
        
        
        
        
        

        return myCell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myCell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        myCell.imageView.alpha = 1
        
        activityList.updateValue( Array(categories.values)[indexPath.item], forKey: Array(categories.keys)[indexPath.item])
        addSelect(activity: Array(categories.keys)[indexPath.item], alias: Array(categories.values)[indexPath.item])
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
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
        label.text = "Activities"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
        self.definesPresentationContext = true

    }
    var categories = [String:String]()
    var database = ActivityDatabase()
    
    
    var activityList = [String:String]()
    var delegate: ActivityViewControllerDelegate?
    
    // var delegate: ActivityViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodCollectionView.allowsMultipleSelection = true
        
        
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        

        setupNav()
        categories = database.categories
        
        
       
        
        
        
        
        
        foodCollectionView.dataSource = self
        foodCollectionView.delegate = self
        view.addSubview(foodCollectionView)
        foodCollectionView.frame = CGRect(x:0,y:0,width:view.frame.width, height:view.frame.height)
        foodCollectionView.contentInset = UIEdgeInsets(top: 60, left: 20, bottom: 10, right: 20)
        foodCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        
        setupMenuBar()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    func addSelect(activity: String, alias: String) {
        self.delegate?.didAddActivity(activity: activity, alias: alias)
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
    

    
    
    

       
       
    let icon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"activityicon")
        return image
    }()
    
    func setupNav() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = "Activity"
        navigationBar.isTranslucent = false;
        
        let title = UIView(frame: CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height))
        
        
        
        title.addSubview(foodLabel)
        
        foodLabel.anchor(top: title.topAnchor, left: title.leftAnchor, bottom: title.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        title.addSubview(icon)
        icon.anchor(top: title.topAnchor, left: foodLabel.rightAnchor, bottom: title.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        navigationItem.titleView = title
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

  
    
    
    func filterOptions() {
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
     categories = database.categories
     foodCollectionView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        foodCollectionView.keyboardDismissMode = .interactive
        if (searchText.count == 0) {
         categories = database.categories
        } else {
         categories = [String: String]()
         for i in 0..<database.categories.count {
             if (Array(database.categories.values)[i].lowercased().contains(searchText.lowercased())) {
                 categories.updateValue(Array(database.categories.values)[i], forKey: Array(database.categories.keys)[i])
                }
            }
        }
        foodCollectionView.reloadData()
    }
  
   
    

        
        
    }














