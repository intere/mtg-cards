//
//  CardSearchResultTableViewCell.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/18/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import Kingfisher
import UIKit

/// Protocol to be notified when an image was loaded for a card
protocol CardImageLoadedDelegate: class {

    /// Tells the delegate that the cell's image has loaded
    ///
    /// - Parameter indexPath: The IndexPath that the image has been loaded at.
    func imageLoaded(for card: Card)
}


/// A Search Result Cell:
/// contains the card name and associated image
class CardSearchResultTableViewCell: UITableViewCell {

    struct Constants {
        static let cellID = "CardSearchResultCell"
    }

    @IBOutlet var cardNameLabel: UILabel!
    @IBOutlet var cardImageView: UIImageView!
    var delegate: CardImageLoadedDelegate?

    /// The card that this cell is currently showing.
    /// When you set the card, the cell is updated.
    /// Note: This must be done on the UI Thread.
    var card: Card? {
        didSet {
            updateCell()
        }
    }

    override func prepareForReuse() {
        cardNameLabel.text = nil
        cardImageView.image = nil
    }

}

// MARK: - Implementation

extension CardSearchResultTableViewCell {

    /// Updates the UI to reflect the current card:
    /// 1. Updates the label to reflect the card name
    /// 2. Uses Kingfisher to set the image for the cell
    ///
    func updateCell() {
        guard let card = card else {
            return
        }

        cardNameLabel.text = card.name

        guard let imageURL = URL(string: card.imageUrlString) else {
            return
        }
        cardImageView.kf.setImage(with: imageURL) { [weak self] (image, error, cache, url) in
            self?.delegate?.imageLoaded(for: card)
        }
    }

}
