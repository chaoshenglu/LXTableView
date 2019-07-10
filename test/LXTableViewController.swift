//
//  LXTableViewController.swift
//  piFaBan
//
//  Created by lixiang on 2018/1/4.
//  Copyright © 2018年 piFaBan. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift
import ESPullToRefresh

class LXTableViewController:BaseTableViewController,EmptyDataSetSource,EmptyDataSetDelegate {
    
    var page = 1
    var modelArr = [Any]()
    var didFinishRequest = false
    
    lazy var refreshBtnImg : UIImage = {
        let box = UIView(bgColor:backGray)
        box.frame = CGRect(x: 0, y: 0, width: 140, height:50)
        let btn = UIButton(fontSize:16,textColor:.white,text:"点我重试")
        btn.backgroundColor = themeRed
        btn.frame = CGRect(x: 0, y: 10, width: 140, height:40)
        btn.makeCornerRadius(6)
        box.addSubview(btn)
        let img = UIImage.imageWith(view:box)!
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    ///page=1时刷新，page>1时加载更多
    func configWithModels(models:[Any]){
        didFinishRequest = true
        if page == 1 {
            modelArr.removeAll()
            modelArr.append(models)
            tableView.reloadData()
            tableView.es.stopPullToRefresh()
        }else{
            modelArr = modelArr + models
            tableView.reloadData()
            if models.count == 0 && modelArr.count != 0 {
                tableView.es.stopLoadingMore()
                tableView.es.noticeNoMoreData()
            }else{
                tableView.es.stopLoadingMore()
            }
        }
        page = page+1
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        var attributes: [NSAttributedStringKey: Any] = [:]
        attributes[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 14)
        attributes[NSAttributedStringKey.foregroundColor] = labelLightGray
        if LXAppDelegate.netStatus == .RealStatusNotReachable {
            return NSAttributedString.init(string:"似乎已断开与互联网的连接", attributes: attributes)
        }
        return NSAttributedString.init(string:"暂无数据", attributes: attributes)
    }
    
    func buttonImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> UIImage? {
        if LXAppDelegate.netStatus == .RealStatusNotReachable {
            return refreshBtnImg
        }
        return nil
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named:"通用空界面")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -70
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
    
    func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        //在需要的时候，由子类重写此方法
    }
    
    //┌────────────────────────────────────────────────────────────────┐
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //└────────────────────────────────────────────────────────────────┘
    
    /* 如何不显示sectionFooter？
     
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
     if #available(iOS 11.0, *) {
     //高于 iOS 11.0
     return 0
     } else {
     //低于 iOS 11.0
     return 0.01
     }
     }
     
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
     return nil
     }
     
     */
}









