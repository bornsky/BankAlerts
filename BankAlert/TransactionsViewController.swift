//
//  TransactionsViewController.swift
//  BankAlert
//
//  Created by Courtney Osborne on 1/27/17.
//  Copyright © 2017 Courtney Osborne. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var transaction : [Transaction]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    func updateUI() {
        
        PlaidTransaction.fetchTransactions { (transactions) in
            print(transactions)
            self.transaction = transactions
            self.tableView.reloadData()
        }   
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = transaction?.count {
            return count
        }
        
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = self.transaction?[indexPath.row].name

        return cell
    }


}



