//
//  File.swift
//  Git Hub Application
//
//  Created by Mobile on 4/14/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import Foundation


struct CommitWrapper: Decodable {
    var nodeID: String?
    var commit: Commit?
    var author: User?
    var committer: User?
    
    enum CodingKeys: String, CodingKey {
        case nodeID = "node_id"
        case commit = "commit"
        case author = "author"
        case committer = "committer"
    }
}

extension CommitWrapper {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nodeID = try container.decodeIfPresent(String.self, forKey: .nodeID)
        self.commit = try container.decodeIfPresent(Commit.self, forKey: .commit)
        self.author = try container.decodeIfPresent(User.self, forKey: .author)
        self.committer = try container.decodeIfPresent(User.self, forKey: .committer)
    }
}

struct Commit: Decodable {
    var author: person?
    var commiter: person?
    var messsage: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case commiter = "committer"
        case messsage = "message"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decodeIfPresent(person.self, forKey: .author)
        self.commiter = try container.decodeIfPresent(person.self, forKey: .commiter)
        self.messsage = try container.decodeIfPresent(String.self, forKey: .messsage)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
    
}

struct person: Decodable {
    var name: String?
    var email: String?
    var date: Date?
    
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case date = "date"
    }
    
    init(from decoder: Decoder) throws {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        var date = try container.decodeIfPresent(String.self, forKey: .date)
        self.date = dateFormatter.date(from: date ?? "")
    }
}
