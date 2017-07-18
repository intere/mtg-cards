//
//  CardDataServiceIntegrationTest.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/18/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

@testable import MTG_Cards
import XCTest

class CardDataServiceIntegrationTest: XCTestCase {

    func testFetchSingleWord() {
        let exp = expectation(description: "MTG Server Response")

        CardDataService.shared.search(for: "Lotus") { (error, cards) in
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

                // Sometimes there is no CMC in the data:
//                XCTAssertNotEqual(-1, card.cmc, "Invalid CMC at index \(i)")

                // Other things that don't always appear
//                XCTAssertNotEqual("", card.manaCost)
//                XCTAssertNotEqual([], card.colors)
//                XCTAssertNotEqual([], card.colorIdentity)
//                XCTAssertNotEqual([], card.subtypes)
//                XCTAssertNotEqual("", card.power)
//                XCTAssertNotEqual("", card.toughness)
//                XCTAssertNotEqual("", card.imageUrlString, "Empty Image URL at index \(i)")
            }
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchMultipleWords() {
        let exp = expectation(description: "MTG Server Response")

        CardDataService.shared.search(for: "lightning bolt") { (error, cards) in
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

//                XCTAssertNotEqual([], card.subtypes)
//                XCTAssertNotEqual("", card.power)
//                XCTAssertNotEqual("", card.toughness)
//                XCTAssertNotEqual("", card.imageUrlString, "Empty Image URL at index \(i)")
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
}
