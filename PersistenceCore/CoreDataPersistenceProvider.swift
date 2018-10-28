//
//  CoreDataPersistenceProvider.swift
//  RepositoryCore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import CoreData

public protocol CoreDataPersistenceProvider {
    
    var persistenceContainer: NSPersistentContainer { get }
    func updateRepositories(_ repositories: [RepositoryItemRepresentable])

}
