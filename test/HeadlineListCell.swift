//
//  HeadlineListCell.swift
//  suzao
//
//  Created by lixiang on 2018/5/18.
//  Copyright © 2018年 17suzao. All rights reserved.
//

import UIKit
import SnapKit

class HeadlineListCell: UITableViewCell {
    
    private let titleLabel = UILabel(fontSize:17)
    private let authorLabel = UILabel(fontSize: 12,textColor:labelLightGray)
    private let line = UIView(bgColor:lineGray)
    
    class func cell(tableView:UITableView) -> HeadlineListCell {
        let reuseId = NSStringFromClass(self)
        var cell = tableView.dequeueReusableCell(withIdentifier:reuseId) as? HeadlineListCell
        if cell == nil {
            cell = HeadlineListCell(style:.default,reuseIdentifier:reuseId)
            cell!.createUI()
        }
        return cell!
    }
    
    private func createUI() {
        titleLabel.beAddInto(contentView).snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(12)
            m.left.equalToSuperview().offset(12)
            m.right.equalToSuperview().offset(-12)
        }
        
        authorLabel.beAddInto(contentView).snp.makeConstraints { (m) in
            m.bottom.equalToSuperview().offset(-12)
            m.left.equalToSuperview().offset(12)
        }
        
        line.beAddInto(contentView).snp.makeConstraints { (m) in
            m.left.right.bottom.equalToSuperview()
            m.height.equalTo(0.5)
        }
    }
    
    func config(model:HeadlineListModel) {
        titleLabel.text = model.title
        authorLabel.text = model.author
    }
    

}



