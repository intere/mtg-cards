//
//  RemoteCardService.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/18/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import Foundation

// API: Hit this URL, then and replace "nissa" with the name of the card
// you want to search for
// https://api.magicthegathering.io/v1/cards?name=nissa


/// Class that is responsible for retrieving the Card Data
class RemoteCardService {

    static var shared: CardService = RemoteCardService()

    struct Constants {
        static let baseURL = "https://api.magicthegathering.io/v1/cards"
        static let cardNameParameter = "name"
        static let domain = "MTG Card Search"

        /// Error that the URL failed to be created correctly
        static let urlCreationError: Error = {
            return NSError(domain: Constants.domain, code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create a search URL"])

        }()

        /// Error that there is no data
        static let noDataError: Error = {
            return NSError(domain: Constants.domain, code: 2, userInfo: [NSLocalizedDescriptionKey: "The server responded back without any data"])
        }()

        /// Failed to parse the response from the server
        static let internalError: Error = {
            return NSError(domain: Constants.domain, code: 3, userInfo: [NSLocalizedDescriptionKey: "Application Error trying to parse server response"])
        }()
        /// The server responded back with an error
        static let non200Error: Error = {
            return NSError(domain: Constants.domain, code: 4, userInfo: [NSLocalizedDescriptionKey: "The server responded back with a non-success response"])
        }()
        /// The server responded back with an unexpected data format
        static let invalidFormatError: Error = {
            return NSError(domain: Constants.domain, code: 5, userInfo: [NSLocalizedDescriptionKey: "The server returned data in an unexpected format"])
        }()

    }

}

// MARK: - CardService Implementation

extension RemoteCardService: CardService {

    func openCard(withIdentifier identifier: String, callback: @escaping CardResultCallback) {
        guard let url = cardUrl(id: identifier) else {
            return callback(Constants.urlCreationError, nil)
        }

        getUrl(url) { (error, data) in
            if let error = error {
                return callback(error, nil)
            }

            // Make sure there is data
            guard let data = data else {
                return callback(Constants.noDataError, nil)
            }

            do {
                // Make sure we can parse the data
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                    return callback(Constants.invalidFormatError, nil)
                }

                guard let cardMap = json["card"] as? [String : AnyObject] else {
                    return callback(Constants.invalidFormatError, nil)
                }

                callback(nil, Card(from: cardMap))

            } catch let error {
                callback(error, nil)
            }

        }
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

        getUrl(url) { (error, data) in
            if let error = error {
                return callback(error, nil)
            }

            // Make sure there is data
            guard let data = data else {
                return callback(Constants.noDataError, nil)
            }

            do {
                // Make sure we can parse the data
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                    return callback(Constants.invalidFormatError, nil)
                }

                guard let cardMaps = json["cards"] as? [[String : AnyObject]] else {
                    return callback(Constants.invalidFormatError, nil)
                }

                callback(nil, cardMaps.map({Card(from: $0)}).sorted(by: { return $0.name < $1.name }))
                
            } catch let error {
                callback(error, nil)
            }

        }

    }

}

// MARK: - Implementation

private extension RemoteCardService {

    typealias RemoteResult = (Error?, Data?) -> Void

    /// Helper function that performs a GET on the provided URL and calls back with either an error, or Data.
    ///
    /// - Parameters:
    ///   - url: The URL that you want to do an HTTP GET with.
    ///   - callback: The callback that will provide you with an error or data.
    func getUrl(_ url: URL, callback: @escaping RemoteResult) {
        print("Requesting URL: \(url.absoluteString)")
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
            guard let response = response as? HTTPURLResponse else {
                return callback(Constants.internalError, nil)
            }

            // Make sure we got back a 200 response
            guard response.statusCode == 200 else {
                print("HTTP Status Code: \(response.statusCode)")
                return callback(Constants.non200Error, nil)
            }

            callback(error, data)
        }.resume()
    }

    /// Builds a URL for a specific card using the provided id.
    ///
    /// - Parameter id: The ID of the card you would like the card URL for
    /// - Returns: The ID of the card you want back.
    func cardUrl(id: String) -> URL? {
        return URL(string: Constants.baseURL + "/" + id)
    }

    /// Builds you a Search URL for the provided card name.
    ///
    /// - Parameter cardNamed: The card name you want to search for.
    /// - Returns: A URL that will search
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
