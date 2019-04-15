//
//  RepoModel.swift
//  Git Hub Application
//
//  Created by Mobile on 4/12/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import Foundation

struct Repo: Decodable {
    var id: Int?
    var nodeID: String?
    var name: String?
    var owner: User?
    var language: String?
    var forks: Int?
    var stars: Int?
    var lastUpdateDate: Date?
    var commitUrl: String?
    var Description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case owner = "owner"
        case language = "language"
        case forks = "forks_count"
        case stars = "stargazers_count"
        case lastUpdateDate = "pushed_at"
        case commitUrl = "commits_url"
        case Description = "description"
        
    }
}

extension Repo {
    
    init(from decoder: Decoder) throws {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.owner = try container.decodeIfPresent(User.self, forKey: .owner)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.forks = try container.decodeIfPresent(Int.self, forKey: .forks)
        self.stars = try container.decodeIfPresent(Int.self, forKey: .stars)
        let date = try container.decodeIfPresent(String.self, forKey: .lastUpdateDate)
        self.lastUpdateDate = dateFormatter.date(from: date ?? "")
        self.commitUrl = try container.decodeIfPresent(String.self, forKey: .commitUrl)
        self.Description = try container.decodeIfPresent(String.self, forKey: .Description)
    }
}
