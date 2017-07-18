//
//  CardData.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/18/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import Foundation

// API: Hit this URL, then and replace "nissa" with the name of the card
// you want to search for
// https://api.magicthegathering.io/v1/cards?name=nissa


typealias CardSearchCallback = (Error?, [Card]?) -> Void

/// Class that is responsible for retrieving the Card Data
class CardDataService {

    struct Constants {
        static let baseURL = "https://api.magicthegathering.io/v1/cards"
        static let cardNameParameter = "name"

        static let urlCreationError: Error = {
            return NSError(domain: "MTG Card Search", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create a search URL"])

        }()

        static let noDataError: Error = {
            return NSError(domain: "MTG Card Search", code: 2, userInfo: [NSLocalizedDescriptionKey: "The server responded back without any data"])
        }()

        static let non200Error: Error = {
            return NSError(domain: "MTG Card Search", code: 3, userInfo: [NSLocalizedDescriptionKey: "The server responded back with a non-success response"])
        }()

        static let invalidFormatError: Error = {
            return NSError(domain: "MTG Card Search", code: 4, userInfo: [NSLocalizedDescriptionKey: "The server returned data in an unexpected format"])
        }()

    }

    /// Searches the API for a specific card and calls back with success or failure
    ///
    /// - Parameters:
    ///   - cardNamed: The name of the card you want to search for
    ///   - callback: The callback that gives you back an error or results
    func search(for cardNamed: String, callback: @escaping CardSearchCallback) {
        guard let url = searchURL(for: cardNamed) else {
            return callback(Constants.urlCreationError, nil)
        }


        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Make sure there's no error
            if let error = error {
                return callback(error, nil)
            }

            // Make sure there is data
            guard let data = data else {
                return callback(Constants.noDataError, nil)
            }

            // Make sure we got back a 200 response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return callback(Constants.non200Error, nil)
            }

            do {
                // Make sure we can parse the data
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                    return callback(Constants.invalidFormatError, nil)
                }

                guard let cardMaps = json["cards"] as? [[String : AnyObject]] else {
                    return callback(Constants.invalidFormatError, nil)
                }

                callback(nil, cardMaps.map{Card(from: $0)})

            } catch let error {
                callback(error, nil)
            }
        }.resume()

    }

}

// MARK: - Implementation

extension CardDataService {

    func searchURL(for cardNamed: String) -> URL? {
        guard let components = NSURLComponents(string: Constants.baseURL) else {
            return nil
        }

        components.queryItems = [
            URLQueryItem(name: Constants.cardNameParameter, value: cardNamed)
        ]

        return components.url
    }

}
