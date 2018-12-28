//
//  CardSearchUITest.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/31/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

@testable import MTG_Cards
import XCTest


///
/// This test demonstrates the following:
/// 1. One strategy to write UI Tests for iOS
/// 2. How we can inject a Mock Data Source in place of a real one (by breaking the service into an interface [protocol] and implementation)
/// 3. How you can write more deterministic tests when using a mock implementation of the data source
///
class CardSearchUITest: BaseUITest {

    override func setUp() {
        super.setUp()

        // Inject the mock framework
        MockCardDataService.beginMocking()

        // Wait for the Card Search VC to load
        XCTAssertTrue(waitForCondition({ self.cardSearchVC != nil }, timeout: 5), topVCScreenshot)
    }
    
    override func tearDown() {
        // Stop Mocking (swap the real card service back in)
        MockCardDataService.endMocking()
        cardSearchVC?.tapCancel()

        super.tearDown()
    }
    
}

// MARK: - Haven't yet or cancelled search

extension CardSearchUITest {

    func testNoSearch() {
        guard let cardSearchVC = cardSearchVC else {
            return XCTFail("Failed to get the Card Search VC, it was \(topVCType)")
        }
        XCTAssertTrue(waitForCondition({
            return self.cardSearchVC?.tableView.numberOfRows(inSection: 0) == 1 &&
                CardSearchResultTableViewController.Constants.enterSearchCellId == cardSearchVC.tableView(cardSearchVC.tableView, cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier
        }, timeout: 1), "We didn't get the correct number of rows")

        XCTAssertEqual(CardSearchResultTableViewController.Constants.enterSearchCellId, cardSearchVC.tableView(cardSearchVC.tableView, cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier)
    }

    func testNoResultsInSearch() {
        guard let cardSearchVC = cardSearchVC else {
            XCTFail(topVCScreenshot)
            return XCTFail("Failed to get the Card Search VC, it was \(topVCType)")
        }

        // Show what we're searching for
        cardSearchVC.searchBar.text = "Drunken"

        // Invoke the search for "Drunken" (we know there are no results, since we control the data source)
        cardSearchVC.search(for: "Drunken")

        XCTAssertTrue(waitForCondition({
            return self.cardSearchVC?.tableView.numberOfRows(inSection: 0) == 1 &&
                CardSearchResultTableViewController.Constants.noResultsCellId == cardSearchVC.tableView(cardSearchVC.tableView, cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier
        }, timeout: 1), "We didn't get the correct number of rows")

        XCTAssertEqual(CardSearchResultTableViewController.Constants.noResultsCellId, cardSearchVC.tableView(cardSearchVC.tableView, cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier)
    }

}

// MARK: - Perform a search

extension CardSearchUITest {

    /// Validate that when we search and get a single result, we get only a single result.
    func testSearchSingleResult() {
        guard let cardSearchVC = cardSearchVC else {
            return XCTFail("Failed to get the Card Search VC, it was \(topVCType)")
        }

        // Show what we're searching for
        cardSearchVC.searchBar.text = "Kool"

        // Invoke the search for "Kool" (we know there is a single result, since we control the data source)
        cardSearchVC.search(for: "Kool")

        // Wait for there to be more than a single row
        XCTAssertTrue(waitForCondition({
            return self.cardSearchVC?.tableView.numberOfRows(inSection: 0) ?? 0 > 0
        }, timeout: 1), "We didn't load any results")

        waitForDuration(1)

        // Ensure we have 1 row
        XCTAssertEqual(1, cardSearchVC.tableView.numberOfRows(inSection: 0))
        XCTAssertTrue(cardSearchVC.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) is CardSearchResultTableViewCell)

    }

    /// Validate that when we search for multiple results, the table renders those results
    func testSearchMultipleResults() {
        guard let cardSearchVC = cardSearchVC else {
            XCTFail(topVCScreenshot)
            return XCTFail("Failed to get the Card Search VC, it was \(topVCType)")
        }

        // Show what we're searching for
        cardSearchVC.searchBar.text = "An"

        // Invoke the search for "Kool" (we know there is a single result, since we control the data source)
        cardSearchVC.search(for: "An")

        // Wait for there to be more than a single row
        XCTAssertTrue(waitForCondition({
            self.cardSearchVC?.tableView.numberOfRows(inSection: 0) ?? 0 > 0
        }, timeout: 1), "We didn't load any results")

        waitForCondition({
            cardSearchVC.tableView.numberOfRows(inSection: 0) == 5
        }, timeout: 5)

        // Ensure we have 1 row
        XCTAssertEqual(5, cardSearchVC.tableView.numberOfRows(inSection: 0))

        for i in 0..<5 {
            let indexPath = IndexPath(row: i, section: 0)
            cardSearchVC.tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
            waitForDuration(0.1)
            let cell = cardSearchVC.tableView.cellForRow(at: indexPath)
            waitForCondition({ cell is CardSearchResultTableViewCell }, timeout: 3)
            XCTAssertTrue(cell is CardSearchResultTableViewCell, "Cell at index \(i) wasn't the right type, it was \(String(describing: cell?.classForCoder))")
        }
    }

}

// MARK: - Demo

extension CardSearchUITest {

    func testAppDemo() {
        guard let cardSearchVC = cardSearchVC else {
            XCTFail(topVCScreenshot)
            return XCTFail("Couldn't get a reference to the Card Search VC, it was \(topVCType)")
        }

        var searchTerm = "Bat"
        delayTypingWord(word: searchTerm)
        cardSearchVC.search(for: searchTerm)

        XCTAssertTrue(waitForCondition({
            cardSearchVC.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) is CardSearchResultTableViewCell
        }, timeout: 3), "No search reults were available")

        waitForDuration(1)

        searchTerm = "Na"
        delayTypingWord(word: searchTerm)
        cardSearchVC.search(for: searchTerm)

        XCTAssertTrue(waitForCondition({
            return cardSearchVC.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) is CardSearchResultTableViewCell
        }, timeout: 3), "No search reults were available")

        XCTAssertEqual(2, self.cardSearchVC?.tableView.numberOfRows(inSection: 0))
        waitForDuration(0.5)
        cardSearchVC.tableView.scrollToRow(at: IndexPath(row: 1, section: 0), at: .middle, animated: false)
        waitForDuration(1)

        searchTerm = "R"

        delayTypingWord(word: searchTerm)
        cardSearchVC.search(for: searchTerm)

        XCTAssertTrue(waitForCondition({
            return cardSearchVC.tableView.numberOfRows(inSection: 0) == 15
        }, timeout: 3), "Wrong number of results were available")

        XCTAssertEqual(15, self.cardSearchVC?.tableView.numberOfRows(inSection: 0))

        cardSearchVC.tableView.scrollToRow(at: IndexPath(row: 1, section: 0), at: .bottom, animated: false)
        waitForDuration(1)
        cardSearchVC.tableView.scrollToRow(at: IndexPath(row: 3, section: 0), at: .bottom, animated: false)
        waitForDuration(1)
        cardSearchVC.tableView.scrollToRow(at: IndexPath(row: 5, section: 0), at: .bottom, animated: false)
        waitForDuration(1)
        cardSearchVC.tableView.scrollToRow(at: IndexPath(row: 7, section: 0), at: .bottom, animated: false)
        waitForDuration(1)
        cardSearchVC.tableView.scrollToRow(at: IndexPath(row: 9, section: 0), at: .bottom, animated: false)
        waitForDuration(1)
        cardSearchVC.tableView.scrollToRow(at: IndexPath(row: 13, section: 0), at: .bottom, animated: false)
        waitForDuration(2)
    }
}


// MARK: - Helpers

extension CardSearchUITest {

    func delayTypingWord(word: String, delay: TimeInterval = 0.5) {
        guard let cardSearchVC = cardSearchVC else {
            return
        }

        cardSearchVC.searchBar.text = ""

        var index = word.startIndex
        while index != word.endIndex {
            waitForDuration(delay)
            cardSearchVC.searchBar.text = word.substring(to: index)
            index = word.index(after: index)
        }

        waitForDuration(delay)
        cardSearchVC.searchBar.text = word

        waitForDuration(delay * 2)
    }

}

extension CardSearchResultTableViewController {

    /// Simulates tapping the cancel button on the search bar
    func tapCancel() {
        guard let searchBar = searchBar else {
            return
        }
        searchBarCancelButtonClicked(searchBar)
    }

}
