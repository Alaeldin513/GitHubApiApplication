//
//  GithubAPIController.swift
//  Git Hub Application
//
//  Created by Mobile on 4/12/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit

class GithubAPIController: NSObject {
    class func getUser(username: String, completion: @escaping (_ result: Result<User>) -> Void){
        let path = "\(username)"
        let url = URL(fileURLWithPath: path, relativeTo: APIEndPoints.getUser.baseUrl)
        
        let success: ((Data) -> Void) = { data in
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
            } catch{
                completion(.failure(APIErrors.invalidJsonResponse))
            }
        }
        
        let failure: ((Error) -> Void) = { error in
                completion(.failure(error))
        }
        
        WebServiceManager.shared.get(url: url, headerFields: [:], success: success, failure: failure)
    }
}



struct User: Decodable {
    var login: String?
    var id: Int?
    var nodeID: String?
    var avatarUrl: String?
    var gravatarID: String?
    var profileUrl: String?
    var followersAPIUrl: String?
    var reposAPIUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case nodeID = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarID = "gravatar_id"
        case profileUrl = "url"
        case followersAPIUrl = "followers_url"
        case reposAPIUrl = "repos_url"
        
    }
}

extension User {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.login = try container.decodeIfPresent(String.self, forKey: .login)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.nodeID = try container.decodeIfPresent(String.self, forKey: .nodeID)
        self.avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        self.gravatarID = try container.decodeIfPresent(String.self, forKey: .gravatarID)
        self.profileUrl = try container.decodeIfPresent(String.self, forKey: .profileUrl)
        self.followersAPIUrl = try container.decodeIfPresent(String.self, forKey: .followersAPIUrl)
        self.reposAPIUrl = try container.decodeIfPresent(String.self, forKey: .reposAPIUrl)
    }
}
