//
//  RepositoryItemModel.swift
//  AppCore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import Foundation

public struct RepositoryItemModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case name = "name"
    }
    
    public let description: String
    public let name: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
    }
    
}
