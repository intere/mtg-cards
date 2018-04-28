//
//  CardSearchResultTableViewController.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/18/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import UIKit

/// The TableView for the Card Search Results
class CardSearchResultTableViewController: UITableViewController {

    /// The Search Bar reference
    @IBOutlet var searchBar: UISearchBar!

    /// The results that we got back from the API
    var results: [Card]?

    struct Constants {
        static let noResultsCellId = "NoResultsCell"
        static let enterSearchCellId = "EnterSearchCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        tableView.tableFooterView = UIView()
    }

}

// MARK: - Table view data source


extension CardSearchResultTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let results = results, results.count > 0 else {
            return 1
        }
        return results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let results = results else {
            return tableView.dequeueReusableCell(withIdentifier: Constants.enterSearchCellId, for: indexPath)
        }
        guard results.count > 0 else {
            return tableView.dequeueReusableCell(withIdentifier: Constants.noResultsCellId, for: indexPath)
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: CardSearchResultTableViewCell.Constants.cellID, for: indexPath)

        guard let cardCell = cell as? CardSearchResultTableViewCell else {
            return cell
        }
        cardCell.delegate = self
        cardCell.card = results[indexPath.row]

        return cardCell
    }

}

// MARK: - UISearchBarDelegate

extension CardSearchResultTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else {
            return
        }
        search(for: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        results = nil
        tableView.reloadData()
    }

}

// MARK: - CardImageLoadedDelegate

extension CardSearchResultTableViewController: CardImageLoadedDelegate {

    func imageLoaded(for card: Card) {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }

}

// MARK: - Implementation

extension CardSearchResultTableViewController {

    /// Gets you the card at the provided index.
    ///
    /// - Parameter card: The card that you want the index of.
    /// - Returns: The index of that card (as an IndexPath) or nil if it's not found.
    func indexOf(card: Card) -> IndexPath? {
        guard let cards = results else {
            return nil
        }

        for i in 0..<cards.count where cards[i].id == card.id {
            return IndexPath(row: i, section: 0)
        }
        
        return nil
    }

    /// Searches for magic cards that match the provided card name (substring).
    /// The matching is based on substring matching.  For example, a search for "Amber"
    /// returns a number of results:
    /// - Amber Prison
    /// - Chamber of Manipulation
    /// - Chambered Nautilus
    /// - etc
    ///
    /// - Parameter searchTerm: Some string that you want to search cards for matches by name.
    func search(for searchTerm: String) {
        RemoteCardService.shared.search(for: searchTerm) { (error, cards) in
            if let error = error {
                return print("ERROR searching for card \(searchTerm): \(error)")
            }
            guard let cards = cards else {
                return print("ERROR, no cards returned searching for \(searchTerm)")
            }
            self.results = cards
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
