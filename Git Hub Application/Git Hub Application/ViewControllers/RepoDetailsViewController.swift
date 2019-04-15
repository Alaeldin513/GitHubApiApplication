//
//  RepoDetailsViewController.swift
//  Git Hub Application
//
//  Created by Mobile on 4/14/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var repoTitle: UILabel!
    @IBOutlet weak var repoDetails: UILabel!
    @IBOutlet weak var repoStars: UILabel!
    @IBOutlet weak var repoLanguage: UILabel!
    @IBOutlet weak var repoForks: UILabel!
    @IBOutlet weak var repoUpdateDate: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var repo: Repo!
    var commits: [CommitWrapper]!
    var currentlyShowing = "Commits"
    lazy var branches: [CommitWrapper] = commits
    lazy var releases: [CommitWrapper] = commits
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        updateLabels()
        // Do any additional setup after loading the view.
    }
    
    func updateLabels(){
        DispatchQueue.main.async { [unowned self] in
            self.repoTitle.text = self.repo.name
            self.repoDetails.text = self.repo.Description
            self.repoStars.text = "Stars: \(self.repo.stars ?? 0)"
            self.repoForks.text = "Forks: \(self.repo.forks ?? 0)"
            self.repoUpdateDate.text = self.repo.lastUpdateDate?.toString(dateFormat: "MMM d, yyyy")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentlyShowing {
        case "Commits":
            return commits.count
        case "Branches":
            return branches.count
        case "Releases":
            return releases.count
        case "Contributors":
            break
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "commitCell", for: indexPath) as! CommitTableViewCell
        switch currentlyShowing {
        case "Commits":
            cell.configure(commit: commits[indexPath.row])
            return cell
        case "Branches":
            cell.configure(commit: commits[indexPath.row])
            return cell
        case "Releases":
            cell.configure(commit: commits[indexPath.row])
            return cell
        case "Contributors":
            cell.configure(commit: commits[indexPath.row])
            return cell
        default:
            cell.configure(commit: commits[indexPath.row])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    @IBAction func tabBarButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.currentlyShowing = "Commits"
        case 1:
            self.currentlyShowing = "Branches"
        case 2:
            self.currentlyShowing = "Releases"
        case 3:
            self.currentlyShowing = "Contributors"
        default:
            break
        }
        DispatchQueue.main.async {
            
        }
    }
}
