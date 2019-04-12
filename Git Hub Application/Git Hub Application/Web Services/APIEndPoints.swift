//
//  APIEndPoints.swift
//  Git Hub Application
//
//  Created by Mobile on 4/12/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum APIEndPoints{
    case getUser
    
    var baseUrl: URL {
        var url: URL
        switch self{
        case .getUser:
            url =  URL(string: "https://api.github.com/users/")!
        }
        return url
    }
}
