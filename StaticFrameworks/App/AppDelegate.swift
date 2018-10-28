//
//  AppDelegate.swift
//  StaticFrameworks
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import UIKit

// MARK: - AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let bounds = UIScreen.main.bounds
        let window = UIWindow(frame: bounds)
        
        let coordinator = AppCoordinator()
        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()
        
        self.window = window
        self.coordinator = coordinator
        
        return true
    }

    
}

