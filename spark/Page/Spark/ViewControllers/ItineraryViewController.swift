//
//  ItineraryViewController.swift
//  spark
//
//  Created by Joseph Yeh on 6/3/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import MapKit

protocol ItineraryDelegate {
    func displaySuccessView()
}

class ItineraryViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cur = dateOrder![indexPath.item]
        UIApplication.shared.open(dateInfo![cur]![6] as! URL, options: [:], completionHandler: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! ItineraryCell
        let cur = dateOrder![indexPath.item]
        myCell.imageView.downloaded(from: dateInfo![cur]![4] as! String)
        let titleString = NSMutableAttributedString.init(string: cur + "\n" + (dateInfo![cur]![0] as! [String])[0])
        titleString.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                                   NSAttributedString.Key.foregroundColor: UIColor.gray],
                                  range: NSMakeRange(cur.count, titleString.length - cur.count))
        myCell.title.attributedText = titleString
        let numReviews = String(Int(dateInfo![cur]![2] as! Float))
        myCell.review.text = String(dateInfo![cur]![1] as! Float) + " (\(numReviews))"
        
        let address = dateInfo![cur]![5] as! [String]
        var addressString = ""
        for i in 0..<address.count {
            addressString.append(address[i])
            if i != address.count - 1 {
                addressString.append("\n")
            }
        }
        myCell.address.text = addressString
       
//        myCell.category.text = (dateInfo![cur]![0] as! [String])[0]
        
        myCell.goButton.tag = indexPath.item
        myCell.goButton.addTarget(self, action: #selector(getDirection(_:)), for: .touchUpInside)
        if editMode == true {
            myCell.deleteButton.isHidden = false
        }
        else {
            myCell.deleteButton.isHidden = true
        }
        
        
        return myCell
    }
    
    @objc func getDirection(_ sender: UIButton) {
        let cur = dateOrder![sender.tag]
        let coordinates = dateInfo![cur]![3] as! [Float]
        let clCoordinates = CLLocationCoordinate2D(latitude:
        CLLocationDegrees(coordinates[0]), longitude: CLLocationDegrees(coordinates[1]))
        openMapsAppWithDirections(to: clCoordinates, destinationName: "Hello")
    }
    
   
   @objc func openMapsAppWithDirections(to coordinate: CLLocationCoordinate2D, destinationName name: String) {
         let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
         let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
         let mapItem = MKMapItem(placemark: placemark)
         mapItem.name = name // Provide the name of the destination in the To: field
           mapItem.openInMaps(launchOptions: options)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 370)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

    var actCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.dragInteractionEnabled = true
        cv.backgroundColor = .white
        return cv
    }()
    
    var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
       
        return button
    }()
    
    var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("confirm", for: .normal)
        button.backgroundColor = .white
        return button
    }()
    var imageDict: [String : String]?
    var dateInfo: [String: [Any]]?
    var dateOrder: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Itinerary"
        
        self.navigationController?.navigationBar.addSubview(editButton)
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        editButton.anchor(top: nil, left: nil, bottom: navigationBar.bottomAnchor, right: navigationBar.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -12, paddingRight: -16, width: 0, height: 0);
         editButton.addTarget(self, action: #selector(editMode(_:)), for: .touchUpInside)
        self.view.addSubview(actCollectionView)
      
        
        actCollectionView.frame = CGRect(x:0, y:0, width: self.view.frame.width, height: self.view.frame.height - 300)
        actCollectionView.dragDelegate = self
        actCollectionView.dropDelegate = self
        actCollectionView.register(ItineraryCell.self, forCellWithReuseIdentifier: "myCell")
        actCollectionView.register(ConfirmButtonFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        actCollectionView.delegate = self
        actCollectionView.dataSource = self
        actCollectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        // Do any additional setup after loading the view.
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureReconizer:)))
            lpgr.minimumPressDuration = 0.5
            lpgr.delaysTouchesBegan = true
            lpgr.delegate = self
            self.actCollectionView.addGestureRecognizer(lpgr)
    }
    
    var delegate: ItineraryDelegate?
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {


        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as! ConfirmButtonFooter
            footer.confirmButton.addTarget(self, action: #selector(displaySuccess(_:)), for: .touchUpInside)
            
            return footer

        default:
            fatalError("Unexpected element kind")
           
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 200)
    }
    var editMode = false
    
    @objc func editMode(_ sender: UIButton) {
        
        editMode = !editMode
        
        
        self.actCollectionView.reloadData()
    }
    
    @objc func displaySuccess(_ sender: UIButton) {
        delegate?.displaySuccessView()
    }

    
    func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        if let item = coordinator.items.first,
            let sourceIndexPath = item.sourceIndexPath {
            collectionView.performBatchUpdates({
                self.dateOrder?.remove(at: sourceIndexPath.item)
                self.dateOrder?.insert(item.dragItem.localObject as! String, at: destinationIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
                
            }, completion: nil)
            coordinator.drop(item.dragItem, toItemAt:destinationIndexPath)
        }
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
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    
}

extension ItineraryViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = self.dateOrder![indexPath.item]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
        
    }
    
    
}

extension ItineraryViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrop {
            return UICollectionViewDropProposal(operation:.move, intent: .insertAtDestinationIndexPath)
            
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        }
        else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: row - 1, section: 0)
        }
        
        if coordinator.proposal.operation == .move {
            print("lmaoasdkahsbdkabdhabdb")
            self.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        }
    }
}

extension ItineraryViewController: UIGestureRecognizerDelegate {

 @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
    if gestureReconizer.state != UIGestureRecognizer.State.ended {
         return
     }

    let p = gestureReconizer.location(in: self.actCollectionView)
    let indexPath = self.actCollectionView.indexPathForItem(at: p)

     if let index = indexPath {
        var cell = self.actCollectionView.cellForItem(at: index)
        editMode = !editMode
        self.actCollectionView.reloadData()
            print(indexPath?.item)
     } else {
         print("Could not find index path")
     }
 }
   
}

