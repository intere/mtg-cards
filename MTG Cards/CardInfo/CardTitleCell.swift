//
//  CardTitleCell.swift
//  MTG Cards
//
//  Created by Eric Internicola on 6/15/18.
//  Copyright © 2018 Eric Internicola. All rights reserved.
//

import UIKit

class CardTitleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    var cardInfo: Card? {
        didSet {
            updateCardTitle()
        }
    }

}

// MARK: - Implementation

extension CardTitleCell {

    func updateCardTitle() {
        titleLabel.attributedText = cardInfo?.cardSetAndName(for: titleLabel)
    }

}
