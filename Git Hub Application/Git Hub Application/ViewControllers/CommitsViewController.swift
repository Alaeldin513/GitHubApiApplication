//
//  RepoDetailsViewController.swift
//  Git Hub Application
//
//  Created by Mobile on 4/14/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit

class CommitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
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
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "commitCell", for: indexPath) as! CommitTableViewCell
        cell.configure(commit: commits[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 10, width: tableView.frame.width, height: 30))
            headerView.backgroundColor = .white
            let label = UILabel()
            label.frame = CGRect.init(x: 10, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            label.text = "Commits"
            label.textColor = UIColor(red: 163/255, green: 211/255, blue: 112/255, alpha: 1)
            headerView.addSubview(label)
            label.backgroundColor = .clear
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
