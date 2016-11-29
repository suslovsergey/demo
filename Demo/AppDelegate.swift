//
//  AppDelegate.swift
//  Demo
//
//  Created by Sergey Suslov on 19.11.16.
//  Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import Log

public let Log = Logger()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var cr: Cron = Cron()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().tintColor = .black
        Log.minLevel = .trace
        // Override point for customization after application launch.
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        Cron.stop()
    }


    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }


    func applicationDidBecomeActive(_ application: UIApplication) {
    }


    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
