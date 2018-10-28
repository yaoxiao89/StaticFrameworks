//
//  EmptyViewController.swift
//  AppUICore
//
//  Created by Xiao Yao on 10/28/18.
//  Copyright © 2018 Xiao Yao. All rights reserved.
//

import UIKit

// MARK: - EmptyViewController

public class EmptyViewController: UIViewController {
    
    public let label = UILabel()
    
}

// MARK: - View Lifecycle

extension EmptyViewController {
    
    public override func viewDidLoad() {
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
