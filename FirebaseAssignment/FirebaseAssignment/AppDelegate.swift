//
//  AppDelegate.swift
//  FirebaseAssignment
//
//  Created by Rich Blanchard on 3/20/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
         FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
        return true
    }
}

