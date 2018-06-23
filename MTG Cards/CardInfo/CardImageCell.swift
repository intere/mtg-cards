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
        cardImage.kf.setImage(with: url)
    }
}
