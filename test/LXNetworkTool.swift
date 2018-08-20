//
//  NetworkTool.swift
//  testhandy
//
//  Created by lixiang on 2017/11/16.
//  Copyright © 2017年 lixiang. All rights reserved.
//

import UIKit
import Alamofire

var theBaseUrl : String?

class NetworkTool:NSObject {
    
    @objc class func getBaseHost() -> String {
        if theBaseUrl == nil {
            #if DEBUG
                let url = UserDefaults.standard.object(forKey:"baseUrl") as? String
                if url == nil {
//                    theBaseUrl = "http://192.168.3.50/" //测试内网
                    theBaseUrl = "https://xz3n966qfj.17suzao.com/" //测试外网
                }else {
                    theBaseUrl = url
                }
            #else
                theBaseUrl = "https://xz3n966qfj.17suzao.com/" //正式外网
            #endif
            printLog("当前服务器地址："+theBaseUrl!)
        }
        return theBaseUrl!
    }
    
    class func openLog() -> Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    class func post(uri:String,param:[String:Any]?=nil,finishedCallback:@escaping (_ result:Any?)->()) {
        self.get_or_post(method:HTTPMethod.post, uri:uri, param:param) { (res) in finishedCallback(res)}
    }
    
    class func get(uri:String,param:[String:Any]?=nil,finishedCallback:@escaping (_ result:Any?)->()) {
        self.get_or_post(method:HTTPMethod.get, uri:uri, param:param) { (res) in finishedCallback(res)}
    }
    
    ///带缓存
    class func requestWithCache(isPost:Bool,uri:String,staticParam:[String:Any]?=nil,
                                dynamicParam:[String:Any]?=nil,cache:@escaping (_ result:Any?)->(),
                                callback:@escaping(_ result:Any?)->()) {
        
        let UserDefaultsStandard = UserDefaults.standard
        let cache_key = cacheKey(uri:uri,staticParam:staticParam)
        if let cacheAny = UserDefaultsStandard.object(forKey:cache_key) {
            cache(cacheAny)
        }
        var fullParam = staticParam ?? [String:Any]()
        if let dynamicParam = dynamicParam {
            for (key, value) in dynamicParam {
                fullParam[key] = value
            }
        }
        self.get_or_post(method:(isPost ? HTTPMethod.post : HTTPMethod.get), uri:uri, param:fullParam) { (res) in
            if let res = res {
                callback(res)
                UserDefaultsStandard.set(res, forKey:cache_key)
            }else{
                callback(nil)
            }
        }
    }
    
    class func cacheKey(uri:String,staticParam:[String:Any]? = nil) -> String {
        if let staticParam = staticParam {
            return uri + staticParam.lx_JSONString()!
        }
        return uri
    }
    
    private class func get_or_post(method:HTTPMethod,uri:String,param:[String:Any]?=nil,finishedCallback:@escaping (_ result:Any?)->()) {
        let fullUrl = self.getBaseHost() as String + uri
        let requestHeader:HTTPHeaders = ["X-Requested-With":"XMLHttpRequest","Client-Type":"2"]
        Alamofire.request(fullUrl, method:method, parameters:param, headers:requestHeader).responseJSON { (response) in
            guard let responseObject = response.result.value else {
                finishedCallback(nil)
                if let err = response.result.error {
                    printError(err:err,uri:uri,parameters:param ?? [String:Any]())
                    if (err as NSError).code == fail_because_noNetwork {
                        SVProgressHUD.showInfo(withStatus:"貌似网络已经断开")
                    }
                }
                return
            }
            
            let dic_responseObject = responseObject as? NSDictionary
            if dic_responseObject == nil {
                //如果不是字典
                finishedCallback(responseObject)
            }else{
                let removeNull_responseObject = JsonHelper.removeNull(dic_responseObject) as? NSDictionary ?? NSDictionary()
                let need_login = removeNull_responseObject["need_login"]
                if need_login != nil {
                    
                    finishedCallback(nil)
                }else{
                    printSuccess(responseObject:removeNull_responseObject,uri: uri, parameters: param ?? [String:Any]())
                    successCatchException(responseObject:removeNull_responseObject)
                    finishedCallback(removeNull_responseObject)
                }
            }
        }
    }
    
