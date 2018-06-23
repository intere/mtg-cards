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

    func updateCardImage() {
        guard let cardInfo = cardInfo, let url = URL(string: cardInfo.imageUrlString) else {
            cardImage.image = nil
            return
        }

        // Index the card in spotlight after the image is loaded:
        cardImage.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            guard let image = image else {
                print("No image data was loaded for card: \(cardInfo.name)")
                return
            }
            cardInfo.spotlightIndex(using: image)
        }
    }
}
