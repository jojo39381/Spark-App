import UIKit
import Firebase
class SignUpViewController: UIViewController {
    var usernameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var passwordAgainTextField: UITextField!
    var signUpButton: UIButton!
    var errorLabel: UILabel!
    var kb = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.title = "Join Spark"
        view.layer.cornerRadius = view.frame.width / 8;
        view.layer.masksToBounds = true;
        setUpElements()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        view.addGestureRecognizer(panGesture)
    }
    @objc func keyboardWillShow(notification: NSNotification) {            self.view.frame.origin.y = -10
        kb = true
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = view.frame.height * 0.35
        kb = false
    }
    public var minimumVelocityToHide: CGFloat = 1500
    public var minimumScreenRatioToHide: CGFloat = 0.3
    public var animationDuration: TimeInterval = 0.2
    func slideViewVerticallyTo(_ y: CGFloat) {
        if kb {
            self.view.frame.origin = CGPoint(x: 0, y: -10 + y)
        } else {
            self.view.frame.origin = CGPoint(x: 0, y: view.frame.height * 0.35 + y)
        }
    }
    @objc func onPan(_ panGesture: UIPanGestureRecognizer) {
           switch panGesture.state {
           case .began, .changed:
               // If pan started or is ongoing then
               // slide the view to follow the finger
               let translation = panGesture.translation(in: view)
               let y = max(0, translation.y)
               slideViewVerticallyTo(y)
           case .ended:
               // If pan ended, decide it we should close or reset the view
               // based on the final position and the speed of the gesture
               let translation = panGesture.translation(in: view)
               let velocity = panGesture.velocity(in: view)
               let closing = (translation.y > self.view.frame.size.height * minimumScreenRatioToHide) ||
                             (velocity.y > minimumVelocityToHide)
               if closing {
                   UIView.animate(withDuration: animationDuration, animations: {
                       // If closing, animate to the bottom of the view
                       self.slideViewVerticallyTo(self.view.frame.size.height)
                   }, completion: { (isCompleted) in
                       if isCompleted {
                           // Dismiss the view when it dissapeared
                        self.dismiss(animated: true, completion: nil)
                       }
                   })
               } else {
                   // If not closing, reset the view to the top
                   UIView.animate(withDuration: animationDuration, animations: {
                    self.slideViewVerticallyTo(0)
                   })
               }
           default:
               // If gesture state is undefined, reset the view to the top
               UIView.animate(withDuration: animationDuration, animations: {
                self.slideViewVerticallyTo(0)
               })
           }
       }
    func setUpElements() {
        errorLabel = UILabel()
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.84).isActive = true
        errorLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        usernameTextField = UITextField()
        usernameTextField.placeholder = "Username"
        usernameTextField.autocapitalizationType = .none
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.autocapitalizationType = .none
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordAgainTextField = UITextField()
        passwordAgainTextField.placeholder = "Confirm Password"
        passwordAgainTextField.isSecureTextEntry = true
        signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.84).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.08 * 6.25).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: errorLabel.bottomAnchor).isActive = true
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = view.frame.height * 0.02
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordAgainTextField)
        stackView.addArrangedSubview(signUpButton)
        // Hide the error label
        errorLabel.alpha = 0
        // Style the elements
        Utilities.styleTextField(usernameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(passwordAgainTextField)
        Utilities.styleYellowButton(signUpButton)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont(name: "RopaSans-Regular", size: 14)
        errorLabel.textColor = .systemRed
        let tap = UITapGestureRecognizer(target: view, action: #selector(self.view.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    @objc func cancelButtonTapped() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        // Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordAgainTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "*Please fill in all fields."
        }
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "*Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        if passwordTextField.text != passwordAgainTextField.text {
            return "*Passwords did not match."
        }
        return nil
    }

    @objc func signUpTapped() {
        errorLabel.alpha = 0
        // Validate the fields
        let error = validateFields()
        if error != nil {
            // There's something wrong with the fields, show error message
            self.errorLabel.text = error!
            self.errorLabel.alpha = 1
        } else {
            Utilities.checkUsername(username: usernameTextField.text!) { same in
                if same {
                    self.errorLabel.textColor = .systemRed
                    self.errorLabel.text = "Username unavalaible"
                } else {
                    let email = self.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let password = self.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    //Create the user
                    auth.createUser(withEmail: email, password: password) { (result, err) in
                        // Check for errors
                        if err != nil {
                            // There was an error creating the user
                            self.errorLabel.text = Utilities.handleError(error: err!)
                            self.errorLabel.alpha = 1
                        }
                        else {
                            // User was created successfully, now store the first name and last name
                            db.collection("users").document(result!.user.uid).setData(["username": self.usernameTextField.text!, "preferences": [String: String]()]) { (error) in
                                if error != nil {
                                    // Show error message
                                    self.errorLabel.text = Utilities.handleError(error: error!)
                                    self.errorLabel.alpha = 1
                                }
                            }
                            try! Auth.auth().signOut()
                            let loginViewController = LoginViewController()
                            self.present(loginViewController, animated: true, completion: nil)
                            loginViewController.emailTextField.text = email
                            loginViewController.passwordTextField.text = password
                            loginViewController.loginTapped()
                        }
                    }
                }
            }
        }
    }
}
