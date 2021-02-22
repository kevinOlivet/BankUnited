//
//  AppDelegate.swift
//  BankUnited
//
//  Copyright (c) Jon Olivet. All rights reserved.
//

import AlamofireNetworkActivityLogger
import BankUnited
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch and to enableStubs
        #if DEBUG
        BankUnitedStubs().enableStubs()
        #endif
        
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let viewController = BankUnitedFactory().getRootViewController()
        window?.rootViewController = viewController
        return true
    }
}

