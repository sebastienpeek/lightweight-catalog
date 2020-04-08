//
//  AppDelegate.swift
//  lightweight
//
//  Created by Sebastien Audeon on 4/8/20.
//  Copyright © 2020 Sebastien Audeon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Application is about to resign (background/phone call/etc)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Application has entered the background
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Application is about to enter the foreground
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Application has been marked as active and in the foreground
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Application has been killed entirely
    }

}

