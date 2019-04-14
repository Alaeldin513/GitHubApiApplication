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
    let tableViewController = UserInfoTableViewController()
    var user: User?
    var repos: [Repo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.delegate = tableViewController
        userTableView.dataSource = tableViewController
        userTableView.tableFooterView = UIView()
        tableViewController.parentViewDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func performSearchForUser(_ sender: Any) {
        GithubAPIController.getUser(username: searchTextField.text ?? ""){[unowned self] result in
            switch result {
            case .success(let user):
                print(user)
                self.tableViewController.user = user
                self.user = user
                DispatchQueue.main.async {
                    self.userTableView.reloadData()
                }
            case .failure(let error):
                print(error)
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
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRepos" {
            let repoViewController = segue.destination as! RepoInfoTableViewController
            repoViewController.repos = self.repos
        }
    }
    
}

