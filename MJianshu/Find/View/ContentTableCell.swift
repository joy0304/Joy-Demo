//
//  ContentTableCell.swift
//  MJianshu
//
//  Created by wjl on 15/12/25.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import SnapKit
class ContentTableCell: UITableViewCell {
    
    var userLable: UILabel!
    var timeLabel: UILabel!
    var previewImage: UIImageView!
    var articleTitle: UILabel!
    var readLabel: UILabel!
    var readNumber: Int!
    var commentLabel: UILabel!
    var commentNumber: Int!
    var favorLabel: UILabel!
    var favorNumber : Int!
    // 数据需要更改
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "contentCell")
        
        setSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSubviews(){
        previewImage = UIImageView()
        addSubview(previewImage)
        previewImage.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(80)
            make.right.bottom.equalTo(self).offset(-15)
            make.top.equalTo(self).offset(15)
        }
        
        articleTitle = UILabel()
        articleTitle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        articleTitle.font = UIFont.systemFontOfSize(18)
        articleTitle.numberOfLines = 2
        addSubview(articleTitle)
        
        articleTitle?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(self)
            make.right.equalTo(previewImage.snp_left).offset(-10)
            make.left.equalTo(self).offset(10)
        })
        
        userLable = UILabel()
        userLable.font = UIFont.systemFontOfSize(12)
        userLable.textColor = UIColor.blueColor()
        userLable.sizeToFit()
        addSubview(userLable!)

        userLable?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(articleTitle.snp_top).offset(-8)
        })

        timeLabel = UILabel()
        setLabelAttribute(timeLabel)
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(userLable.snp_right).offset(3)
            make.bottom.equalTo(userLable)
        }
        
        readLabel = UILabel()
        readLabel.text = "阅读 " + String(readNumber)
        setLabelAttribute(readLabel)
        readLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(articleTitle.snp_bottom).offset(8)
            make.left.equalTo(self).offset(10)
        }
        
        commentLabel = UILabel()
        setLabelAttribute(commentLabel)
        commentLabel.text = "● 评论 " + String(commentNumber)
        commentLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(readLabel)
            make.left.equalTo(readLabel.snp_right).offset(3)
        }
 
        favorLabel = UILabel()
        setLabelAttribute(favorLabel)
        favorLabel.text = "● 喜欢 " + String(favorNumber)
        favorLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(commentLabel)
            make.left.equalTo(commentLabel.snp_right).offset(3)
        }
        
    }
    
    func setLabelAttribute(label: UILabel){
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.grayColor()
        label.sizeToFit()
        addSubview(label)
    }
    
}
