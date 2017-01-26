//
//  AppDelegate.swift
//  BankAlert
//
//  Created by Courtney Osborne on 12/9/16.
//  Copyright © 2016 Courtney Osborne. All rights reserved.
//

import UIKit
import FirebaseMessaging
import Firebase
import UserNotifications
import UserNotificationsUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Config Firebase
        FIRApp.configure()
        
        // Register with APNs
        UIApplication.shared.registerForRemoteNotifications()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization
        }
        UNUserNotificationCenter.current().getNotificationSettings { (UNNotificationSettings) in
            
        }
        application.registerForRemoteNotifications()
        
        application.setMinimumBackgroundFetchInterval(10)
        
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Fetch with completion handler for a certain amount of stuff
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
     
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Forward the token to your server.
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo) // Should send userinfo
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        // The token is not currently available.
        print("Remote notification support is unavailable due to error: \(error.localizedDescription)")
        
    
    }
}

