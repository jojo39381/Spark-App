import UIKit
class SetupEmailViewController: UIViewController {
    var titleLabel: UILabel!
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    var errorLabel: UILabel!
    override func viewDidLoad() {
        view.backgroundColor = .systemGray6
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(saveButtonTapped))
        super.viewDidLoad()
        titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.text = "Email"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width * 0.05).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: view.frame.height * 0.1).isActive = true
        emailLabel = UILabel()
        emailLabel.numberOfLines = 5
        let text = NSMutableAttributedString.init(string: "Current Email\n\n" + (auth.currentUser?.email)! + "\n\nNew Email")
        text.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.gray], range: NSMakeRange(15, (auth.currentUser?.email)!.count))
        emailLabel.attributedText = text
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width * 0.05).isActive = true
        emailLabel.sizeToFit()
        emailTextField = UITextFieldPadding()
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9).isActive = true
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = view.frame.height * 0.01
        errorLabel = UILabel()
        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.numberOfLines = 0
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9).isActive = true
        errorLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
    }
    @objc func saveButtonTapped() {
    }
}
