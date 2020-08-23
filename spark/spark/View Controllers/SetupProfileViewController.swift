import UIKit
class SetupProfileViewController: UIViewController {
    var firstTimeUser = false
    var titleLabel: UILabel!
    var profileTableView: UITableView!
    override func viewDidLoad() {
        if firstTimeUser {
            navigationItem.hidesBackButton = true
        }
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.text = "Settings"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width * 0.05).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: view.frame.height * 0.1).isActive = true
        profileTableView = UITableView(frame: view.frame, style: .grouped)
        view.addSubview(profileTableView)
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -view.frame.height * 0.04).isActive = true
        profileTableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        profileTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UITableViewCell.self, forCellReuseIdentifier: "profile")
        view.bringSubviewToFront(titleLabel)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        profileTableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        db.collection("users").document(auth.currentUser!.uid).updateData(["username": username!, "bio": bio!]) { (error) in
            super.viewWillDisappear(animated)
        }
    }
    func navigate() {
        if firstTimeUser {
            self.navigationController?.pushViewController(QuestionsViewController(), animated: false)
        } else {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    func logoutButtonTapped() {
        try! auth.signOut()
        self.view.window?.rootViewController = StartViewController()
        self.view.window?.makeKeyAndVisible()
    }
}
extension SetupProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 1
        default:
            return 2
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .value1, reuseIdentifier: "profile")
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.text = "Username"
                cell.detailTextLabel?.text = username
            case 1:
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.text = "Bio"
                cell.detailTextLabel?.text = bio
            default:
                print("nothing")
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.text = "Email"
                cell.detailTextLabel?.text = (auth.currentUser?.email)!
            case 1:
                cell.textLabel?.text = "Password"
            default:
                print("nothing")
            }
        default:
            cell = UITableViewCell(style: .default, reuseIdentifier: "profile")
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "Log Out"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                navigationController?.pushViewController(SetupUsernameViewController(), animated: true)
            case 1:
                navigationController?.pushViewController(SetupBioViewController(), animated: true)
            default:
                print("nothing")
            }
        case 1:
            switch indexPath.row {
            case 0:
                navigationController?.pushViewController(SetupEmailViewController(), animated: true)
            case 1:
                navigationController?.pushViewController(SetupPasswordViewController(), animated: true)
            default:
                print("nothing")
            }
        default:
            logoutButtonTapped()
        }
    }
}
