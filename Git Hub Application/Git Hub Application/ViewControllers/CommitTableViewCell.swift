//
//  CommitTableViewCell.swift
//  Git Hub Application
//
//  Created by Mobile on 4/14/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit

class CommitTableViewCell: UITableViewCell {

    @IBOutlet weak var commitTitle: UILabel!
    @IBOutlet weak var commitAuthor: UILabel!
    @IBOutlet weak var commitDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(commit: CommitWrapper){
        DispatchQueue.main.async { [unowned self] in
            self.commitTitle.text = commit.commit?.messsage
            self.commitAuthor.text = commit.commit?.author?.name
            self.commitDate.text = commit.commit?.author?.date?.toString(dateFormat: "MMM d, yyyy")
        }
    }

}
