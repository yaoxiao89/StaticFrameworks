//
//  Result.swift
//  NetworkCore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import Foundation

public enum Result<Value> {
    
    case success(Value)
    case failure(Error?)
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
    
    public init(value: Value) {
        self = .success(value)
    }
    
    public init(error: Error?) {
        self = .failure(error)
    }
    
}
