//
//  LoadingViewController.swift
//  AppUICore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import UIKit

public class LoadingViewController: UIViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let animationView = UIActivityIndicatorView(style: .gray)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.startAnimating()
        view.addSubview(animationView)
        
        let constraints = [
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
