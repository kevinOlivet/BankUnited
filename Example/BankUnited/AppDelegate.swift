//
//  AppDelegate.swift
//  BankUnited
//
//  Copyright (c) Jon Olivet. All rights reserved.
//

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

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let viewController = BankUnitedFactory().getExampleRootViewController()
        window?.rootViewController = viewController
        return true
    }
}

