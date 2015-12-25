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
    
    var userButton: UIButton!
    var previewImage: UIImageView!
    var articleTitle: UILabel!
    var readNumLabel: UILabel!
    
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
            make.right.bottom.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(10)
        }
        
        articleTitle = UILabel()
        articleTitle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        articleTitle.numberOfLines = 0
        addSubview(articleTitle)
        
        articleTitle?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(self)
            make.right.equalTo(previewImage.snp_left).offset(-10)
            make.left.equalTo(self).offset(10)
        })
        
        userButton = UIButton()
        userButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        userButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        addSubview(userButton!)

        userButton?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(articleTitle.snp_top).offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(100)
        })

        readNumLabel = UILabel()
        addSubview(readNumLabel)

        readNumLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(articleTitle.snp_bottom).offset(10)
            make.left.equalTo(self).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(100)

        }
    }
    
}
