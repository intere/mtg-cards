//
//  BaseUITest.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/31/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

@testable import MTG_Cards
import UIKit
import UITestKit
import XCTest

class BaseUITest: UITestKitBase {

    /// Gets you the card search view controller
    var cardSearchVC: CardSearchResultTableViewController? {
        return topVC as? CardSearchResultTableViewController
    }

}
