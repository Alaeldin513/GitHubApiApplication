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
        let url = URL(string: path, relativeTo: APIEndPoints.getUser.baseUrl)
        
        let success: ((Data) -> Void) = { data in
            do {
                var user = try JSONDecoder().decode(User.self, from: data)
                getUserImage(imageUrl: user.imageUrl ?? ""){ result in
                    switch result{
                    case .success(let imageData):
                        user.imageData = imageData
                    case .failure(_):
                        break
                    }
                    completion(.success(user))
                }
            } catch{
                completion(.failure(APIErrors.invalidJsonResponse))
            }
        }
        
        let failure: ((Error) -> Void) = { error in
                completion(.failure(error))
        }
        if let url = url {
            WebServiceManager.shared.get(url: url, headerFields: [:], success: success, failure: failure)
        }
    }
    
    class func getUserImage(imageUrl: String, completion: @escaping (_ result: Result<Data>) -> Void) {
        let url = URL(string: imageUrl)
        let success: ((Data) -> Void) = { data in
            completion(.success(data))
        }
        
        let failure: ((Error) -> Void) = { error in
            completion(.failure(error))
        }
        if let url = url {
            WebServiceManager.shared.get(url: url, headerFields: [:], success: success, failure: failure)
        }
    }
    
    class func getRepos(repoUrl: String, completion: @escaping (_ result: Result<[Repo]>) -> Void) {
        let url = URL(string: repoUrl)
        let success: ((Data) -> Void) = { data in
            do {
                let repos = try JSONDecoder().decode([Repo].self, from: data)
                completion(.success(repos))
            } catch{
                completion(.failure(APIErrors.invalidJsonResponse))
            }
        }
        
        let failure: ((Error) -> Void) = { error in
            completion(.failure(error))
        }
        if let url = url {
            WebServiceManager.shared.get(url: url, headerFields: [:], success: success, failure: failure)
        }
    }
    
    class func getListOfUsers(usersUrl: String, completion: @escaping (_ result: Result<[User]>) -> Void) {
        let url = URL(string: usersUrl)
        let success: ((Data) -> Void) = { data in
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch{
                completion(.failure(APIErrors.invalidJsonResponse))
            }
        }
        
        let failure: ((Error) -> Void) = { error in
            completion(.failure(error))
        }
        if let url = url {
            WebServiceManager.shared.get(url: url, headerFields: [:], success: success, failure: failure)
        }
    }
    
    class func getRepoCommits(commitsUrl: String, completion: @escaping (_ result: Result<[CommitWrapper]>) -> Void) {
        let url = URL(string: commitsUrl.replacingOccurrences(of: "{/sha}", with: ""))
        let success: ((Data) -> Void) = { data in
            do {
                let commits = try JSONDecoder().decode([CommitWrapper].self, from: data)
                completion(.success(commits))
            } catch{
                completion(.failure(APIErrors.invalidJsonResponse))
            }
        }
        
        let failure: ((Error) -> Void) = { error in
            completion(.failure(error))
        }
        if let url = url {
            WebServiceManager.shared.get(url: url, headerFields: [:], success: success, failure: failure)
        }
    }
}

