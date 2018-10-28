//
//  DiskCoreDataPersistenceProvider.swift
//  RepositoryCore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import CoreData
import os.log

public class DiskCoreDataPersistenceProvider: CoreDataPersistenceProvider {
    
    public let persistenceContainer: NSPersistentContainer
    
    public init() {
        let name = "Database"
        let modelURL = Bundle.findCoreDataModel(name: name)
        guard let url = modelURL else {
            fatalError("Could not create URL for Core Data model")
        }

        guard let mom = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Could not load Core Data model at \(url)")
        }
        
        persistenceContainer = PersistenceContainer(name: name, managedObjectModel: mom)
        persistenceContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistenceContainer.loadPersistentStores { (description, error) in
            print(String(describing: error?.localizedDescription))
        }
    }
    
    public func updateRepositories(_ repositories: [RepositoryItemRepresentable]) {
        persistenceContainer.performBackgroundTask { (context) in
            do {
                let request: NSFetchRequest<RepositoryItem> = RepositoryItem.fetchRequest()
                let itemsToDelete = try context.fetch(request)
                itemsToDelete.forEach({ context.delete($0) })
                try context.save()
                
                let adapter = RepositoryItemAdapter()
                let _ = adapter.createRepositoryItems(from: repositories, in: context)
                try context.save()
            } catch {
                os_log("CoreData Error: %@", error.localizedDescription)
            }
        }
    }
    
}
