//
//  BankLoginViewController.swift
//  BankAlert
//
//  Created by Courtney Osborne on 12/22/16.
//  Copyright © 2016 Courtney Osborne. All rights reserved.
//

import UIKit
import UserNotifications

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var bankImageView: UIImageView! {
        didSet {
            self.bankImageView.image = self.bankImage
        }
    }
    
    var bankImage: UIImage!
    
    let success = true
    var transaction : [Transaction]?
    var credentials: Credentials?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.username.delegate = self
        self.password.delegate = self
        
    // Sends Notification
        notificationContent()
        transactionAlerts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         self.username.becomeFirstResponder()
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        successfulLogin()
    }
    
    func successfulLogin() {
        
    // Checking empty textfields
        if username.text == nil || username.text == "" || password.text == nil || password.text == "" {
            let alert = UIAlertController(title: "Username or password is incorrect", message: "Must enter in Username and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
 
        } else {
    // Successfully login alert will show
           Quickstart.myData(username: "plaid_test", password: "plaid_good", type: "wells", completionhandler: { (Credentials) in
            print(Credentials)
           })
            
            let successfulalert = UIAlertController(title: "Congrats", message: "You will start receiving transaction alerts", preferredStyle: .alert)
            successfulalert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.cancel, handler: nil))
            // Present the AlertController
            self.present(successfulalert, animated: true, completion: nil)
        }
    }
    
    /* If user successfully login and is authicated then this function will fire with the correct amount of data */
    func transactionAlerts() {
        PlaidTransaction.fetchTransactions { (transaction) in
         self.transaction = transaction   
        }
    }
    
    // Fires Notification Alert one a new bank
    func notificationContent() {
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Title", arguments: nil)
        content.subtitle = NSString.localizedUserNotificationString(forKey: "Subtitle", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Body Text", arguments: nil)
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "Five", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError)
            }
        }
    }
    
    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    }

}
