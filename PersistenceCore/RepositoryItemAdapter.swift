//
//  RepositoryItemAdapter.swift
//  RepositoryCore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import CoreData

class RepositoryItemAdapter {
    
    func createRepositoryItems(from representables: [RepositoryItemRepresentable], in context: NSManagedObjectContext) -> [RepositoryItem] {
        let items = representables.map { (representable) -> RepositoryItem in
            let item = RepositoryItem(context: context)
            item.itemName = representable.name
            item.itemDescription = representable.description
            return item
        }
        return items
    }
    
}
