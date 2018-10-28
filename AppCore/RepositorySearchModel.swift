//
//  RepositorySearchModel.swift
//  AppCore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import Foundation

public struct RepositorySearchModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
    
    public let items: [RepositoryItemModel]
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([RepositoryItemModel].self, forKey: .items) ?? []
    }
    
}
