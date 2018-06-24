//
//  AppDelegate.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/18/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

}

// MARK: - Spotlight Search Handling

extension AppDelegate {

    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([Any]?) -> Void) -> Bool {

        guard let vc = (window?.rootViewController as? UINavigationController)?.viewControllers.first else {
            print("Failed to get an approrpriate View Controller to load the activity from")
            return false
        }

        vc.restoreUserActivityState(userActivity)
        return true
    }
}
