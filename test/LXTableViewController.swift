//
//  LXTableViewController.swift
//  piFaBan
//
//  Created by lixiang on 2018/1/4.
//  Copyright © 2018年 piFaBan. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class LXTableViewController:BaseTableViewController,EmptyDataSetSource,EmptyDataSetDelegate {
    
    var page = 1
    var modelArr = NSMutableArray()
    var didFinishRequest = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    func configWithHeaderAndFooter(models:NSMutableArray){
        didFinishRequest = true
        if page == 1 {
            modelArr.removeAllObjects()
            modelArr.addObjects(from:models as! [Any])
            tableView.reloadData()
            tableView.mj_header?.endRefreshing()
            tableView.mj_footer.resetNoMoreData()
        }else{
            modelArr.addObjects(from:models as! [Any])
            tableView.reloadData()
            if models.count == 0 && modelArr.count != 0 {
                tableView.mj_footer?.endRefreshingWithNoMoreData()
            }else{
                tableView.mj_footer?.endRefreshing()
            }
        }
        page = page+1
    }
    
    func configWithHeader(models:NSMutableArray){
        didFinishRequest = true
        modelArr.removeAllObjects()
        modelArr.addObjects(from: models as! [Any])
        tableView.reloadData()
        tableView.mj_header?.endRefreshing()
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        var attributes: [NSAttributedStringKey: Any] = [:]
        attributes[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 14)
        attributes[NSAttributedStringKey.foregroundColor] = labelLightGray
        return NSAttributedString.init(string:"暂无数据", attributes: attributes)
    }

    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named:"通用空界面")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -64
    }
    
    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        if didFinishRequest {
            return nil
        }else{
            let ac = UIActivityIndicatorView(activityIndicatorStyle:.gray)
            ac.startAnimating()
            return ac
        }
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
}








