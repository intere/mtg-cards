//
//  CardService.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/31/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import Foundation

typealias CardSearchCallback = (Error?, [Card]?) -> Void

protocol CardService {

    /// Searches the API for a specific card and calls back with success or failure
    ///
    /// - Parameters:
    ///   - cardNamed: The name of the card you want to search for
    ///   - callback: The callback that gives you back an error or results
    func search(for cardNamed: String, callback: @escaping CardSearchCallback)

}
