//
//  Card.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/18/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import Foundation


/// This class represents the metadata about a Magic Card
///
class Card {
    let id: String
    let name: String
    let manaCost: String
    let cmc: String
    let colors: [String]
    let colorIdentity: [String]
    let type: String
    let types: [String]
    let subtypes: [String]
    let rarity: String
    let set: String
    let text: String
    let power: String
    let toughness: String
    let imageUrlString: String

    init(from dictionary: [String: Any]) {
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        manaCost = dictionary["manaCost"] as? String ?? ""
        cmc = dictionary["cmc"] as? String ?? ""
        colors = dictionary["colors"] as? [String] ?? []
        colorIdentity = dictionary["colorIdentity"] as? [String] ?? []
        type = dictionary["type"] as? String ?? ""
        types = dictionary["types"] as? [String] ?? []
        subtypes = dictionary["subtypes"] as? [String] ?? []
        rarity = dictionary["rarity"] as? String ?? ""
        set = dictionary["set"] as? String ?? ""
        text = dictionary["text"] as? String ?? ""
        power = dictionary["power"] as? String ?? ""
        toughness = dictionary["toughness"] as? String ?? ""
        imageUrlString = dictionary["imageUrl"] as? String ?? ""
    }
}
