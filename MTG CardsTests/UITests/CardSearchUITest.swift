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
        waitForCondition({
            return self.cardSearchVC != nil
        }, timeout: 5)
    }
    
    override func tearDown() {
        // Stop Mocking (swap the real card service back in)
        MockCardDataService.endMocking()

        super.tearDown()
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

        // Ensure we have 1 row
        XCTAssertEqual(1, cardSearchVC.tableView.numberOfRows(inSection: 0))
        XCTAssertTrue(cardSearchVC.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) is CardSearchResultTableViewCell)

    }

    /// Validate that when we search for multiple results, the table renders those results
    func testSearchMultipleResults() {
        guard let cardSearchVC = cardSearchVC else {
            return XCTFail("Failed to get the Card Search VC, it was \(topVCType)")
        }

        // Show what we're searching for
        cardSearchVC.searchBar.text = "An"

        // Invoke the search for "Kool" (we know there is a single result, since we control the data source)
        cardSearchVC.search(for: "An")

        // Wait for there to be more than a single row
        XCTAssertTrue(waitForCondition({
            return self.cardSearchVC?.tableView.numberOfRows(inSection: 0) ?? 0 > 0
        }, timeout: 1), "We didn't load any results")

        // Ensure we have 1 row
        XCTAssertEqual(5, cardSearchVC.tableView.numberOfRows(inSection: 0))

        for i in 0..<5 {
            let indexPath = IndexPath(row: i, section: 0)
            cardSearchVC.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            XCTAssertTrue(cardSearchVC.tableView.cellForRow(at: indexPath) is CardSearchResultTableViewCell)
            waitForDuration(1)
        }
    }

}