    class func successCatchException(responseObject:NSDictionary) {
        let status = responseObject.object(forKey:"status") as? Int
        if let status = status {
            if status != success_and_noException && status != fail_because_noNetwork {
                alertException(responseObject:responseObject)
            }
        }
    }
    
    class func alertException(responseObject:NSDictionary) {
        let errors = responseObject.object(forKey:"errors") as? NSArray ?? NSArray()
        if errors.count == 0 { return }
        var msg = ""
        var index = 0
        for str in errors {
            let errorStr = (str as? String) ?? ""
            msg.append(errorStr)
            if errors.count > 1 {
                if index < errors.count - 1 {
                    msg.append("\n")
                }
            }
            index = index + 1
        }
        if msg.count > 40 {
            let index = msg.index(msg.startIndex,offsetBy:40)
            let shortMsg = String(msg[..<index])
            AlertTool.showAlert(msg:shortMsg)
        }else {
            AlertTool.showAlert(msg:msg)
        }
    }
    
    @objc class func submit(uri:String,param:[String:Any],showTips:Bool=true,finishedCallback:@escaping (_ status:Int)->()) {
        let fullUrl = self.getBaseHost() as String + uri
        let requestHeader:HTTPHeaders = ["X-Requested-With":"XMLHttpRequest","Client-Type":"2"]
        Alamofire.request(fullUrl,method:HTTPMethod.post,parameters:param,headers:requestHeader).responseJSON { (response) in
            guard let responseObject = response.result.value else {
                if let err = response.result.error {
                    printError(err:err,uri:uri,parameters:param)
                    if (err as NSError).code == fail_because_noNetwork {
                        finishedCallback(fail_because_noNetwork)
                        AlertTool.showAlert(msg:"无法连接到网络")
                    }
                }
                return
            }
            let nsdic_responseObject = responseObject as? NSDictionary ?? ["status":-1] as NSDictionary
            let status = nsdic_responseObject.object(forKey:"status") as? Int ?? -1
            if showTips && status != success_and_noException && status != fail_because_noNetwork {
                alertException(responseObject:nsdic_responseObject)
            }
            printSuccess(responseObject:nsdic_responseObject,uri:uri,parameters:param)
            finishedCallback(status)
        }
    }
    
    private class func printError(err:Error,uri:String,parameters:[String:Any]?=nil) {
        let line_begin = "\n┌────────────────────────────────Alamofire failure────────────────────────────────┐"
        let url = "\n" + uri
        let par = "\n" + (parameters?.lx_JSONString() ?? "")
        let line_center = "\n ----------------------------------------------------------------------";
        let res = "\n" + err.localizedDescription
        let line_end  = "\n└────────────────────────────────Alamofire failure────────────────────────────────┘";
        printJson(log:line_begin+url+par+line_center+res+line_end, uri:uri)
    }
    
    class func printJson(log:String,uri:String){
        if NetworkTool.openLog() == true {
            printLog(log)
        }
    }
    
    private class func printSuccess(responseObject:NSDictionary,uri:String,parameters:[String:Any]?=nil) {
        let line_begin = "\n┌────────────────────────────────Alamofire success────────────────────────────────┐"
        let url = "\n" + uri
        let par = "\n" + (parameters?.lx_JSONString() ?? "")
        let line_center = "\n ----------------------------------------------------------------------";
        var res = "\n" + (responseObject.lx_JSONString() ?? "")
        let line_end  = "\n└────────────────────────────────Alamofire success────────────────────────────────┘";
        if res.count > log_response_maxLength {
            res = (res as NSString).substring(to:log_response_maxLength) + "\n此处省略\(res.count-log_response_maxLength)字"
        }
        printJson(log:line_begin+url+par+line_center+res+line_end, uri:uri)
    }


}








