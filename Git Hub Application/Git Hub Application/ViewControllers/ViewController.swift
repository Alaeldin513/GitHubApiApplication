//
//  ViewController.swift
//  Git Hub Application
//
//  Created by Mobile on 4/12/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UserInfoTableViewControllerDelegate {
  
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var userTableView: UserInfoTableViewController!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    let tableViewController = UserInfoTableViewController()
    var user: User?
    var repos: [Repo]!
    var users: [User]!

    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.delegate = tableViewController
        userTableView.dataSource = tableViewController
        userTableView.tableFooterView = UIView()
        tableViewController.parentViewDelegate = self
        userTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func performSearchForUser(_ sender: Any) {
        GithubAPIController.getUser(username: searchTextField.text ?? ""){[unowned self] result in
            switch result {
            case .success(let user):
                UserDefaults.saveUserSearch(user)
                self.tableViewController.user = user
                self.tableViewController.recentSearches = UserDefaults.recentUsers
                self.user = user
                DispatchQueue.main.async {
                    self.updateUserInfo(user: user)
                    self.userTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }

    }
    
    func updateUserInfo(user: User){
        DispatchQueue.main.async {
            if let imagedata = user.imageData {
                self.profileImage.image = UIImage(data: imagedata)
            }
            
            if let userName = user.name {
                self.nameLabel.text = userName
                self.nameLabel.isHidden = false
            } else {
                self.nameLabel.isHidden = true
            }
            
            if let bio = user.bio {
                self.bioLabel.text = "Bio: \(bio)"
                self.bioLabel.isHidden = false
            } else {
                self.bioLabel.isHidden = true
            }
            
            if let email = user.email {
                self.emailLabel.text = "Email: \(email)"
                self.emailLabel.isHidden = false
            } else {
                self.emailLabel.isHidden = true
            }
            
            if let location = user.location {
                self.locationLabel.text = "Location: \(location)"
                self.locationLabel.isHidden = false
            } else {
                self.locationLabel.isHidden = true
            }
        }
        
    }
    func didTapCell(segueString: String, _ sender: Any) {
        if segueString == "segueToRepos" {
            GithubAPIController.getRepos(repoUrl: user?.reposAPIUrl ?? ""){ result in
                switch result {
                case .success(let repos):
                    DispatchQueue.main.async {
                        self.repos = repos
                        self.performSegue(withIdentifier: segueString, sender: sender)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else if segueString == "segueToFollowers" || segueString == "segueToFollowing" {
            var urlString = segueString == "segueToFollowers" ? user?.followersAPIUrl: user?.followingAPIUrl?.replacingOccurrences(of: "{/other_user}", with: "")
            GithubAPIController.getListOfUsers(usersUrl: urlString ?? ""){ result in
                switch result {
                case .success(let users):
                    DispatchQueue.main.async {
                        self.users = users
                        self.performSegue(withIdentifier: segueString, sender: sender)
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
    func updateUserDetails(user: User) {
        self.user = user
        self.profileImage.isHidden = true
        self.updateUserInfo(user: user)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRepos" {
            let repoViewController = segue.destination as! RepoInfoTableViewController
            repoViewController.repos = self.repos
        } else if segue.identifier == "segueToFollowing" || segue.identifier == "segueToFollowers" {
            let usersViewController  = segue.destination as! UsersViewController
            usersViewController.users = self.users
        }
    }
    
}

