//
//  UserTableViewCell.swift
//  Git Hub Application
//
//  Created by Mobile on 4/14/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(user: User){
        DispatchQueue.main.async { [unowned self] in
            if let imagedata = user.imageData {
                self.userImage.image = UIImage(data: imagedata)
            }
            self.usernameLabel.text = user.login
            self.nameLabel.text = user.name
            self.bioLabel.text = user.bio
            self.locationLabel.text = user.location
            self.emailLabel.text = user.email
        }
        
    }
    
}
