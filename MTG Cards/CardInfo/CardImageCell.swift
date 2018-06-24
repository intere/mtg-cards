//
//  CardImageCell.swift
//  MTG Cards
//
//  Created by Eric Internicola on 6/15/18.
//  Copyright © 2018 Eric Internicola. All rights reserved.
//

import UIKit

class CardImageCell: UITableViewCell {

    @IBOutlet weak var cardImage: UIImageView!

    var cardInfo: Card? {
        didSet {
            updateCardImage()
        }
    }

}

// MARK: - Implementation

extension CardImageCell {

    /// Loads the image
    func updateCardImage() {
        guard let cardInfo = cardInfo, let url = URL(string: cardInfo.imageUrlString) else {
            cardImage.image = nil
            return
        }

        // Index the card in spotlight after the image is loaded:
        cardImage.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { [weak self] (image, error, cacheType, url) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            guard let image = image else {
                print("No image data was loaded for card: \(cardInfo.name)")
                return
            }

            self?.indexCardInSpotlight(with: image)
            self?.tellParentToReload()
        }
    }

    /// Indexes the current card in spotlight using the provided image.
    ///
    /// - Parameter image: The image to be associated with this card.
    private func indexCardInSpotlight(with image: UIImage) {
        cardInfo?.spotlightIndex(using: image)
    }

    /// Sends out a notification that the `CardInfoTableViewController` is listening for, to know it's time to reload.
    private func tellParentToReload() {
        DispatchQueue.main.async {
            // Send out a notification (on the main thread) to tell the card table to update (and show this image)
            NotificationCenter.default.post(Notification(name: Notification.CardInfoTableViewController.updateTable))
        }
    }
}
