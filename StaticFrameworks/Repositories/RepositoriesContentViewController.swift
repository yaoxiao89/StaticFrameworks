//
//  RepositoriesContentViewController.swift
//  StaticFrameworks
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import CoreData
import UIKit
import PersistenceCore
import AppUICore

// MARK: - RepositoriesContentViewController

class RepositoriesContentViewController: UITableViewController {
    
    let dataController: NSFetchedResultsController<RepositoryItem>
    
    init(context: NSManagedObjectContext) {
        let request: NSFetchRequest<RepositoryItem> = RepositoryItem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "itemName", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        dataController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init(style: .plain)
        dataController.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Lifecycle

extension RepositoriesContentViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
 
    private func setupTableView() {
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        tableView.register(RepositoryCell.self)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fetchData() {
        do {
            try dataController.performFetch()
        } catch {
            print(String(describing: error.localizedDescription))
        }
        tableView.reloadData()
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate

extension RepositoriesContentViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let path = newIndexPath {
                tableView.insertRows(at: [path], with: .fade)
            }
        case .delete:
            if let path = indexPath {
                tableView.deleteRows(at: [path], with: .fade)
            }
        case .update:
            if let path = indexPath {
                tableView.reloadRows(at: [path], with: .fade)
            }
        case .move:
            if let deletePath = indexPath, let insertPath = newIndexPath {
                tableView.deleteRows(at: [deletePath], with: .fade)
                tableView.insertRows(at: [insertPath], with: .fade)
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension RepositoriesContentViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.sections?.first?.numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(RepositoryCell.self, forIndexPath: indexPath)
        let item = dataController.object(at: indexPath)
        cell.textLabel?.text = item.itemName
        cell.detailTextLabel?.text = item.itemDescription
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension RepositoriesContentViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
