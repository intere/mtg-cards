//
//  AppUISmokeTest.swift
//  MTG CardsTests
//
//  Created by Eric Internicola on 12/28/18.
//  Copyright © 2018 Eric Internicola. All rights reserved.
//

@testable import MTG_Cards
import XCTest
import SafariServices

class AppUISmokeTest: BaseUITest {

    override func setUp() {
        super.setUp()
        disableAnimations()
        shouldPauseUI = true
        XCTAssertTrue(waitForCondition({ self.cardSearchVC != nil }, timeout: 1), topVCScreenshot)
    }

    override func tearDown() {
        topVC?.navigationController?.popToRootViewController(animated: false)
        XCTAssertTrue(waitForCondition({ self.cardSearchVC != nil }, timeout: 1), topVCScreenshot)
        enableAnimations()
        super.tearDown()
    }


    func testCollectedCompany() {
        let searchText = "Collected Comp"
        XCTAssertTrue(waitForCondition({ self.cardSearchVC != nil }, timeout: 1), topVCScreenshot)

        // Show what we're searching for
        cardSearchVC?.searchBar.text = searchText

        // Invoke the search for "Drunken" (we know there are no results, since we control the data source)
        cardSearchVC?.search(for: searchText)
        pauseForUIDebug()

        XCTAssertTrue(waitForCondition({
            guard let cardSearchVC = self.cardSearchVC else {
                return false
            }
            guard cardSearchVC.tableView.numberOfRows(inSection: 0) > 0,
                CardSearchResultTableViewController.Constants.noResultsCellId
                    != cardSearchVC.tableView(cardSearchVC.tableView, cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier else {
                    return false
            }
            return true

        }, timeout: 5), topVCScreenshot)
        pauseForUIDebug()

        if let cardSearchVC = cardSearchVC {
            let cell = cardSearchVC.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
            cardSearchVC.performSegue(withIdentifier: "LoadCardSegue", sender: cell)
        }

        XCTAssertTrue(waitForCondition({ self.cardInfoVC != nil }, timeout: 1), topVCScreenshot)
        pauseForUIDebug()
    }

    func testCavern() {
        let searchText = "Cavern"
        XCTAssertTrue(waitForCondition({ self.cardSearchVC != nil }, timeout: 1), topVCScreenshot)

        // Show what we're searching for
        cardSearchVC?.searchBar.text = searchText

        // Invoke the search for "Drunken" (we know there are no results, since we control the data source)
        cardSearchVC?.search(for: searchText)
        pauseForUIDebug()

        XCTAssertTrue(waitForCondition({
            guard let cardSearchVC = self.cardSearchVC else {
                return false
            }
            guard cardSearchVC.tableView.numberOfRows(inSection: 0) > 0,
                CardSearchResultTableViewController.Constants.noResultsCellId
                    != cardSearchVC.tableView(cardSearchVC.tableView, cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier else {
                        return false
            }
            return true

        }, timeout: 5), topVCScreenshot)
        pauseForUIDebug()

        if let cardSearchVC = cardSearchVC, let results = cardSearchVC.results, let row = results.firstIndex(where: { $0.name == "Cavern of Souls" }) {
            cardSearchVC.tableView.scrollToRow(at: IndexPath(row: row, section: 0), at: .middle, animated: false)
            let cell = cardSearchVC.tableView.cellForRow(at: IndexPath(row: row, section: 0))
            cardSearchVC.performSegue(withIdentifier: "LoadCardSegue", sender: cell)
        }

        XCTAssertTrue(waitForCondition({ self.cardInfoVC != nil }, timeout: 1), topVCScreenshot)
        pauseForUIDebug()
    }

}

// MARK: - Deliberately broken tests

extension AppUISmokeTest {

    func testThrowAWrenchInTheGears() {
        let searchText = "Cavern"
        XCTAssertTrue(waitForCondition({ self.cardSearchVC != nil }, timeout: 1), topVCScreenshot)

        // Show what we're searching for
        cardSearchVC?.searchBar.text = searchText

        // Invoke the search for "Drunken" (we know there are no results, since we control the data source)
        cardSearchVC?.search(for: searchText)
        pauseForUIDebug()

        XCTAssertTrue(waitForCondition({
            guard let cardSearchVC = self.cardSearchVC else {
                return false
            }
            guard cardSearchVC.tableView.numberOfRows(inSection: 0) > 0,
                CardSearchResultTableViewController.Constants.noResultsCellId
                    != cardSearchVC.tableView(cardSearchVC.tableView, cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier else {
                        return false
            }
            return true

        }, timeout: 5), topVCScreenshot)
        pauseForUIDebug()

        var card: Card?

        if let cardSearchVC = cardSearchVC, let results = cardSearchVC.results, let row = results.firstIndex(where: { $0.name == "Cavern of Souls" }) {
            card = results[row]
            cardSearchVC.tableView.scrollToRow(at: IndexPath(row: row, section: 0), at: .middle, animated: false)
            let cell = cardSearchVC.tableView.cellForRow(at: IndexPath(row: row, section: 0))
            cardSearchVC.performSegue(withIdentifier: "LoadCardSegue", sender: cell)
        }

        XCTAssertTrue(waitForCondition({ self.cardInfoVC != nil }, timeout: 1), topVCScreenshot)
        pauseForUIDebug()

        if let card = card, let url = URL(string: "http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=\(card.multiverseid)") {
            presentModally(viewController: SFSafariViewController(url: url))
            waitForDuration(3)
        }
        pauseForUIDebug()
        XCTAssertTrue(waitForCondition({ self.cardInfoVC != nil }, timeout: 1), topVCScreenshot)
        pauseForUIDebug()

        if topVC is SFSafariViewController {
            topVC?.dismiss(animated: false)
        }
        XCTAssertTrue(waitForCondition({ !(self.topVCType is SFSafariViewController) }, timeout: 1))
    }

}
