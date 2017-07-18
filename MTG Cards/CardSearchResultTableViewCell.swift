//
//  CardSearchResultTableViewCell.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/18/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import Kingfisher
import UIKit

class CardSearchResultTableViewCell: UITableViewCell {

    struct Constants {
        static let cellID = "CardSearchResultCell"
    }

    @IBOutlet var cardNameLabel: UILabel!
    @IBOutlet var cardImageView: UIImageView!

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
        cardImageView.kf.setImage(with: URL(string: card.imageUrlString))
    }

}
