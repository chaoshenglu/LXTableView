//
//  ExampleTableViewController.swift
//  enterprise
//
//  Created by lixiang on 2018/6/7.
//  Copyright © 2018年 suzao. All rights reserved.
//

import UIKit

class ExampleTableViewController: LXTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "工业头条"
        tableView.estimatedRowHeight = 80
        tableView.mj_header = MJDIYHeader(refreshingTarget:self,refreshingAction:#selector(clearAndRefreshData))
        tableView.mj_footer = MJDIYAutoFooter(refreshingTarget:self,refreshingAction:#selector(requestListData))
        requestListData()
    }
    
    @objc private func requestListData() {
        let param = ["page":page,"size":10]
        NetworkHeadlineTool.requestHeadlineList(param:param) {[weak self](models) in
            self?.configWithHeaderAndFooter(models:NSMutableArray(array:models))
        }
    }
    
    @objc private func clearAndRefreshData() {
        page = 1
        requestListData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArr.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HeadlineListCell.cell(tableView: tableView)
        let model = self.modelArr[indexPath.row] as! HeadlineListModel
        cell.config(model:model)
        return cell
    }
    
}






