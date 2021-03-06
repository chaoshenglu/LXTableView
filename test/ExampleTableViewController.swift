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
        title = "头条新闻"
        tableView.estimatedRowHeight = 90
        tableView.es.addPullToRefresh {
            self.refreshData()
        }
        tableView.es.addInfiniteScrolling {
            self.loadMoreData()
        }
        refreshData()
    }
    
    @objc private func loadMoreData() {
        let param = ["page":page,"size":10]
        NetworkTool.requestExampleData(param:param) {[weak self](models) in
            self?.configWithModels(models:models)
        }
    }
    
    @objc private func refreshData() {
        page = 1
        loadMoreData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArr.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ExampleListCell.cell(tableView: tableView)
        let model = self.modelArr[indexPath.row] as! ExampleModel
        cell.config(model:model)
        return cell
    }
    
    override func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        didFinishRequest = false
        tableView.reloadData()
        refreshData()
    }
    
}






