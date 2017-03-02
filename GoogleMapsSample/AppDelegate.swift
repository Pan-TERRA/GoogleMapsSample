//
//  AppDelegate.swift
//  GoogleMapsSample
//
//  Created by Vlad Krut on 02.03.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private static let APIKey = "AIzaSyApz42XLoK2OAn5qTDqsjIbybnaoN6aJ6I"

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(AppDelegate.APIKey)
        
        return true
    }
}

