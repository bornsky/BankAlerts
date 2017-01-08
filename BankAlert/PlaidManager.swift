//
//  PlaidManager.swift
//  BankAlert
//
//  Created by Courtney Osborne on 1/6/17.
//  Copyright © 2017 Courtney Osborne. All rights reserved.
//

import Foundation

struct PlaidManager {
    static let sharedManager = PlaidManager()
    let transaction = PlaidTransaction()
    let institution = PlaidInstitutions()
    let credentials = Credentials()
}
