//
//  RepoInfoTableViewController.swift
//  Git Hub Application
//
//  Created by Mobile on 4/12/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit

class RepoInfoTableViewController: UITableViewController {
    
    var repos: [Repo]!
    var commits: [CommitWrapper]!
    var selectedRepo: Repo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.delegate = self
        tableView.backgroundView = nil
        tableView.tableFooterView = UIView()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return repos.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoInfoCell", for: indexPath) as! RepoInfoTableViewCell
        cell.congfigureWith(repo: repos[indexPath.section])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedRepo = repos[indexPath.section]
        GithubAPIController.getRepoCommits(commitsUrl: selectedRepo.commitUrl ?? ""){ [unowned self] result in
            switch result {
            case .success(let commits):
                self.commits = commits
                self.selectedRepo = selectedRepo
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "segueToRepoDetails", sender: self)
                }
            case .failure(_):
                break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRepoDetails" {
            var repodetailsVC = segue.destination as! CommitsViewController
            repodetailsVC.repo = self.selectedRepo
            repodetailsVC.commits = self.commits
        }
    }


}
