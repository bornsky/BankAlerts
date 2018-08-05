
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
        
        let backgroundImages = [
            UIImage(named: "BOA BG")!,
            UIImage(named: "BB&T BG")!,
            UIImage(named: "Chase BG")!,
            UIImage(named: "Wellsfargo BG")!,
            UIImage(named: "Citi BG")!,
            UIImage(named: "US Bank BG")!,
            UIImage(named: "USAA BG")!,
            UIImage(named: "Capital One BG")!,
            UIImage(named: "Capital One BG")!,
            UIImage(named: "American Express BG")!,
            UIImage(named: "Charles Schwab BG")!,
            UIImage(named: "Fidelity BG")!,
            UIImage(named: "PNC BG")!,
            UIImage(named: "TD BG")!,
            UIImage(named: "Navy BG")!,
            UIImage(named: "SunTrust BG")!
        ]
        
        // List of background images on cells
        cell.backgroundView = UIImageView(image: backgroundImages[indexPath.row])
        cell.banks.text = self.institution?[indexPath.row].name
        
        // List of background bank images on segue
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
/*
     This will loop thru an array of images to put in cells
     if the cells turn nil then we want to display a blank solid background 
     image
     
    func images() -> [UIImage] {
        let backgroundImages = [
            UIImage(named: "")!,
            UIImage(named: "")!,
            UIImage(named: "")!,
            UIImage(named: "")!,
            UIImage(named: "")!,
            UIImage(named: "")!,
            UIImage(named: "")!,
            UIImage(named: "")!,
            UIImage(named: "")!,
            UIImage(named: "")!,
            UIImage(named: "")!,
            ]
        
        for i in backgroundImages {
            
        }
        return backgroundImages
    }
*/
    
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










