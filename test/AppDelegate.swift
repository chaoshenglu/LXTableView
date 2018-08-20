//
//  AppDelegate.swift
//  test
//
//  Created by lixiang on 2018/6/28.
//  Copyright © 2018年 lixiang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        return true
    }

}

