//
//  BaseUITest.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/31/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

@testable import MTG_Cards
import UIKit
import XCTest

class BaseUITest: BaseIntegrationTest {

    var cardSearchVC: CardSearchResultTableViewController? {
        return topVC as? CardSearchResultTableViewController
    }

    /// Tells you the type of the topVC
    var topVCType: String {
        guard let topVC = topVC else {
            return "No Top VC"
        }
        return String(describing: topVC.classForCoder)
    }

    var topVC: UIViewController? {
        return type(of: self).topVC
    }

    /// gets you the top VC as a UIViewController
    static var topVC:  UIViewController? {
        let visibleVC = getVisibleViewController()

        if let navVC = visibleVC as? UINavigationController {
            return navVC.topViewController
        }

        if let tabVC = visibleVC as? UITabBarController {
            if let navVC = tabVC.selectedViewController as? UINavigationController {
                return navVC.topViewController
            }
            return tabVC.selectedViewController
        }
        
        return visibleVC
    }

    static func getVisibleViewController(_ rootViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }

        if rootVC?.presentedViewController == nil {
            return rootVC
        }

        if let presented = rootVC?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }

            if presented.isKind(of: UITabBarController.self) {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }

            return getVisibleViewController(presented)
        }
        return nil
    }
}
