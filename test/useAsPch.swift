//
//  File.swift
//  piFaBan
//
//  Created by lixiang on 2017/10/12.
//  Copyright © 2017年 piFaBan. All rights reserved.
//

import Foundation
import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

let log_response_maxLength = 1000
let success_and_noException = 1
let fail_because_noNetwork = -1009

///灰色，用于分割线
let lineGray        = UIColor(red:0.850, green:0.850, blue:0.850, alpha:1)
///灰色，用于分割线
let e5Gray          = UIColor(red:0.898, green:0.898, blue:0.898, alpha:1)
///我发消息的气泡中灰色分割线
let myBubbleLineGray    = UIColor(red:0.895, green:0.895, blue:0.895, alpha:1)
///灰色，苹果默认的textfield占位文字使用的灰色
let applePlhderGray = UIColor(red:0.800, green:0.800, blue:0.820, alpha:1)
///常规黑色
let labelBlack      = UIColor(red:0.200, green:0.200, blue:0.200, alpha:1)
///常规灰色
let labelGray       = UIColor(red:0.400, green:0.400, blue:0.400, alpha:1)
///灰色，比常规灰色更淡
let labelLightGray  = UIColor(red:0.600, green:0.600, blue:0.600, alpha:1)
///主题红
let themeRed        = UIColor(red:1.000, green:0.200, blue:0.240, alpha:1)
///背景灰
let backGray        = UIColor(red:0.950, green:0.950, blue:0.950, alpha:1)
///灰色，苹果默认的tableViewCell分割线颜色
let appleLineGray   = UIColor(red:0.830, green:0.830, blue:0.840, alpha:1)

///快捷访问AppDelegate
let LXAppDelegate = UIApplication.shared.delegate as! AppDelegate

func printLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line){
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}








