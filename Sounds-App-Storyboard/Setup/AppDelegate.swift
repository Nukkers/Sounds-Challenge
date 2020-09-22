//
//  AppDelegate.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 02/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create the initial nav controller
        let navController = UINavigationController()
        // Pass it to the main coordinator
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
        
        // Build the window and set it to the bounds of the device
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }

    

}

