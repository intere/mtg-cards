//
//  CardSearchResultTableViewController.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/18/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import UIKit

class CardSearchResultTableViewController: UITableViewController {

    @IBOutlet var searchBar: UISearchBar!
    var results: CardResultSet?

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let results = results, results.cards.count > 0 else {
            return 1
        }
        return results.cards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let results = results else {
            return tableView.dequeueReusableCell(withIdentifier: Constants.enterSearchCellId, for: indexPath)
        }
        guard results.cards.count > 0 else {
            return tableView.dequeueReusableCell(withIdentifier: Constants.noResultsCellId, for: indexPath)
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: CardSearchResultTableViewCell.Constants.cellID, for: indexPath)

        guard let cardCell = cell as? CardSearchResultTableViewCell else {
            return cell
        }
        cardCell.delegate = self
        let cardName = results.sortedKeys[indexPath.row]
        cardCell.card = results.cards[cardName]?.first

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

    func indexOf(card: Card) -> IndexPath? {
        guard let sortedKeys = results?.sortedKeys else {
            return nil
        }

        for i in 0..<sortedKeys.count {
            guard sortedKeys[i] == card.name else {
                continue
            }
            return IndexPath(row: i, section: 0)
        }
        
        return nil
    }

    func search(for cardNamed: String) {
        RemoteCardService.shared.search(for: cardNamed) { (error, cards) in
            if let error = error {
                return print("ERROR searching for card \(cardNamed): \(error)")
            }
            guard let cards = cards else {
                return print("ERROR, no cards returned searching for \(cardNamed)")
            }
            self.results = cards
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
