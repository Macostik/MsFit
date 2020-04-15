//
//  AppDelegate.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import SafariServices

let kSafariViewControllerCloseNotification = "kSafariViewControllerCloseNotification"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
//    optional func application(_ app: UIApplication,
//                              open url: URL,
//                              options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        print("app: \(app)")
//        // print OAuth response URL
//        print("url: \(url)")
//        print("options: \(options)")
//
//        if let sourceApplication = options["UIApplicationOpenURLOptionsSourceApplicationKey"] as? String {
//            if (sourceApplication == "com.testApp.Incognito") {
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kSafariViewControllerCloseNotification), object: url)
//                return true
//            }
//        }
//        return true
//    }
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        print("app: \(app)")
               print("url: \(url)")
               print("options: \(options)")
        return true
    }
}
