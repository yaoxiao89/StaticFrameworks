//
//  AppCoordinator.swift
//  StaticFrameworks
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import UIKit
import PersistenceCore
import AppCore
import DependencyCore

// MARK: - RepositoryItemModel

extension RepositoryItemModel: RepositoryItemRepresentable {}

// MARK: - AppCoordinator

class AppCoordinator {
    
    let rootViewController: UIViewController
    
    private let repositoriesViewController: RepositoriesViewController
    private let serviceProvider: ServiceProvider
    private let persistenceProvider: CoreDataPersistenceProvider
    
    init() {
        serviceProvider = SessionServiceProvider()
        persistenceProvider = DiskCoreDataPersistenceProvider()
        
        let context = persistenceProvider.persistenceContainer.viewContext
        let repositoriesVC = RepositoriesViewController(context: context)
        repositoriesViewController = repositoriesVC
        
        let navController = UINavigationController(rootViewController: repositoriesVC)
        navController.navigationBar.prefersLargeTitles = true
        rootViewController = navController
        repositoriesVC.repositoriesDelegate = self
        
        performSearch("swift")
    }
    
}

// MARK: - RepositoriesViewControllerDelegate

extension AppCoordinator: RepositoriesViewControllerDelegate {
    
    func repositoriesViewController(_ viewController: RepositoriesViewController, didPerform action: RepositoriesViewControllerAction) {
        switch action {
        case .search(let searchString):
            performSearch(searchString)
        }
    }
    
    private func performSearch(_ search: String) {
        repositoriesViewController.updateState(.loading)
        serviceProvider.searchRepositories(for: search) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let search):
                let items = search.items
                self.persistenceProvider.updateRepositories(items)
                if items.isEmpty {
                    self.repositoriesViewController.updateState(.empty)
                } else {
                    self.repositoriesViewController.updateState(.content)
                }
            case .failure(let error):
                self.persistenceProvider.updateRepositories([])
                self.repositoriesViewController.errorViewController.error = error
                self.repositoriesViewController.updateState(.error)
            }
        }
    }
    
}
