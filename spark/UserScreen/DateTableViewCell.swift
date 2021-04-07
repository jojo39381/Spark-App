import UIKit
class DateTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    var collectionView: UICollectionView!
    var dateLabel: UILabel!
    var line: UIView!
    var dot: UIView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dateLabel = UILabel()
        dateLabel.text = "\u{2022} date"
        dateLabel.textColor = .gray
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        dateLabel.sizeToFit()
        line = UIView()
        line.backgroundColor = .gray
        contentView.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3).isActive = true
        line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        line.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        line.widthAnchor.constraint(equalToConstant: 1).isActive = true
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: contentView.frame.height * 3.5, height: contentView.frame.height * 3.6)
        collectionView = UICollectionView(frame: contentView.frame, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = .clear
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: line.rightAnchor, constant: contentView.frame.width * 0.03).isActive = true
}
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath)
        cell.backgroundColor = .gray
    return cell
}
}
