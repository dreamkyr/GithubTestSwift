//
//  GithubService.swift
//  githubTest
//
//  Created by dreams on 7/31/19.
//  Copyright © 2019 Dreams. All rights reserved.
//

import UIKit
import Alamofire

protocol GithubService: BaseService {
    func webServiceGetError(_ error: NetworkError)
    func webServiceGetResponse(data: [Contributor])
    func webServiceGetLocation(location: String)
}

extension GithubService {
    func fetchContributers() {
        
        let headers: [String: String] = ["Accept": "application/vnd.github.v3+json"]
        let url = "https://api.github.com/repos/facebook/react/contributors"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let (parsedResult, parsedError) = self.parse(response)
            if let error = parsedError {
                self.webServiceGetError(error)
            } else if let parsedResult = parsedResult {
                guard let _ = parsedResult[AppErrorInfo.ErrorKey] else {
                    var contributors: [Contributor] = []
                    if let array = parsedResult["data"] as? [[String : Any]] {
                        contributors = array.map { Contributor(dict: $0) }
                    }
                    self.webServiceGetResponse(data: contributors)
                    return
                }
                guard let errorDescription = parsedResult[AppErrorInfo.ErrorDescriptionKey] as? String else {
                    self.webServiceGetError(NetworkError.serverError)
                    return
                }
                self.webServiceGetError(NetworkError.messageError(errorDescription))
            }
        }
    }
    
    func getUserLocation(name: String) {
        
        let headers: [String: String] = ["Accept": "application/vnd.github.v3+json"]
        let url = "https://api.github.com/users/\(name)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let (parsedResult, parsedError) = self.parse(response)
            if let error = parsedError {
                self.webServiceGetError(error)
            } else if let parsedResult = parsedResult {
                guard let _ = parsedResult[AppErrorInfo.ErrorKey] else {
                    if let location = parsedResult["location"] as? String {
                        self.webServiceGetLocation(location: location)
                    }
                    return
                }
                guard let errorDescription = parsedResult[AppErrorInfo.ErrorDescriptionKey] as? String else {
                    self.webServiceGetError(NetworkError.serverError)
                    return
                }
                self.webServiceGetError(NetworkError.messageError(errorDescription))
            }
        }
    }
}
