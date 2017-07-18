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
    var results: [Card]?

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
        guard let results = results else {
            return 0
        }
        return results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardSearchResultTableViewCell.Constants.cellID, for: indexPath)

        guard let cardCell = cell as? CardSearchResultTableViewCell else {
            return cell
        }
        cardCell.delegate = self
        cardCell.card = results?[indexPath.row]

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
        guard let cards = results else {
            return nil
        }

        for i in 0..<cards.count {
            guard cards[i].id == card.id else {
                continue
            }
            return IndexPath(row: i, section: 0)
        }
        
        return nil
    }

    func search(for cardNamed: String) {
        CardDataService.shared.search(for: cardNamed) { (error, cards) in
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
