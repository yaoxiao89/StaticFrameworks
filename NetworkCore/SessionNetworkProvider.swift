//
//  SessionNetworkProvider.swift
//  NetworkCore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import Foundation

public class SessionNetworkProvider: NetworkProvider {

    let session: URLSession
    var currentTask: URLSessionTask?
    
    public init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func fetch(url: URL, completion: FetchResult?) {
        currentTask?.cancel()
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let `self` = self else { return }
            let result: Result<Data>
            if let data = data {
                result = Result(value: data)
            } else {
                result = Result(error: error)
            }
            completion?(result)
            self.currentTask = nil
        }
        task.resume()
        currentTask = task
    }
    
}
