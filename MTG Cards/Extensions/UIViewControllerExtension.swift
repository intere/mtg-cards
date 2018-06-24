//
//  UIViewControllerExtension.swift
//  MTG Cards
//
//  Created by Eric Internicola on 6/23/18.
//  Copyright © 2018 Eric Internicola. All rights reserved.
//

import CoreSpotlight
import UIKit

extension UIViewController {

    /// Handler for spotlight search.  This is called when a user performs a spotlight search that returns a result
    /// that we've indexed.  It calls into our app and we handle it by delegating down to this function.
    /// The following action takes place (if we determine this to be a spotlight search result):
    /// * Call out to the card service to get the card's metadata
    /// * When the card metadata loads, create a CardInfoVC, set the card and push it onto the navigation controller
    ///
    /// - Parameter activity: The `NSUserActivity` that represents the splotlight search result action.
    func handle(userActivity activity: NSUserActivity) {
        guard activity.activityType == CSSearchableItemActionType, let info = activity.userInfo,
            let selectedIdentifier = info[CSSearchableItemActivityIdentifier] as? String else {
                return
        }
        print("Selected Identifier: \(selectedIdentifier)")

        RemoteCardService.shared.openCard(withIdentifier: selectedIdentifier) { (error, card) in
            if let error = error {
                return print("ERROR: \(error.localizedDescription)")
            }
            guard let card = card else {
                return print("ERROR: no card came back for id: \(selectedIdentifier)")
            }
            assert(selectedIdentifier == card.id)

            DispatchQueue.main.async {
                assert(self.navigationController != nil)
                let cardVC = CardInfoTableViewController.loadFromStoryboard()
                cardVC.cardInfo = card
                self.navigationController?.pushViewController(cardVC, animated: true)
            }
        }
    }
}
