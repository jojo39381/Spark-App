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





protocol FoodViewControllerDelegate {
    func didAddSelected(foodSelected:String, foodAlias: String)
}
class FoodViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MenuViewDelegate, UISearchBarDelegate,UISearchControllerDelegate, CategoriesManagerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:170, height:190)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return categories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! CategoryCell
    
        myCell.layer.cornerRadius = 35
        
        myCell.backgroundColor = UIColor(randomFlatColorOf: UIShadeStyle.dark)
        
        
        myCell.category.text = Array(self.categories.keys)[indexPath.item]
        
        print(foodList)
        
        
        if foodList.keys.contains(myCell.category.text!) {
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
        
        
        foodList.updateValue(Array(self.categories.values)[indexPath.item], forKey:Array(self.categories.keys)[indexPath.item])
        addSelected(foodSelected: myCell.category.text!, foodAlias: Array(categories.values)[indexPath.item])
    
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let myCell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        foodList.removeValue(forKey: myCell.category.text!)
        myCell.imageView.alpha = 0
        
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
        label.text = "Food"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
        self.definesPresentationContext = true

    }
    
    var manager = CategoriesManager()
    var foodList = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        foodCollectionView.allowsMultipleSelection = true
        
        
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        manager.delegate = self

        setupNav()
        
        
       
        
        loadCategories()
        
        
        
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
    

    
    
    let icon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"sushi")
        return image
    }()
    
    
    
    func setupNav() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
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
    
    
    var delegate: FoodViewControllerDelegate?
    func addSelected(foodSelected: String, foodAlias: String) {
        self.delegate?.didAddSelected(foodSelected: foodSelected, foodAlias: foodAlias)
    }
    
    
    
    func loadCategories() {
        
        manager.fetchCategories()
        
    }
    
    var categories = [String:String]()
    var categoryHolder: CategoryModel!
    func didLoadCategories(categoryData: CategoryModel) {
        print("lmao")
        categories = categoryData.category
        categoryHolder = categoryData
        print(categories)
        DispatchQueue.main.async {
           self.foodCollectionView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        categories = categoryHolder.category
        foodCollectionView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        foodCollectionView.keyboardDismissMode = .interactive
        if (searchText.count == 0) {
            categories = categoryHolder.category
        } else {
            categories = [String:String]()
            for i in 0..<categoryHolder.category.count {
                if (Array(categoryHolder.category.keys)[i].lowercased().contains(searchText.lowercased())) {
                    categories.updateValue(Array(categoryHolder.category.values)[i], forKey: Array(categoryHolder.category.keys)[i])
                }
            }
        }
        foodCollectionView.reloadData()
    }
}





class CategoryCell: UICollectionViewCell {
    let category: UILabel = {
        let label = UILabel()
        label.text = "haha"
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"checkmark")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .white
        image.alpha = 0
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(category)
        contentView.addSubview(imageView)
        imageView.frame = CGRect(x:frame.width - 35,y:20, width:20, height:20)
        category.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height:0)
        self.contentView.layer.cornerRadius = 35
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.cornerRadius = 35
        
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 8)//CGSizeMake(0, 2.0);
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
        
        
            
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
extension UILabel
{
    func addImage(imageName: String, afterLabel bolAfterLabel: Bool = false)
    {
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)

        if (bolAfterLabel)
        {
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
            strLabelText.append(attachmentString)

            self.attributedText = strLabelText
        }
        else
        {
            let strLabelText: NSAttributedString = NSAttributedString(string: self.text!)
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)

            self.attributedText = mutableAttachmentString
        }
    }

    func removeImage()
    {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}


