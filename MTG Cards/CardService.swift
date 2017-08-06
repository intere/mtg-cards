//
//  CardService.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/31/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import Foundation


/// A CardSet is a map of an array of cards
/// The Key is the name of the card, and the 
/// value is an array of cards by the same name (one for each printing of the cards)
typealias CardSet = [String: [Card]]


/// A Callback that tells you if a card search succeeded or failed.
/// If it succeeded, the error is nil and the CardResultSet is not nil.
/// If it failed, the error is not nil and the CardResultSet is nil.
typealias CardSearchCallback = (Error?, CardResultSet?) -> Void

protocol CardService {

    /// Searches the API for a specific card and calls back with success or failure
    ///
    /// - Parameters:
    ///   - cardNamed: The name of the card you want to search for
    ///   - callback: The callback that gives you back an error or results
    func search(for cardNamed: String, callback: @escaping CardSearchCallback)

}
