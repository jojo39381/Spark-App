import UIKit
class SetupPasswordViewController: UIViewController {
    var titleLabel: UILabel!
    override func viewDidLoad() {
        view.backgroundColor = .systemGray6
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(saveButtonTapped))
        super.viewDidLoad()
        titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.text = "Password"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width * 0.05).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: view.frame.height * 0.1).isActive = true
    }
    @objc func saveButtonTapped() {
    }
}
