//
//  Transactions.swift
//  BankAlert
//
//  Created by Courtney Osborne on 1/6/17.
//  Copyright © 2017 Courtney Osborne. All rights reserved.
//

import Foundation

internal class Transaction: NSObject {
    var name: String
    var pending : Bool
    var amount : Double
    
    init?(transaction: [String: Any]) {
        
        self.name = transaction["name"] as! String
        self.pending = transaction["pending"] as! Bool
        self.amount = transaction["amount"] as! Double
    }
}

class PlaidTransaction: NSObject {
 
    /*
     // Plaid URL for Transactions
    func transactionsUrlPath() -> NSURLComponents {
        
        let client_id = PlaidManager.sharedManager.credentials.client_id
        let secret = PlaidManager.sharedManager.credentials.secret
        let username = PlaidManager.sharedManager.credentials.username
        let password = PlaidManager.sharedManager.credentials.password
        
        let components = NSURLComponents()
        components.host = "cdn.plaid.com"
        components.scheme = "https"
        components.path = "/link/v2/stable/link.html?"
        components.query = "&client_id=\(client_id)&secret=\(secret)&username=\(username)&password=\(password)&access_token=test_wells"
        
        return components
    }
*/
    // MARK: PLAID USER KICK
    static func fetchTransactions(handler: @escaping ([Transaction]) -> ()) {
        
        var keys: [String: Any]?
        
        if let path = Bundle.main.path(forResource: "Plaidkeys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path) as! [String : Any]?
        }
        
        if let dict = keys {
            let type = "test_wells"
            let secret = dict["secret"] as? String
            let client_id = dict["client_id"] as? String
            
            let urlpath = "https://tartan.plaid.com/connect/get?&client_id=\(client_id!)&secret=\(secret!)&access_token=\(type)"
            
            let endpoint = URL(string: urlpath)
            var request = URLRequest(url: endpoint!)
            let session = URLSession.shared
            
            request.httpMethod = "POST"
            
            let task = session.dataTask(with: request) { (data, response, err) in
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                    var trans : [Transaction] = []
                    for i in json["transactions"] as! [[String: Any]] {
                        
                        if let transaction = Transaction(transaction: i) {
                            
                            trans.append(transaction)
                        }
                    }
                    DispatchQueue.main.async(execute: { handler(trans)
                        
                    })
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            task.resume()
        }
    }
}


