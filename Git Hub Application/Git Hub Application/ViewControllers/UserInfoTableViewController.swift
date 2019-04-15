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
    func updateUserDetails(user: User)
}

class UserInfoTableViewController: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var user: User?
    var parentViewDelegate: UserInfoTableViewControllerDelegate!
    var recentSearches = UserDefaults.recentUsers
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? 4:recentSearches.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LabelInfoCell", for: indexPath) as! SimpleLabelCell
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
            var userCell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
            userCell.configure(user: recentSearches[indexPath.row])
            return userCell
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case TableViewIndexPaths.userName.indexPath:
            print("username clicked")
        case TableViewIndexPaths.followers.indexPath:
            self.parentViewDelegate.didTapCell(segueString: "segueToFollowers", self)
        case TableViewIndexPaths.following.indexPath:
            self.parentViewDelegate.didTapCell(segueString: "segueToFollowing", self)
        case TableViewIndexPaths.repos.indexPath:
            self.parentViewDelegate.didTapCell(segueString: "segueToRepos", self)
            break
        default:
            DispatchQueue.main.async {
                self.user = self.recentSearches[indexPath.row]
                self.parentViewDelegate.updateUserDetails(user: self.recentSearches[indexPath.row])
                tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 10, width: tableView.frame.width, height: 30))
            headerView.backgroundColor = UIColor(red: 36/255, green: 41/255, blue: 46/255, alpha: 1)
            let label = UILabel()
            label.frame = CGRect.init(x: 10, y: 10, width: headerView.frame.width-10, height: headerView.frame.height-10)
            label.text = "Recent Searches"
            label.textColor = UIColor(red: 163/255, green: 211/255, blue: 112/255, alpha: 1)
            headerView.addSubview(label)
            label.backgroundColor = .clear
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 40
        }
    }
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
