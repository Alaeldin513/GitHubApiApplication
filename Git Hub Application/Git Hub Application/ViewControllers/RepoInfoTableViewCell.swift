//
//  RepoInfoTableViewCell.swift
//  Git Hub Application
//
//  Created by Mobile on 4/13/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit

class RepoInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoLanguage: UILabel!
    @IBOutlet weak var repoStars: UILabel!
    @IBOutlet weak var repoForks: UILabel!
    @IBOutlet weak var repoLastUpdatedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func congfigureWith(repo: Repo) {
        repoName.text = repo.name
        repoLanguage.text = repo.language
        repoStars.text = "\(repo.stars ?? 0)"
        repoForks.text = "\(repo.forks ?? 0)"
        repoLastUpdatedDate.text = repo.lastUpdateDate?.toString(dateFormat: "MMM d, yyyy")
    }

}
