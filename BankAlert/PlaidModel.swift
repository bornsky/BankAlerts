//
//  PlaidModel.swift
//  BankText
//
//  Created by Courtney Osborne on 11/29/16.
//  Copyright © 2016 Courtney Osborne. All rights reserved.
//

import Foundation

public struct URLPaths {
    
    let connect = "/connect"
    let auth = "/auth"
    let balance = "/balance"
    let info = "/info"
    let income = "/income"
    let risk = "/risk"
    let upgrade = "/upgrade"
    let institutions = "/institutions"
    let categories = "/categories"
}

class Credentials {
    
    var username : String? //"plaid_test"
    var password : String? // "plaid_good"
    var type : String? // "test_wells"
}


public class Quickstart: NSObject {
/*
    //Gaining access urlpath
    func accessUrlPath() {
        let credentials = Credentials()
        let path = URLPaths()
        
         let components = NSURLComponents()
         components.host = "https://tartan.plaid.com/connect"
         components.path = "\(path.connect)"
         components.scheme = "https"
         let clientId = URLQueryItem(name: "client_id", value: credentials.client_id)
         let secret = URLQueryItem(name: "secret", value: credentials.secret)
         let username = URLQueryItem(name: "username", value: credentials.username)
         let password = URLQueryItem(name: "password", value: credentials.password)
         let type = URLQueryItem(name: "wells", value: credentials.type)
 
        components.queryItems = [clientId, secret, username, password, type]
        print(components.string!)
    }
*/
    static func myData(username: String, password: String, type: String, completionhandler: @escaping ([Credentials]) -> ()) {
        
        var keys: [String: Any]?
        
        if let path = Bundle.main.path(forResource: "Plaidkeys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path) as! [String : Any]?
        }
        
        if let dict = keys {
            let secret = dict["secret"] as? String
            let client_id = dict["client_id"] as? String
        
        let urlpath = "https://tartan.plaid.com/connect?&client_id=\(client_id!)&secret=\(secret!)&username=\(username)&password=\(password)&type=\(type)"
        
        let endpoint = URL(string: urlpath)
        var request = URLRequest(url: endpoint!)
        let session = URLSession.shared
        
        request.httpMethod = "POST"
        
            let task = session.dataTask(with: request) { (data, response, err) in
                
                if let error = err {
                    print(error)
                    return
                }
                
                do {
                    let _ = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    
                    
                } catch let error as NSError {
                    print(error)
                }
            }
        task.resume()
        }
    }
}




