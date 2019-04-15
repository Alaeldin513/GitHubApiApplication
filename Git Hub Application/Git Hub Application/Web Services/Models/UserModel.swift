//
//  UserModel.swift
//  Git Hub Application
//
//  Created by Mobile on 4/12/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import Foundation


struct User: Codable {
    var login: String?
    var id: Int?
    var nodeID: String?
    var imageUrl: String?
    var gravatarID: String?
    var profileUrl: String?
    var followersAPIUrl: String?
    var reposAPIUrl: String?
    var followers: Int?
    var following: Int?
    var repos: Int?
    var imageData: Data?
    var name: String?
    var bio: String?
    var location: String?
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case nodeID = "node_id"
        case imageUrl = "avatar_url"
        case gravatarID = "gravatar_id"
        case profileUrl = "url"
        case followersAPIUrl = "followers_url"
        case reposAPIUrl = "repos_url"
        case followers = "followers"
        case following = "following"
        case repos = "public_repos"
        case name = "name"
        case bio = "bio"
        case email = "email"
        case location = "location"
        
    }
}

extension User {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.login = try container.decodeIfPresent(String.self, forKey: .login)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.nodeID = try container.decodeIfPresent(String.self, forKey: .nodeID)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        self.gravatarID = try container.decodeIfPresent(String.self, forKey: .gravatarID)
        self.profileUrl = try container.decodeIfPresent(String.self, forKey: .profileUrl)
        self.followersAPIUrl = try container.decodeIfPresent(String.self, forKey: .followersAPIUrl)
        self.reposAPIUrl = try container.decodeIfPresent(String.self, forKey: .reposAPIUrl)
        self.followers = try container.decodeIfPresent(Int.self, forKey: .followers)
        self.following = try container.decodeIfPresent(Int.self, forKey: .following)
        self.repos = try container.decodeIfPresent(Int.self, forKey: .repos)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(login, forKey: .login)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(nodeID, forKey: .nodeID)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
        try container.encodeIfPresent(gravatarID, forKey: .gravatarID)
        try container.encodeIfPresent(profileUrl, forKey: .profileUrl)
        try container.encodeIfPresent(followersAPIUrl, forKey: .followersAPIUrl)
        try container.encodeIfPresent(reposAPIUrl, forKey: .reposAPIUrl)
        try container.encodeIfPresent(followers, forKey: .followers)
        try container.encodeIfPresent(following, forKey: .following)
        try container.encodeIfPresent(repos, forKey: .repos)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(location, forKey: .location)
        try container.encodeIfPresent(bio, forKey: .bio)
        try container.encodeIfPresent(email, forKey: .email)
    }
}
