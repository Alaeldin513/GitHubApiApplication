//
//  WebServiceManager.swift
//  Git Hub Application
//
//  Created by Mobile on 4/12/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit
enum Result<T> {
    case succes(T)
    case failure(Error)
}

enum APIErrors: Error{
    case genericServerError(Int,String)
    var cod: Int {
        switch self {
        case .genericServerError(let statusCode, _):
            return statusCode
        }
    }
}

class WebServiceManager: NSObject {
    static let shared = WebServiceManager()
    typealias JSONDictionary = [String: Any]
    
    private override init() {
        super.init()
    }
    
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["content-type":"application/json"]
        config.timeoutIntervalForRequest = 15
        return URLSession(configuration: config)
    }()
    
    //Mark: - HTTP Methods
    
    func get(url: URL, headerFields: [String:String], success: @escaping ((_ data: Data) -> Void), failure: @escaping ((_ error: Error) -> Void) ){
        var request = URLRequest(url: url)
        for (key, value) in headerFields {
            request.addValue(value, forHTTPHeaderField: key)
        }
        performDataTask(request, success: success, failure: failure)
    }
    
    
    fileprivate func performDataTask(_ request: URLRequest , success: @escaping ((_ data: Data) -> Void), failure: @escaping ((_ error: Error) -> Void)){
        if let data = request.httpBody {
            printJSON(data: data)
        }
        
        let task = session.dataTask(with: request) { [unowned self] (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                failure(error!)
            } else if let webSericeError = self.checkStatusCode(data, response: (response as! HTTPURLResponse)) {
                failure(webSericeError)
            } else {
                self.printJSON(data: data!)
                success(data!)
            }
        }
        task.resume()
    }
    
    func checkStatusCode(_ data: Data?, response: HTTPURLResponse!) -> Error? {
        var error: Error? = nil
        switch response.statusCode {
        case 200...299:
            break
        default:
            var errorMessage = "An error has occured."
            do {
                let json_message = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: String]
                if let message = json_message?["Message"] {
                    errorMessage = message
                }
            } catch _ {}
            error = APIErrors.genericServerError(response.statusCode, errorMessage)
        }
        return error
        
    }
    
    func printJSON(data: Data){
        #if Stage
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            return
        }
        if let object = object as? JSONDictionary {
            guard let newData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) else {
                return
            }
            guard let String = String(data: newData, encoding: .utf8) else { return}
        } else if let object = object as? [JSONDictionary] {
            guard let newData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) else {
                return
            }
            guard let String = String(data: newData, encoding: .utf8) else { return}
        }
        #endif
    }
    
}
