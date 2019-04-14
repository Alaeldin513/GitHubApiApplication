//
//  UserModel.swift
//  Git Hub Application
//
//  Created by Mobile on 4/12/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import Foundation


struct User: Decodable {
    var login: String?
    var id: Int?
    var nodeID: String?
    var avatarUrl: String?
    var gravatarID: String?
    var profileUrl: String?
    var followersAPIUrl: String?
    var reposAPIUrl: String?
    var followers: Int?
    var following: Int?
    var repos: Int?
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case nodeID = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarID = "gravatar_id"
        case profileUrl = "url"
        case followersAPIUrl = "followers_url"
        case reposAPIUrl = "repos_url"
        case followers = "followers"
        case following = "following"
        case repos = "public_repos"
        
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
        self.followers = try container.decodeIfPresent(Int.self, forKey: .followers)
        self.following = try container.decodeIfPresent(Int.self, forKey: .following)
        self.repos = try container.decodeIfPresent(Int.self, forKey: .repos)
    }
}
