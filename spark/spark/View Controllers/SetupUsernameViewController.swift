import UIKit
import Firebase
class SetupUsernameViewController: UIViewController {
    var titleLabel: UILabel!
    var errorLabel: UILabel!
    var usernameTextField: UITextField!
    var checkButton: UIBarButtonItem!
    var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.text = "Username"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width * 0.05).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: view.frame.height * 0.1).isActive = true
        usernameTextField = UITextFieldPadding()
        usernameTextField.autocapitalizationType = .none
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        usernameTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9).isActive = true
        usernameTextField.backgroundColor = .white
        usernameTextField.placeholder = "Username"
        usernameTextField.text = username
        usernameTextField.layer.cornerRadius = view.frame.height * 0.01
        usernameTextField.addTarget(self, action: #selector(textfieldEditing), for: .editingChanged)

        
        errorLabel = UILabel()
        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.numberOfLines = 0
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9).isActive = true
        errorLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: view, action: #selector(self.view.endEditing(_:)))
        view.addGestureRecognizer(tap)
        checkButton = UIBarButtonItem(title: "check", style: .plain, target: self, action: #selector(checkUsername))
        saveButton = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(confirmButtonTapped))
        navigationItem.rightBarButtonItem = checkButton
    }
    @objc func checkUsername() {
        view.endEditing(true)
        Utilities.checkUsername(username: usernameTextField.text!) { same in
            if same {
                self.errorLabel.textColor = .systemRed
                if self.usernameTextField.text == username {
                    self.errorLabel.text = "This is your current username"
                } else {
                    self.errorLabel.text = "Username unavalaible"
                }
            } else {
                self.self.errorLabel.text = "Username is avalaible"
                self.errorLabel.textColor = .systemGreen
                self.navigationItem.rightBarButtonItem = self.saveButton
            }
        }
    }
    @objc func confirmButtonTapped() {
        username = usernameTextField.text
        self.navigationController?.popViewController(animated: false)
    }
    @objc func textfieldEditing() {
        errorLabel.text = ""
        navigationItem.rightBarButtonItem = checkButton
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
