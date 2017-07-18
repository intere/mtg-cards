//
//  CardSearchResultTableViewCell.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/18/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import Kingfisher
import UIKit

protocol CardImageLoadedDelegate: class {

    /// Tells the delegate that the cell's image has loaded
    ///
    /// - Parameter indexPath: The IndexPath that the image has been loaded at.
    func imageLoaded(for card: Card)
}

class CardSearchResultTableViewCell: UITableViewCell {

    struct Constants {
        static let cellID = "CardSearchResultCell"
    }

    @IBOutlet var cardNameLabel: UILabel!
    @IBOutlet var cardImageView: UIImageView!
    var delegate: CardImageLoadedDelegate?

    var card: Card? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - Implementation

extension CardSearchResultTableViewCell {

    func updateCell() {
        guard let card = card else {
            cardNameLabel.text = ""
            cardImageView.kf.setImage(with: nil)
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
