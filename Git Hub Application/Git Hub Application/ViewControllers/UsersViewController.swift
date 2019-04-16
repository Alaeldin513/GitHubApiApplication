//
//  UsersViewController.swift
//  Git Hub Application
//
//  Created by Mobile on 4/14/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var users: [User]!
    var selectedUser: User!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection = 0
        
        if users.count > 0 {
            self.tableView.backgroundView = nil
            numOfSection = 1
            
        } else {
            
            var noDataLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
            noDataLabel.text = "No Data Available"
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = noDataLabel
        }
        return numOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var userCell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        userCell.configure(user: users[indexPath.row])
        return userCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedUser = users[indexPath.row]
        GithubAPIController.getUser(username: selectedUser.login ?? "") { result in
            switch result {
            case .success(let user):
                self.selectedUser = user
            case .failure(_): break
            }
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "segueToMainVC", sender: self)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! UserSearchViewController
        vc.user = self.selectedUser
    }
}
