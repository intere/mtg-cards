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

}

// MARK: - UISearchBarDelegate

extension CardSearchResultTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}
