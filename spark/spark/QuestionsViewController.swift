//
//  QuestionsViewController.swift
//  spark
//
//  Created by Joseph Yeh on 5/28/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SelectedDelegate {
    func didAdvance(selectedItems: [String]) {
        print(selectedItems)
        questionsView.scrollToNextItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type.count 
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! QuestionCell
        myCell.catCollectionView.reloadData()
        myCell.questionTitle.text = type[indexPath.item]
        myCell.array = array[indexPath.item]
        myCell.key = key[indexPath.item]
        myCell.nextButton.addTarget(self, action: #selector(nextAction(_:)), for: .touchUpInside)
        myCell.nextButton.tag = indexPath.item
        
        if indexPath.item == type.count - 1 {
            myCell.nextButton.setTitle("Done", for: .normal)
            myCell.nextButton.addTarget(self, action: #selector(doneAction(_:)), for: .touchUpInside)
        }
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.frame.size
    }
   
    
    let questionsView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 27, green: 108, blue: 168)
        layout.scrollDirection = .horizontal
        return cv
        
    }()
    
    let key = ["Food", "Chill", "Romantic"]
    
    let type = ["What is you or your partner's favorite types of food?", "What are some activities you would do on a chill date?", "QWhat are some activities you would do on a romantic date?"]
    let array = [["Chinese", "Japanese", "American", "French", "Korean", "Indian", "Burgers", "Fast Food", "Thai", "Canadian", "Italian", "Filipino", "German", "Mediterranean", "Mexican"],["Bowling", "Movies", "Stargazing", "Beaches", "Hiking", "Parks", "Fishing", "Shopping", "Escape Rooms", "Skydiving", "Swimming", "Golfing"], ["Dancing", "Beaches", "Sightseeing", "Wine Tasting", "Swimming", "Museum", "Camping", "Spa", "Food Tours", "Skydiving", "Trampolines", "Golfing"]]
    
    
    
    @objc func nextAction(_ sender : UIButton) {
        print("////////")
        let cell = questionsView.cellForItem(at: IndexPath(item: sender.tag, section: 0)) as! QuestionCell
        userSelectedModel.preferences.updateValue(cell.selectedItems, forKey: cell.key)
        questionsView.scrollToNextItem()
        
        
    }
    @objc func doneAction(_ sender : UIButton) {
        print("////////")
        let cell = questionsView.cellForItem(at: IndexPath(item: sender.tag, section: 0)) as! QuestionCell
        userSelectedModel.preferences.updateValue(cell.selectedItems, forKey: cell.key)
        print(userSelectedModel.preferences)
        let vc = TypesController()
        vc.userSelectedModel = userSelectedModel
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    
    
    
    var userSelectedModel = UserSelectedModel()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionsView.register(QuestionCell.self, forCellWithReuseIdentifier: "myCell")
        view.addSubview(questionsView)
        questionsView.frame = self.view.frame
        questionsView.delegate = self
        questionsView.dataSource = self
        self.title = "Spark"
        setupNav()
        
        
        // Do any additional setup after loading the view.
    }
    let theme = UIColor.rgb(red: 27, green: 108, blue: 168)
    

    
    func setupNav() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.backgroundColor = theme
        navigationBar.barTintColor = theme
        navigationBar.tintColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = false;
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationBar.titleTextAttributes = textAttributes
        
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
extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width + 10))
        
        self.moveToFrame(contentOffset: contentOffset)
    }

    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}
