//
//  FrequentlyUseHelper.swift
//  suzao
//
//  Created by lixiang on 2018/5/4.
//  Copyright © 2018年 17suzao. All rights reserved.
//

import Foundation
import UIKit

class AlertTool {
    class func showAlert(title:String?=nil,msg:String,controller:UIViewController?=nil) {
        let alertController = UIAlertController(title:title,message:msg,preferredStyle:.alert)
        let okAction = UIAlertAction(title:"确定", style: .default, handler:nil)
        alertController.addAction(okAction)
        if controller == nil {
            UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
        }else{
            controller!.present(alertController, animated: true, completion: nil)
        }
    }
    class func showFleetAlert(msg:String) {
        let alertController = UIAlertController(title:nil,message:msg,preferredStyle:.alert)
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            alertController.dismiss(animated:true, completion:nil)
        }
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension NSDictionary {
    func lx_model<T>(_ type: T.Type) -> T? where T : Decodable {
        let data = (try? JSONSerialization.data(withJSONObject:self, options:[]))!
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(type,from:data)
            return model
        } catch {
            printLog("\(T.self)"+"Codable解析失败")
            printLog(error)
            return nil
        }
    }

    convenience init? (lx_JSONString: String) {
        if let data = (try? JSONSerialization.jsonObject(with:lx_JSONString.data(using:String.Encoding.utf8, allowLossyConversion:true)!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary {
            self.init(dictionary: data)
        } else {
            self.init()
            return nil
        }
    }
    
    func lx_JSONString() -> String? {
        if !JSONSerialization.isValidJSONObject(self) {printLog("不能转化为JSONString");return nil}
        if let jsonData = try? JSONSerialization.data(withJSONObject:self,options:JSONSerialization.WritingOptions.prettyPrinted) {
            return String(data:jsonData,encoding:String.Encoding.utf8)
        }
        return nil
    }
}

extension NSArray {
    func lx_modelArr<T>(_ type: T.Type) -> T? where T : Decodable {
        let data = (try? JSONSerialization.data(withJSONObject:self, options:[]))!
        let decoder = JSONDecoder()
        do {
            let models = try decoder.decode(type,from:data)
            return models
        } catch {
            printLog("\(T.self)"+"Codable解析失败")
            printLog(error)
            return nil
        }
    }
    
    convenience init? (lx_JSONString: String) {
        if let data = (try? JSONSerialization.jsonObject(with:lx_JSONString.data(using: String.Encoding.utf8, allowLossyConversion: true)!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSArray {
            self.init(array:data)
        } else {
            self.init()
            return nil
        }
    }
    
    func lx_JSONString() -> String? {
        if !JSONSerialization.isValidJSONObject(self) {printLog("不能转化为JSONString");return nil}
        if let jsonData = try? JSONSerialization.data(withJSONObject:self,options:JSONSerialization.WritingOptions.prettyPrinted) {
            return String(data:jsonData,encoding:String.Encoding.utf8)
        }
        return nil
    }
}

extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}

extension Array {
    func lx_JSONString() -> String? {
        if !JSONSerialization.isValidJSONObject(self) {printLog("不能转化为JSONString");return nil}
        if let jsonData = try? JSONSerialization.data(withJSONObject:self,options:JSONSerialization.WritingOptions.prettyPrinted) {
            return String(data:jsonData,encoding:String.Encoding.utf8)
        }
        return nil
    }
}

extension Dictionary {
    func lx_JSONString() -> String? {
        if !JSONSerialization.isValidJSONObject(self) {printLog("不能转化为JSONString");return nil}
        if let jsonData = try? JSONSerialization.data(withJSONObject:self,options:JSONSerialization.WritingOptions.prettyPrinted) {
            return String(data:jsonData,encoding:String.Encoding.utf8)
        }
        return nil
    }
    func lx_model<T>(_ type: T.Type) -> T? where T : Decodable {
        let data = (try? JSONSerialization.data(withJSONObject:self, options:[]))!
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(type,from:data)
            return model
        } catch {
            printLog("\(T.self)"+"Codable解析失败")
            printLog(error)
            return nil
        }
    }
}

extension UILabel {
    
    convenience init(fontSize:CGFloat,textColor:UIColor=labelBlack,isMedium:Bool=false,text:String?=nil,numberOfLines:Int=1,align:NSTextAlignment=NSTextAlignment.left) {
        self.init()
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize:fontSize,weight:isMedium ? UIFont.Weight.medium : UIFont.Weight.regular)
        self.text = text
        self.numberOfLines = numberOfLines
        self.textAlignment = align
    }
    
    func setLineSpacingIfTextAndFont(lineSpacing:CGFloat,alignment:NSTextAlignment? = NSTextAlignment.left,breakMode:NSLineBreakMode? = .byCharWrapping){
        if let text = self.text {
            let paraStyle = NSMutableParagraphStyle()
            paraStyle.lineSpacing = lineSpacing
            paraStyle.lineBreakMode = breakMode ?? .byCharWrapping
            paraStyle.alignment = alignment ?? NSTextAlignment.left
            let dic = [NSAttributedStringKey.paragraphStyle:paraStyle,NSAttributedStringKey.font:self.font] as [NSAttributedStringKey:Any]
            let attributeStr = NSAttributedString(string:text,attributes: dic)
            self.attributedText = attributeStr
        }
    }
}

extension UITextField {
    
