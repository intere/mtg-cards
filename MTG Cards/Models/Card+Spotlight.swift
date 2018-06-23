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

    func searchableItem(with image: UIImage) -> CSSearchableItem {
        let searchItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypePNG as String)
        searchItemAttributeSet.title = name
        searchItemAttributeSet.contentDescription = text
        searchItemAttributeSet.thumbnailData = UIImagePNGRepresentation(image)

        return CSSearchableItem(uniqueIdentifier: id, domainIdentifier: "card", attributeSet: searchItemAttributeSet)
    }

//    func indexSearchableItems(){
//        //let matches ...
//        var searchableItems = [CSSearchableItem]()
//
//        for match in matches {
//            let searchItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
//            searchItemAttributeSet.title = match.title
//            searchItemAttributeSet.contentDescription = match.content
//            searchItemAttributeSet.thumbnailData = match.image
//
//            let searchableItem = CSSearchableItem(uniqueIdentifier: match.id, domainIdentifier: "matches", attributeSet: searchItemAttributeSet)
//            searchableItems.append(searchableItem)
//        }
//
//        CSSearchableIndex.default().indexSearchableItems(searchableItems) { (error) -> Void in
//            if error != nil {
//                print(error?.localizedDescription ?? "Error")
//            }
//        }
//    }

}
