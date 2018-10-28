//
//  StateViewController.swift
//  AppUICore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import UIKit

// MARK: - StateViewControllerDataSource

public protocol StateViewControllerDataSource: AnyObject {
    
    func stateViewController(_ viewController: StateViewController, viewControllerForState state: ViewControllerState) -> UIViewController
    
}

// MARK: - StateViewController

open class StateViewController: UIViewController {
    
    public weak var dataSource: StateViewControllerDataSource?
    
    private(set) public var visibleViewController: UIViewController
    private(set) public var transitioningViewController: UIViewController?
    var transitioningAnimator: UIViewPropertyAnimator?
    
    var state: ViewControllerState
    
    public init(contentViewController: UIViewController, state: ViewControllerState) {
        self.visibleViewController = contentViewController
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateState(_ state: ViewControllerState, animated: Bool = true) {
        if self.state != state {
            self.state = state
            transitionToViewController(for: state, animated: animated)
        }
    }
    
    func transitionToViewController(for state: ViewControllerState, animated: Bool) {
        guard let vc = dataSource?.stateViewController(self, viewControllerForState: state) else { return }
        
        if let transitioningVC = transitioningViewController {
            transitioningVC.view.removeFromSuperview()
            transitioningVC.removeFromParent()
        }
        
        transitioningViewController = vc
        
        transitioningAnimator?.stopAnimation(true)
        
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        pinView(vc.view, toView: view)
        
        if animated {
            vc.view.alpha = 0.0
            
            let animator = UIViewPropertyAnimator(duration: animated ? 0.2 : 0.0, curve: .easeInOut) {
                vc.view.alpha = 1.0
                self.visibleViewController.view.alpha = 0.0
            }
            
            animator.addCompletion { (position) in
                if position == .end {
                    guard let transitionVC = self.transitioningViewController else { return }
                    self.visibleViewController.removeFromParent()
                    self.didMove(toParent: transitionVC)
                    self.visibleViewController = transitionVC
                    self.transitioningViewController = nil
                    self.transitioningAnimator = nil
                }
            }
            
            animator.startAnimation()
            transitioningAnimator = animator
        } else {
            visibleViewController.removeFromParent()
            didMove(toParent: vc)
            visibleViewController = vc
            transitioningViewController = nil
            transitioningAnimator = nil
        }
    }
    
}

// MARK: - Status Bar

extension StateViewController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return visibleViewController.preferredStatusBarStyle
    }
    
    open override var prefersStatusBarHidden: Bool {
        return visibleViewController.prefersStatusBarHidden
    }
    
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return visibleViewController.preferredStatusBarUpdateAnimation
    }
    
}

// MARK: - View Lifecycle

extension StateViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupContentViewController()
    }
    
    func setupContentViewController() {
        view.backgroundColor = .white
        addChild(visibleViewController)
        view.addSubview(visibleViewController.view)
        visibleViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pinView(visibleViewController.view, toView: view)
        visibleViewController.didMove(toParent: self)
    }
    
}

// MARK: - Utilities

extension StateViewController {
    
    func pinView(_ view: UIView, toView otherView: UIView) {
        let guide = otherView.safeAreaLayoutGuide
        let constraints = [
            view.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            view.topAnchor.constraint(equalTo: guide.topAnchor),
            view.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

