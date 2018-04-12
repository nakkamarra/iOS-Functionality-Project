//
//  AppDelegate.swift
//  iOS Functionality Project
//
//  Created by Nicholas Brandt on 4/11/18.
//  Copyright © 2018 Nicholas Brandt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    // main thread:
    // instantiate and size the main window, then
    // nest MainDirectory into NavigationController
    // and add it to the application's window
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainViewController = UINavigationController(rootViewController: MainDirectory())
        mainViewController.navigationBar.backgroundColor = .white
        mainViewController.navigationBar.topItem?.title = "Brandt iOS Project"
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        return true
    }
}

