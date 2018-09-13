//
//  ExampleModel.swift
//  suzao
//
//  Created by lixiang on 2018/5/18.
//  Copyright © 2018年 17suzao. All rights reserved.
//

import UIKit

class ExampleModel:NSObject,Codable {
    /// ID
    var id : Int?
    /// 新闻标题
    var title : String?
    /// 新闻封面
    var cover : String?
    /// 发布时间
    var create_at : String?
    /// 浏览量
    var view_count : Int?
    /// 收藏量
    var like_count : Int?
    /// 作者
    var author : String?
}






