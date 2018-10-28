//
//  ServiceEndpoint.swift
//  AppCore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import Foundation

extension URL {

    static let scheme = "https"
    static let host = "api.github.com"
    
    struct Path {
        static let searchRepositories = "/search/repositories"
    }
    
    static func searchRepositories(_ searchString: String) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = Path.searchRepositories
        
        let item = URLQueryItem(name: "q", value: searchString)
        components.queryItems = [item]
        return components.url
    }
    
}
