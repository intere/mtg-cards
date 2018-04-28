//
//  CardDataServiceIntegrationTest.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/18/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

@testable import MTG_Cards
import XCTest


/// This is an integration test, becuse it actaully reaches out to the "Real API" to execute a query
/// This is a good test that serves as documentation to show us how to use the RemoteCardService
///
class CardDataServiceIntegrationTest: XCTestCase {

    func testFetchSingleWord() {
        let exp = expectation(description: "MTG Server Response")

        RemoteCardService.shared.search(for: "Lotus") { (error, cards) in
            defer {
                exp.fulfill()
            }

            if let error = error {
                return XCTFail("Failed with error: \(error)")
            }

            guard let cards = cards else {
                return XCTFail("Failed to get any results back")
            }

            XCTAssertTrue(cards.count > 0, "We didn't get any cards back")

            for i in 0..<cards.count {
                let card = cards[i]

                XCTAssertNotEqual("", card.id)
                XCTAssertNotEqual("", card.name)
                XCTAssertNotEqual("", card.type)
                XCTAssertNotEqual([], card.types)
                XCTAssertNotEqual("", card.rarity)
                XCTAssertNotEqual("", card.set)
                XCTAssertNotEqual("", card.text)

                // cmc, manaCost, colors, colorIdentity, subtypes, power, toughness
                // and imageUrlString are not guaranteed to be in the response
                // so I've skipped the assertions here
            }
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchMultipleWords() {
        let exp = expectation(description: "MTG Server Response")

        RemoteCardService.shared.search(for: "lightning bolt") { (error, cards) in
            defer {
                exp.fulfill()
            }

            if let error = error {
                return XCTFail("Failed with error: \(error)")
            }

            guard let cards = cards else {
                return XCTFail("Failed to get any results back")
            }

            XCTAssertTrue(cards.count > 0, "We didn't get any cards back")

            for i in 0..<cards.count {
                let card = cards[i]

                XCTAssertNotEqual("", card.id)
                XCTAssertNotEqual("", card.name)
                XCTAssertNotEqual("", card.type)
                XCTAssertNotEqual([], card.types)
                XCTAssertNotEqual("", card.rarity)
                XCTAssertNotEqual("", card.set)
                XCTAssertNotEqual("", card.text)
                XCTAssertNotEqual("", card.manaCost)

                XCTAssertNotEqual([], card.colors)
                XCTAssertNotEqual([], card.colorIdentity)
                XCTAssertNotEqual(-1, card.cmc)

                // subtypes, power, toughness and imageUrlString are not 
                // guaranteed to be in the response, particularly for the card "lightning bolt"
                // so I've skipped the assertions here
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
}