    convenience init(fontSize:CGFloat,textColor:UIColor?=labelBlack,plcholder:String?=nil) {
        self.init()
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize:fontSize)
        self.placeholder = plcholder
    }
    
    class func crTextField(bgColor:UIColor,cornerRadius:CGFloat?=nil,borderColor:UIColor?=nil,borderWidth:CGFloat?=nil) -> UITextField {
        let field = UITextField()
        field.backgroundColor = bgColor
        if let cornerRadius = cornerRadius {
            field.layer.cornerRadius = cornerRadius
            field.layer.masksToBounds = true
        }
        if let borderColor = borderColor {
            field.layer.borderColor = borderColor.cgColor
        }
        if let borderWidth = borderWidth {
            field.layer.borderWidth = borderWidth
        }
        return field
    }
    
    class func searchField(placeholder:String,frame:CGRect) -> UITextField {
        let field = UITextField.crTextField(bgColor:.white, cornerRadius:4,borderColor:nil, borderWidth:0)
        field.tintColor = themeRed
        field.leftView = UIImageView(image:UIImage(named:"搜索图标"))
        field.leftViewMode = .always
        field.placeholder = placeholder
        field.font = UIFont.systemFont(ofSize: 16)
        field.frame = frame
        field.returnKeyType = .search
        return field
    }
    
    class func loginField(plcholder:String,keyboardType:UIKeyboardType) -> UITextField {
        let field = UITextField()
        field.layer.cornerRadius = 4
        field.layer.masksToBounds = true
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 0.5
        field.textColor = labelBlack
        field.font = UIFont.systemFont(ofSize:16)
        field.placeholder = plcholder
        field.keyboardType = keyboardType
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width:8, height: 0))
        field.leftViewMode = .always
        return field
    }
}

extension UIButton {
    
    convenience init(fontSize:CGFloat,textColor:UIColor=labelBlack,isMedium:Bool=false,text:String?=nil,align:UIControlContentHorizontalAlignment=UIControlContentHorizontalAlignment.center) {
        self.init()
        self.setTitleColor(textColor, for:.normal)
        let font = UIFont.systemFont(ofSize:fontSize,weight:isMedium ? UIFont.Weight.medium : UIFont.Weight.regular)
        self.titleLabel?.font = font
        self.setTitle(text, for: .normal)
        self.contentHorizontalAlignment = align
    }
    
    class func cornerRadiusBtn(bgColor:UIColor,cornerRadius:CGFloat?=nil,borderColor:UIColor?=nil,borderWidth:CGFloat?=nil) -> UIButton {
        let btn = UIButton()
        btn.backgroundColor = bgColor
        if let cornerRadius = cornerRadius {
            btn.layer.cornerRadius = cornerRadius
            btn.layer.masksToBounds = true
        }
        if let borderColor = borderColor {
            btn.layer.borderColor = borderColor.cgColor
        }
        if let borderWidth = borderWidth {
            btn.layer.borderWidth = borderWidth
        }
        return btn
    }
    
