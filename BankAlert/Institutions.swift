//
//  Institutions.swift
//  BankAlert
//
//  Created by Courtney Osborne on 1/6/17.
//  Copyright © 2017 Courtney Osborne. All rights reserved.
//

import Foundation

internal class Institutions : NSObject {
    
    var id : String
    var name : String
    var type : String
    var hasmfa : Bool
    
    init(id: String, name: String, type: String, hasmfa: Bool) {
        
        self.id = id
        self.name = name
        self.type = type
        self.hasmfa = hasmfa
    }
    //    enum Product: String {
    //        case connect, auth, balance, info, income, risk
    //    }
    //    enum Mfa: String {
    //        case code, list, questions
    //    }
    //    let product: Set<Product>
    //    let mfa: Set<Mfa>
    //    let credentials: (username: String, password: String)
    
    init?(json: [String: Any]) {
        
        //        let credentials = json["credentials"] as? [String: String],
        //            let username = credentials["username"],
        //            let password = credentials["password"],
        //        let productsJson = json["products"] as? [String],
        //        let mfaJson = json["mfa"] as? [String]
        
        //            guard let product = Product(rawValue: string) else {
        //            guard let mfa = Mfa(rawValue: string) else {
        
        self.id = json["id"] as! String
        self.name = json["name"] as! String
        self.type = json["type"] as! String
        self.hasmfa = json["has_mfa"] as! Bool
        //        self.credentials = (username, password)
        //        self.product = products
        //        self.mfa = mfas
    }
}

public class PlaidInstitutions: NSObject {
    
    // MARK: PLAID KICK
    static func fetchInstitutionsdata(completionhandler: @escaping ([Institutions]) -> ()) {
        
        let urlpath = "https://tartan.plaid.com/institutions"
        let endpoint = URL(string: urlpath)
        var request = URLRequest(url: endpoint!)
        let session = URLSession.shared
        
        request.httpMethod = "GET" //Insititutions
        
        let task = session.dataTask(with: request) { (data, response, err) in
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: Any]]
                
                var institutions: [Institutions] = []
                
                for banks in json {
                    
                    if let bank = Institutions(json: banks) {
                        
                        institutions.append(bank)
                    }
                }
                DispatchQueue.main.async(execute: {
                    completionhandler(institutions)
                })
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
}
