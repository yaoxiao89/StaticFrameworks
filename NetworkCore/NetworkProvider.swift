//
//  NetworkProvider.swift
//  NetworkCore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import Foundation

public typealias FetchResult = (_ result: Result<Data>) -> Void

public protocol NetworkProvider {
    
    func fetch(url: URL, completion: FetchResult?)
    
}
