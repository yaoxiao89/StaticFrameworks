//
//  Service.swift
//  AppCore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import Foundation
import NetworkCore

public typealias FetchRepositoriesResult = (_ result: Result<RepositorySearchModel>) -> Void

public protocol ServiceProvider {
    
    func searchRepositories(for searchString: String, completion: FetchRepositoriesResult?)
    
}
