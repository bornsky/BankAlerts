//
//  TransactionsTableViewController.swift
//  BankAlert
//
//  Created by Courtney Osborne on 1/27/17.
//  Copyright © 2017 Courtney Osborne. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {
    
    var transaction : [Transaction]?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func updateUI() {
        
        PlaidTransaction.fetchTransactions { (transactions) in
            print(transactions)
            self.transaction = transactions
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = transaction?.count {
            return count
        }
        
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = self.transaction?[indexPath.row].name

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

}