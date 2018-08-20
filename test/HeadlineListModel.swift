//
//  HeadlineListModel.swift
//  suzao
//
//  Created by lixiang on 2018/5/18.
//  Copyright © 2018年 17suzao. All rights reserved.
//

import UIKit

class HeadlineListModel:NSObject,Codable {
    /// ID
    var id : Int?
    /// 新闻标题
    var title : String?
    /// 新闻封面
    var cover : String?
    /// 新闻封面数组
    lazy var coverArr : [String] = {
        let arr = (cover ?? "").components(separatedBy:";")
        return arr
    }()
    /// 发布时间
    var create_at : String?
    /// 浏览量
    var view_count : Int?
    /// 收藏量
    var like_count : Int?
    /// 作者
    var author : String?
}

class NetworkHeadlineTool {
    
    //m=1&page=1&size=20
    class func requestHeadlineList(param:[String:Any],finishedCallback:@escaping (_ models:[HeadlineListModel])->()) {
        let uri = "news"
        NetworkTool.get(uri:uri, param:param) { (res) in
            if let res = res as? NSDictionary {
                let dic = res["pages"] as? NSDictionary
                let dataArr = dic?["items"] as? NSArray
                if let models = dataArr?.lx_modelArr([HeadlineListModel].self){
                    finishedCallback(models)
                    return
                }
            }
            finishedCallback([HeadlineListModel]())
        }
    }
}






