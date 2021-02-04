import UIKit
import Firebase
class LoginViewController: UIViewController {
    var firstTimeUser = [String]()
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var errorLabel: UILabel!
    var kb = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.title = "Welcome Back"
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
                            self.dismiss(animated: false, completion: nil)
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
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.autocapitalizationType = .none
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.84).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.08 * 3.75).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: errorLabel.bottomAnchor).isActive = true
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = view.frame.height * 0.02
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        errorLabel.alpha = 0
        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleYellowButton(loginButton)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont(name: "RopaSans-Regular", size: 14)
        errorLabel.textColor = .systemRed
        let tap = UITapGestureRecognizer(target: view, action: #selector(self.view.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    @objc func backTapped() {
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
    @objc func loginTapped() {
        errorLabel.textColor = .systemRed
        errorLabel.alpha = 0
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
               // Couldn't sign in
                self.errorLabel.text = Utilities.handleError(error: error!)
                self.errorLabel.alpha = 1
            } else if !Auth.auth().currentUser!.isEmailVerified {
                self.errorLabel.text = "A verification has been sent to your email, please login after verifying"
                self.errorLabel.textColor = .systemGreen
                self.errorLabel.alpha = 1
                auth.currentUser?.sendEmailVerification{ (error) in
                    if error != nil {
                        self.errorLabel.text = Utilities.handleError(error: error!)
                    } else {
                        try! auth.signOut()
                        self.firstTimeUser.append(self.emailTextField.text!)
                    }
                }
            } else {
                Utilities.fetchProfileData() {
                    if self.firstTimeUser.contains(self.emailTextField.text!) {
                        let vc = SetupProfileViewController()
                        vc.firstTimeUser = true
                        self.present(vc, animated: false, completion: nil)
                    } else {
                        let sparkTabBarController = SparkTabBarController()
                        self.view.window!.rootViewController = sparkTabBarController
                        self.view.window?.makeKeyAndVisible()
                    }
               }
           }
       }
   }
}
