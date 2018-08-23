//
//  TabBarController.swift
//  personal
//
//  Created by lixiang on 2018/5/28.
//  Copyright © 2018年 suzao. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let titleArray = ["头条新闻","头条新闻","头条新闻","头条新闻"]
        
        var normalImagesArray = [UIImage]()
        var selectedImagesArray = [UIImage]()
        
        for title in titleArray {
            normalImagesArray.append(UIImage(named:"选项卡"+title)!)
            selectedImagesArray.append(UIImage(named:"选项卡"+title+"选中")!)
        }
        
        let viewControllerArray = [
            ExampleTableViewController(),
            ExampleTableViewController(),
            ExampleTableViewController(),
            ExampleTableViewController()
        ]
        
        let navigationVCArray = NSMutableArray()
        for (index, controller) in viewControllerArray.enumerated() {
            controller.tabBarItem!.title = titleArray[index]
            controller.tabBarItem!.image = normalImagesArray[index].withRenderingMode(.alwaysOriginal)
            controller.tabBarItem!.selectedImage = selectedImagesArray[index].withRenderingMode(.alwaysOriginal)
            controller.tabBarItem!.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.gray], for: UIControlState())
            controller.tabBarItem!.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:themeRed], for:.selected)
            let nav = ThemeRedNavController(rootViewController:controller)
            navigationVCArray.add(nav)
        }
        self.viewControllers = navigationVCArray.mutableCopy() as! [UINavigationController]
    }

}
