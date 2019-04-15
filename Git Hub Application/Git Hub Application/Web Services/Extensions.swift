//
//  File.swift
//  Git Hub Application
//
//  Created by Mobile on 4/13/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import Foundation
import UIKit

extension Date
{
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.shadowRadius = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            layer.shadowColor = UIColor.darkGray.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            layer.shadowColor = UIColor.black.cgColor
            layer.masksToBounds = false
        }
    }
    
}

extension UserDefaults {
    
    class var recentUsers: [User] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "RecentUsers") else { return [] }
            guard let users = try? JSONDecoder().decode([User].self, from: data) else {
                return []
            }
            return users
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "RecentUsers")
            }
        }
    }
    
    class func saveUserSearch(_ user: User) {
        var recent = UserDefaults.recentUsers.filter({$0.id == user.id})
        recent.append(user)
        UserDefaults.recentUsers = recent
    }
}
