//
//  AppDelegate.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/16/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import WatchConnectivity
import EventKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let store = EKEventStore()
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        HealthKitHelper.sharedHelper.getPermission()
        EventKitHelper.sharedHelper.getPermission()
        
        
        
        
        
        
       
    
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("app did resign active")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("app did enter background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("app will enter foreground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}


