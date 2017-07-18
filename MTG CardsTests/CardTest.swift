//
//  CardTest.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/18/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

@testable import MTG_Cards
import XCTest

class CardTest: XCTestCase {

    struct Constants {
        static let testString = "ABCDEFG"
        static let testStringArray: [String] = [ "ABC", "DEF", "GHI"]
    }

    /// Ensure that we can create a card from an empty dictionary
    func testCardInitializeEmpty() {
        let card = Card(from: [:])

        XCTAssertEqual("", card.id)
        XCTAssertEqual("", card.name)
        XCTAssertEqual("", card.manaCost)
        XCTAssertEqual("", card.cmc)
        XCTAssertEqual([], card.colors)
        XCTAssertEqual([], card.colorIdentity)
        XCTAssertEqual("", card.type)
        XCTAssertEqual([], card.types)
        XCTAssertEqual([], card.subtypes)
        XCTAssertEqual("", card.rarity)
        XCTAssertEqual("", card.set)
        XCTAssertEqual("", card.text)
        XCTAssertEqual("", card.power)
        XCTAssertEqual("", card.toughness)
        XCTAssertEqual("", card.imageUrlString)
    }

    /// Validate that when we initialize a card with the "id" property
    /// The card has that value mapped correctly
    func testCardInitializeWithId() {
        let card = Card(from: ["id": Constants.testString])
        XCTAssertEqual(card.id, Constants.testString)
    }

    /// Validate that when we initialize a card with the "name" property
    /// The card has that value mapped correctly
    func testCardInitializeWithName() {
        let card = Card(from: ["name": Constants.testString])
        XCTAssertEqual(card.name, Constants.testString)
    }

    /// Validate that when we initialize a card with the "manaCost" property
    /// The card has that value mapped correctly
    func testCardInitializeWithManaCost() {
        let card = Card(from: ["manaCost": Constants.testString])
        XCTAssertEqual(card.manaCost, Constants.testString)
    }

    /// Validate that when we initialize a card with the "cmc" property
    /// The card has that value mapped correctly
    func testCardInitializeWithCmc() {
        let card = Card(from: ["cmc": Constants.testString])
        XCTAssertEqual(card.cmc, Constants.testString)
    }

    /// Validate that when we initialize a card with the "colors" property
    /// The card has that value mapped correctly
    func testCardInitializeWithColors() {
        let card = Card(from: ["colors": Constants.testStringArray])
        XCTAssertEqual(card.colors, Constants.testStringArray)
    }

    /// Validate that when we initialize a card with the "colorIdentity" property
    /// The card has that value mapped correctly
    func testCardInitializeWithColorIdentity() {
        let card = Card(from: ["colorIdentity": Constants.testStringArray])
        XCTAssertEqual(card.colorIdentity, Constants.testStringArray)
    }

    /// Validate that when we initialize a card with the "type" property
    /// The card has that value mapped correctly
    func testCardInitializeWithType() {
        let card = Card(from: ["type": Constants.testString])
        XCTAssertEqual(card.type, Constants.testString)
    }

    /// Validate that when we initialize a card with the "types" property
    /// The card has that value mapped correctly
    func testCardInitializeWithTypes() {
        let card = Card(from: ["types": Constants.testStringArray])
        XCTAssertEqual(card.types, Constants.testStringArray)
    }

    /// Validate that when we initialize a card with the "subtypes" property
    /// The card has that value mapped correctly
    func testCardInitializeWithSubtypes() {
        let card = Card(from: ["subtypes": Constants.testStringArray])
        XCTAssertEqual(card.subtypes, Constants.testStringArray)
    }

    /// Validate that when we initialize a card with the "rarity" property
    /// The card has that value mapped correctly
    func testCardInitializeWithRarity() {
        let card = Card(from: ["rarity": Constants.testString])
        XCTAssertEqual(card.rarity, Constants.testString)
    }

    /// Validate that when we initialize a card with the "set" property
    /// The card has that value mapped correctly
    func testCardInitializeWithSet() {
        let card = Card(from: ["set": Constants.testString])
        XCTAssertEqual(card.set, Constants.testString)
    }

    /// Validate that when we initialize a card with the "text" property
    /// The card has that value mapped correctly
    func testCardInitializeWithText() {
        let card = Card(from: ["text": Constants.testString])
        XCTAssertEqual(card.text, Constants.testString)
    }

    /// Validate that when we initialize a card with the "power" property
    /// The card has that value mapped correctly
    func testCardInitializeWithPower() {
        let card = Card(from: ["power": Constants.testString])
        XCTAssertEqual(card.power, Constants.testString)
    }

    /// Validate that when we initialize a card with the "toughness" property
    /// The card has that value mapped correctly
    func testCardInitializeWithToughness() {
        let card = Card(from: ["toughness": Constants.testString])
        XCTAssertEqual(card.toughness, Constants.testString)
    }

    /// Validate that when we initialize a card with the "imageUrl" property
    /// The card has that value mapped correctly
    func testCardInitializeWithImageUrlString() {
        let card = Card(from: ["imageUrl": Constants.testString])
        XCTAssertEqual(card.imageUrlString, Constants.testString)
    }

}
