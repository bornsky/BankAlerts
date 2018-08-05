//
//  ViewController.swift
//  BankAlert
//
//  Created by Courtney Osborne on 12/9/16.
//  Copyright © 2016 Courtney Osborne. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var bankingLogoImage: UIImageView!
    @IBOutlet weak var pars: UILabel!
    
    let notificationlogo = RKNotificationHub()
    var time = Timer()
    
    var humans = [Human]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationRepeat()
        
        notificationlogo.setView(self.bankingLogoImage, andCount: 1)
        notificationlogo.moveCircleBy(x: -79, y: 50)
        notificationlogo.blink()
        
        HumanCall()
        
    }
    
    func animationRepeat() {
        let basic = CABasicAnimation(keyPath: "backgroundcolor")
        basic.duration = 2.0
        basic.repeatDuration = 1.0
        basic.fromValue = UIColor.black.cgColor
        basic.toValue = UIColor.red.cgColor
    }
    
   fileprivate func HumanCall() {
        
        let urlString = ""
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    self.humans = try JSONDecoder().decode([Human].self, from: data)
                    
                    print(self.humans)
                    
//                    self.tableView.reloadData()
                    
                } catch let jsonError {
                    
                    print(jsonError)
                }
            }
            
        }.resume()
    }
}

















