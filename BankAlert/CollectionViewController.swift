//
//  BankViewController.swift
//  BankText
//
//  Created by Courtney Osborne on 11/30/16.
//  Copyright © 2016 Courtney Osborne. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    
    var institution : [Institutions]?
    
    var images = [UIImage]()
    var bankType: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    // CollectionViewDelegate & Datasource
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.delegate = self
        
        updateUI()
    }
    
    func fetchTransaction() {
        var date = DateComponents()
        date.second = 20
    }
    
    
    func updateUI() {
        
        PlaidInstitutions.fetchInstitutionsdata { (institution) in
            self.institution = institution
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - CollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = institution?.count {
            return count
        }
        return 0
    }
    
    // MARK: - CollectionViewDatascource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BanksCollectionViewCell
        
        cell.banks.text = self.institution?[indexPath.row].name
        
        // List of background bank images
        self.images = [
            UIImage(named: "BOA")!,
            UIImage(named: "BB&T")!,
            UIImage(named: "Chase")!,
            UIImage(named: "Wellsfargo")!,
            UIImage(named: "Citi")!,
            UIImage(named: "US Bank")!,
            UIImage(named: "USAA")!,
            UIImage(named: "Capital One")!,
            UIImage(named: "Capital One")!,
            UIImage(named: "American Express")!,
            UIImage(named: "Charles Schwab")!,
            UIImage(named: "Fidelity")!,
            UIImage(named: "PNC")!,
            UIImage(named: "TD")!,
            UIImage(named: "Navy")!,
            UIImage(named: "SunTrust")!
        ]
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Selected Bank" {
            let segue = segue.destination as! LoginViewController
            let path = self.collectionView.indexPath(for: sender as! UICollectionViewCell)
            segue.bankImage = self.images[(path?.row)!]
            
            // Send credientals with segue
            PlaidManager.sharedManager.credentials.type = self.institution?[(path?.row)!].type
            
        }
    }
}










