//
//  ThemeRedNavController.swift
//  personal
//
//  Created by lixiang on 2018/6/22.
//  Copyright © 2018年 suzao. All rights reserved.
//

import UIKit

class ThemeRedNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = themeRed
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize:19),NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationBar.subviews.first?.subviews.first?.isHidden = true
    }

}
