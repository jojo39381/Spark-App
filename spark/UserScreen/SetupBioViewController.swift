import UIKit
class SetupBioViewController: UIViewController {
    var titleLabel: UILabel!
    var bioTextView: UITextView!
    override func viewDidLoad() {
        view.backgroundColor = .systemGray6
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(doneButtonTapped))
        super.viewDidLoad()
        titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.text = "Bio"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width * 0.05).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: view.frame.height * 0.1).isActive = true
        bioTextView = UITextView()
        bioTextView.isEditable = true
        bioTextView.font = .systemFont(ofSize: 18)
        view.addSubview(bioTextView)
        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        bioTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        bioTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bioTextView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.15).isActive = true
        bioTextView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9).isActive = true
        bioTextView.backgroundColor = .white
        bioTextView.text = bio
        bioTextView.layer.cornerRadius = view.frame.height * 0.01
        // Do any additional setup after loading the view.
    }
    @objc func doneButtonTapped() {
        bio = bioTextView.text
        self.navigationController?.popViewController(animated: false)
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
