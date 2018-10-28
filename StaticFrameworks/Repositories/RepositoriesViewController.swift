//
//  RepositoriesViewController.swift
//  StaticFrameworks
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import CoreData
import UIKit
import AppUICore

// MARK: - RepositoriesViewControllerAction

enum RepositoriesViewControllerAction {
    case search(String)
}

// MARK: - RepositoriesViewControllerDelegate

protocol RepositoriesViewControllerDelegate: AnyObject {
    
    func repositoriesViewController(_ viewController: RepositoriesViewController, didPerform action: RepositoriesViewControllerAction)
    
}

// MARK: - RepositoriesViewController

class RepositoriesViewController: StateViewController {
    
    weak var repositoriesDelegate: RepositoriesViewControllerDelegate?
    
    private let searchController: UISearchController
    let errorViewController: ErrorViewController
    let contentViewController: RepositoriesContentViewController
    let loadingViewController: LoadingViewController
    let emptyViewController: EmptyViewController
    
    init(context: NSManagedObjectContext) {
        loadingViewController = LoadingViewController()
        contentViewController = RepositoriesContentViewController(context: context)
        searchController = UISearchController(searchResultsController: nil)
        errorViewController = ErrorViewController()
        emptyViewController = EmptyViewController()
        super.init(contentViewController: loadingViewController, state: .loading)
        emptyViewController.label.text = "No Results"
        dataSource = self
        definesPresentationContext = true
        setupSearchController()
        setupNavigationItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "GitHub Repositories"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        searchController.searchResultsUpdater = self
    }
    
}

// MARK: - StateViewControllerDataSource

extension RepositoriesViewController: StateViewControllerDataSource {
    
    func stateViewController(_ viewController: StateViewController, viewControllerForState state: ViewControllerState) -> UIViewController {
        switch state {
        case .content:
            return contentViewController
        case .empty:
            return emptyViewController
        case .error:
            return errorViewController
        case .loading:
            return loadingViewController
        }
    }
    
}

// MARK: - UISearchControllerDelegate

extension RepositoriesViewController: UISearchControllerDelegate {
    
}

// MARK: - UISearchResultsUpdating

extension RepositoriesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        guard !text.isEmpty else { return }
        repositoriesDelegate?.repositoriesViewController(self, didPerform: .search(text))
    }
    
}
