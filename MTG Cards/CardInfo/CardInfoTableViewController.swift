//
//  CardInfoTableViewController.swift
//  MTG Cards
//
//  Created by Eric Internicola on 6/15/18.
//  Copyright © 2018 Eric Internicola. All rights reserved.
//

import UIKit

class CardInfoTableViewController: UITableViewController {

    var cardInfo: Card? {
        didSet {
            guard self.tableView != nil else {
                return
            }
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardImageCell", for: indexPath)
            guard let imageCell = cell as? CardImageCell else {
                return cell
            }
            imageCell.cardInfo = cardInfo

            return imageCell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardTitleCell", for: indexPath)
            guard let titleCell = cell as? CardTitleCell else {
                return cell
            }
            titleCell.cardInfo = cardInfo

            return titleCell
        }


    }

}
