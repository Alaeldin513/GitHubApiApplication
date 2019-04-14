//
//  UserInfoTableViewController.swift
//  Git Hub Application
//
//  Created by Mobile on 4/12/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit

protocol UserInfoTableViewControllerDelegate: class {
    func didTapCell(segueString: String,_ sender: Any)
}

class UserInfoTableViewController: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var user: User?
    var parentViewDelegate: UserInfoTableViewControllerDelegate!
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelInfoCell", for: indexPath) as! SimpleLabelCell
        switch indexPath {
        case TableViewIndexPaths.userName.indexPath:
            cell.cofigure(cellTitle: TableViewIndexPaths.userName.titleText, cellValue: user?.login ?? "")
        case TableViewIndexPaths.followers.indexPath:
            cell.cofigure(cellTitle: TableViewIndexPaths.followers.titleText, cellValue: String(describing: user?.followers ?? 0) )
        case TableViewIndexPaths.following.indexPath:
            cell.cofigure(cellTitle: TableViewIndexPaths.following.titleText, cellValue: String(describing: user?.following ?? 0) )
        case TableViewIndexPaths.repos.indexPath:
            
            cell.cofigure(cellTitle: TableViewIndexPaths.repos.titleText, cellValue: String(describing: user?.repos ?? 0))
        default:
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case TableViewIndexPaths.userName.indexPath:
            print("username clicked")
        case TableViewIndexPaths.followers.indexPath:
            print("username clicked")
        case TableViewIndexPaths.following.indexPath:
            print("username clicked")
        case TableViewIndexPaths.repos.indexPath:
            self.parentViewDelegate.didTapCell(segueString: "segueToRepos", self)
            break
        default:
            print("default")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}

enum TableViewIndexPaths {
    case userName
    case followers
    case following
    case repos
    
    
    var indexPath: IndexPath {
        var index: IndexPath? = nil
        switch self {
        case .userName:
            index = IndexPath(item: 0, section: 0)
        case .followers:
            index = IndexPath(item: 1, section: 0)
        case .following:
            index = IndexPath(item: 2, section: 0)
        case .repos:
            index = IndexPath(item: 3, section: 0)
        }
        return index!
    }
    
    var titleText: String {
        var title: String? = nil
        switch self {
        case .userName:
            title = "Username"
        case .followers:
            title = "Followers"
        case .following:
            title = "Following"
        case .repos:
            title = "Repositories"
        }
        return title!
    }
    
}