    class func btnWithImageName(_ imageName:String,selectedImgName:String?=nil) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for:.normal)
        if let selectedImgName = selectedImgName {
            btn.setImage(UIImage(named:selectedImgName), for:.selected)
        }
        return btn
    }
    
    class func aspectFitBtn() -> UIButton {
        let btn = UIButton()
        btn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        return btn
    }
    
    class func aspectFillBtn() -> UIButton {
        let btn = UIButton()
        btn.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        return btn
    }

}

class MyLoadingView: UIView {
    
    let activityView = UIActivityIndicatorView(activityIndicatorStyle:.gray)
    
    convenience init(offset:CGFloat = 0,frame:CGRect,backgroundColor:UIColor = backGray) {
        self.init()
        self.frame = frame
        self.backgroundColor = backgroundColor
        activityView.startAnimating()
        self.addSubview(activityView)
        activityView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(offset)
        }
    }
    
    class func showForView(_ view: UIView,offset:CGFloat = 0,frame:CGRect? = nil,backgroundColor:UIColor = backGray) {
        let theFrame = frame ?? view.bounds
        view.addSubview(MyLoadingView(offset:offset,frame:theFrame,backgroundColor:backgroundColor))
    }
    
    class func hideForView(_ view:UIView?) {
        if view == nil {
            return
        }
        for subview in view!.subviews {
            if subview is MyLoadingView {
                subview.removeFromSuperview()
            }
        }
    }
}



class IntervalBtn: UIButton {
    
    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        super.sendAction(action,to:target,for:event)
        self.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.isUserInteractionEnabled = true
        }
    }
    
}

extension UISwitch {
    convenience init(onTintColor:UIColor) {
        self.init()
        self.onTintColor = onTintColor
    }
}

class HotspotBtn: UIButton {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var bounds: CGRect = self.bounds
        let widthDelta: CGFloat = max(44.0 - bounds.size.width, 0)
        let heightDelta: CGFloat = max(44.0 - bounds.size.height, 0)
        bounds = bounds.insetBy(dx: -0.5 * widthDelta, dy: -0.5 * heightDelta)
        return bounds.contains(point)
    }
    
}

extension String {
    func isPurnFloat() -> Bool {
        let scan: Scanner = Scanner(string:self)
        var val:Float = 0
        return scan.scanFloat(&val) && scan.isAtEnd
    }
    
    func isPurnInt() -> Bool {
        let scan: Scanner = Scanner(string:self)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    /// 截取字符串从开始到 index
    func substring(to index: Int) -> String {
        guard let end_Index = validEndIndex(original: index) else {
            return self;
        }
        
        return String(self[startIndex..<end_Index]);
    }
    /// 截取字符串从index到结束
    func substring(from index: Int) -> String {
        guard let start_index = validStartIndex(original: index)  else {
            return self
        }
        return String(self[start_index..<endIndex])
    }
    /// 切割字符串(区间范围 前闭后开)
    func sliceString(_ range:CountableRange<Int>)->String{
        
        guard
            let startIndex = validStartIndex(original: range.lowerBound),
            let endIndex   = validEndIndex(original: range.upperBound),
            startIndex <= endIndex
            else {
                return ""
        }
        
        return String(self[startIndex..<endIndex])
    }
    /// 切割字符串(区间范围 前闭后闭)
    func sliceString(_ range:CountableClosedRange<Int>)->String{
        
        guard
            let start_Index = validStartIndex(original: range.lowerBound),
            let end_Index   = validEndIndex(original: range.upperBound),
            startIndex <= endIndex
            else {
                return ""
        }
        if(endIndex.encodedOffset <= end_Index.encodedOffset){
            return String(self[start_Index..<endIndex])
        }
        return String(self[start_Index...end_Index])
        
    }
    /// 校验字符串位置 是否合理，并返回String.Index
    private func validIndex(original: Int) -> String.Index {
        
        switch original {
        case ...startIndex.encodedOffset : return startIndex
        case endIndex.encodedOffset...   : return endIndex
        default                          : return index(startIndex, offsetBy: original)
        }
    }
    /// 校验是否是合法的起始位置
    private func validStartIndex(original: Int) -> String.Index? {
        guard original <= endIndex.encodedOffset else { return nil }
        return validIndex(original:original)
    }
    /// 校验是否是合法的结束位置
    private func validEndIndex(original: Int) -> String.Index? {
        guard original >= startIndex.encodedOffset else { return nil }
        return validIndex(original:original)
    }
    
    func textWidth(fontSize:CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x:0,y:0,width:1000,height:fontSize))
        label.text = self
        label.font = UIFont.systemFont(ofSize:fontSize)
        label.sizeToFit()
        return label.frame.size.width
    }
    
    func textHeight(fontSize:CGFloat,maxWidth:CGFloat,maxHeight:CGFloat,lineSpace:CGFloat?=0) -> CGFloat {
        let label = UILabel(fontSize:fontSize,numberOfLines:0)
        label.frame = CGRect(x: 0, y: 0, width: maxWidth, height:0)
        label.text = self
        if let lineSpace = lineSpace {
            if lineSpace > 0 {label.setLineSpacingIfTextAndFont(lineSpacing:lineSpace)}
        }
        label.sizeToFit()
        return label.frame.size.height > maxHeight ? maxHeight : label.frame.size.height
    }
}

