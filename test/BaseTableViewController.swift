//
//  BaseTableViewController.swift
//  suzao
//
//  Created by lixiang on 2018/5/19.
//  Copyright © 2018年 17suzao. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    private var baidu_className = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = backGray
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = true
        baidu_className = NSStringFromClass(type(of: self))
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style:style)
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
