//
//  ErrorViewController.swift
//  AppUICore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import UIKit

// MARK: - ErrorViewController

public class ErrorViewController: UIViewController {
    
    let label = UILabel()
    
    public var error: Error? {
        didSet {
            label.text = String(describing: error)
        }
    }

}

// MARK: - View Lifecycle

extension ErrorViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
    }
    
    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)
        
        let layoutGuide = view.layoutMarginsGuide
        let guide = view.safeAreaLayoutGuide
        let constraints = [
            label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            label.topAnchor.constraint(equalTo: guide.topAnchor),
            label.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