class GrayLine: UIView {
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.backgroundColor = lineGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc convenience init(y:CGFloat) {
        self.init(frame:CGRect(x:0.0, y:y, width:screenWidth, height:0.5))
        self.backgroundColor = lineGray
    }
    
    convenience init(x:CGFloat,y:CGFloat) {
        self.init(frame:CGRect(x:x, y:y, width:screenWidth-x, height:0.5))
        self.backgroundColor = lineGray
    }
    
    convenience init(x:CGFloat,y:CGFloat,width:CGFloat) {
        self.init(frame:CGRect(x:x, y:y, width:width, height:0.5))
        self.backgroundColor = lineGray
    }
}


enum Validate {
    case email(_: String)
    var isRight: Bool {
        var predicateStr:String!
        var currObject:String!
        switch self {
        case let .email(str):
            predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            currObject = str
            
            let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
            return predicate.evaluate(with: currObject)
        }
    }
}

extension UIImage {
    
    class func imageWith(view:UIView) -> UIImage? {
        let rate = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, (view.layer.contentsScale) * rate)
        if let aContext = UIGraphicsGetCurrentContext() {
            view.layer.render(in: aContext)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

class IntervalItem: UIBarButtonItem {
    
    private var intervalItemBtn : IntervalBtn?
    
    @objc var isSelected = false {
        didSet{
            intervalItemBtn?.isSelected = isSelected
        }
    }
    
    @objc convenience init(img:String,target:Any?,action:Selector,align:UIControlContentHorizontalAlignment=UIControlContentHorizontalAlignment.center){
        let btn = IntervalBtn()
        btn.addTarget(target, action:action, for: UIControlEvents.touchUpInside)
        btn.setImage(UIImage(named:img), for: UIControlState.normal)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.contentHorizontalAlignment = align
        self.init(customView:btn)
        self.intervalItemBtn = btn
    }
    
    @objc convenience init(normalImg:String,selectedImg:String,target:Any?,action:Selector,align:UIControlContentHorizontalAlignment=UIControlContentHorizontalAlignment.center){
        let btn = IntervalBtn()
        btn.addTarget(target, action:action, for: UIControlEvents.touchUpInside)
        btn.setImage(UIImage(named:normalImg), for: UIControlState.normal)
        btn.setImage(UIImage(named:selectedImg), for: UIControlState.selected)
        btn.adjustsImageWhenHighlighted = false
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.contentHorizontalAlignment = align
        self.init(customView:btn)
        self.intervalItemBtn = btn
    }
    
    @objc convenience init(title:String,target:Any?,action:Selector,font:CGFloat=16,textColor:UIColor? = .white){
        let btn = IntervalBtn()
        btn.addTarget(target, action:action, for: UIControlEvents.touchUpInside)
        btn.setTitle(title, for: UIControlState.normal)
        btn.setTitleColor(textColor, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize:font)
        self.init(customView:btn)
        btn.sizeToFit()
        self.intervalItemBtn = btn
    }
    
}




