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
class Card: CustomDebugStringConvertible {

    /// The card id (unique identifier about the card)
    let id: String

    /// The name of the card (e.g. Black Lotus)
    let name: String

    /// The mana cost of the card
    let manaCost: String
    let cmc: Int
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
        cmc = dictionary["cmc"] as? Int ?? -1
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


    var debugDescription: String {
        return "id: '\(id)', name: '\(name)', manaCost: '\(manaCost)', cmc: '\(cmc)', colors: '\(colors)', colorIdentity: '\(colorIdentity)', type: '\(type)', types: '\(types)', subtypes: '\(subtypes)', rarity: '\(rarity)', set: '\(set)', text: '\(text)', power: '\(power)', toughness: '\(toughness)', imageUrlString: '\(imageUrlString)'"
    }

}
