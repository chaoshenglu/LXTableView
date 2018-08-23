//
//  AppDelegate.swift
//  test
//
//  Created by lixiang on 2018/6/28.
//  Copyright © 2018年 lixiang. All rights reserved.
//

import UIKit
import RealReachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var netStatus = ReachabilityStatus.RealStatusNotReachable

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        initRealReachability()
        return true
    }

    ///初始化RealReachability
    private func initRealReachability() {
        RealReachability.sharedInstance().startNotifier()
        RealReachability.sharedInstance().hostForPing = "www.baidu.com"
        NotificationCenter.default.addObserver(self, selector:#selector(networkChanged),name:
            Notification.Name.init(rawValue:"kRealReachabilityChangedNotification"), object:nil)
        //获取网络状态
        RealReachability.sharedInstance().reachability { (currentStatus) in
            self.netStatus = currentStatus
            self.printNetworkStatus(currentStatus)
        }
    }
    
    ///监听网络状态
    @objc private func networkChanged(noti:NSNotification) {
        let reachability = noti.object as! RealReachability
        netStatus = reachability.currentReachabilityStatus()
        printNetworkStatus(netStatus)
    }
    
    ///打印网络状态
    private func printNetworkStatus(_ status:ReachabilityStatus) {
        if status == ReachabilityStatus.RealStatusUnknown {
            print("当前网络：未知网络")
        } else if status == ReachabilityStatus.RealStatusNotReachable {
            print("当前网络：无法连接")
        } else if status == ReachabilityStatus.RealStatusViaWWAN {
            print("当前网络：数据流量")
        } else if status == ReachabilityStatus.RealStatusViaWiFi {
            print("当前网络：WIFI")
        }
    }
}

