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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var userCell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        userCell.configure(user: users[indexPath.row])
        return userCell
    }


}
