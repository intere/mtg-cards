//
//  Card+Spotlight.swift
//  MTG Cards
//
//  Created by Eric Internicola on 6/23/18.
//  Copyright © 2018 Eric Internicola. All rights reserved.
//

import CoreSpotlight
import MobileCoreServices
import UIKit

extension Card {

    /// Using the provided image, this card is indexed with Spotlight.
    ///
    /// - Parameter image: The image to associate with this card in spotlight search.
    func spotlightIndex(using image: UIImage) {
        let item = searchableItem(with: image)
        CSSearchableIndex.default().indexSearchableItems([item]) { (error) in
            guard let error = error else {
                return
            }
            print("Error indexing card: \(self.name)")
            print(error.localizedDescription)
        }
    }

    /// Converts this card (using the provided image) into a CSSearchableItem (indexable by spotlight)
    ///
    /// - Parameter image: The image to associate with this card.
    /// - Returns: A CSSearchableItem that you can use to index the card in Spotlight.
    func searchableItem(with image: UIImage) -> CSSearchableItem {
        let searchItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypePNG as String)
        searchItemAttributeSet.title = name
        searchItemAttributeSet.contentDescription = text
        searchItemAttributeSet.thumbnailData = UIImagePNGRepresentation(image)

        return CSSearchableItem(uniqueIdentifier: id, domainIdentifier: "card", attributeSet: searchItemAttributeSet)
    }

}
