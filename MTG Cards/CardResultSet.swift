//
//  CardResultSet.swift
//  MTG Cards
//
//  Created by Eric Internicola on 8/6/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import Foundation

class CardResultSet {
    let cards: [String: [Card]]

    var sortedKeys: [String] {
        return cards.keys.sorted()
    }

    init(withCards cardArray: [Card], withPhotosOnly photosOnly: Bool = true) {
        cards = CardResultSet.map(cards: cardArray, photosOnly: photosOnly)
    }
}

// MARK: - Implementation

extension CardResultSet {

    /// Takes an array of cards, and gives you back a CardSet
    ///
    /// - Parameters:
    ///   - cards: The cards to convert into a CardSet
    ///   - photosOnly: should we exclude any card without a photo URL?
    /// - Returns: A CardSet that was built from the provided card array.
    static func map(cards: [Card], photosOnly: Bool = true) -> CardSet {
        var set = CardSet()

        for card in cards {
            if photosOnly {
                // If we only want to see cards with photos, then
                // guard against cards without an image URL String
                guard !card.imageUrlString.isEmpty else {
                    continue
                }
            }

            if var list = set[card.name] {
                list.append(card)
            } else {
                set[card.name] = [card]
            }
        }

        return set
    }
}
