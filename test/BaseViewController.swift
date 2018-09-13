//
//  BaseViewController.swift
//  personal
//
//  Created by lixiang on 2018/7/26.
//  Copyright © 2018年 suzao. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var baidu_className = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backGray
        baidu_className = NSStringFromClass(type(of: self))
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        BaiduMobStat.default().pageviewStart(withName:baidu_className)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        BaiduMobStat.default().pageviewEnd(withName:baidu_className)
    }
    
}



