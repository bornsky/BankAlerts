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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationRepeat()
        
        notificationlogo.setView(self.bankingLogoImage, andCount: 1)
        notificationlogo.moveCircleBy(x: -79, y: 50)
        notificationlogo.blink()
        
    }
    
    func animationRepeat() {
        let basic = CABasicAnimation(keyPath: "backgroundcolor")
        basic.duration = 2.0
        basic.repeatDuration = 1.0
        basic.fromValue = UIColor.black.cgColor
        basic.toValue = UIColor.red.cgColor
        
    }

}

