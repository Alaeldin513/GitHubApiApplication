//
//  RepoDetailsViewController.swift
//  Git Hub Application
//
//  Created by Mobile on 4/14/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UIViewController {
    
    @IBOutlet weak var repoTitle: UILabel!
    @IBOutlet weak var repoDetails: UILabel!
    @IBOutlet weak var repoStars: UILabel!
    var repo: Repo!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
