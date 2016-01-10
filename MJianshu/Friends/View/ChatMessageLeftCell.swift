//
//  ChatMessageLeftCell.swift
//  MJianshu
//
//  Created by wjl on 16/1/8.
//  Copyright © 2016年 Martin. All rights reserved.
//

import UIKit

class ChatMessageLeftCell: UITableViewCell {
    var dateLabel: UILabel!
    var headImageView: UIButton!
    var nameLabel: UILabel!
    var contentButton: UIButton!
    var contentLabel: UILabel!
    var imageHeightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCellSelectionStyle.None
        setupSubViews()
        
    }
    func setupSubViews(){
        
        // 日期
        dateLabel = UILabel()
        contentView.addSubview(dateLabel)
        dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        dateLabel.textColor = UIColor.grayColor()
        dateLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(4)
            make.centerX.equalTo(contentView)
        }
        
        // 头像
        headImageView = UIButton()
        contentView.addSubview(headImageView)
        headImageView.layer.borderWidth = 4
        headImageView.layer.borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.5).CGColor
        headImageView.layer.cornerRadius = 25
        headImageView.clipsToBounds = true
        headImageView.setImage(UIImage(named: "previewTemp"), forState: UIControlState.Normal)
        headImageView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.leading.equalTo(10)
            make.top.equalTo(dateLabel).offset(20)
        }
        
        // 内容frame辅助
        contentLabel = UILabel()
        contentView.addSubview(contentLabel)
        contentLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.grayColor()
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(90)
            make.width.lessThanOrEqualTo(contentView).multipliedBy(0.6)
            make.top.equalTo(headImageView).offset(10)
            make.bottom.equalTo(-20).priorityLow()
        }
        
        // 内容视图
        contentButton = UIButton()
        contentView.insertSubview(contentButton, belowSubview: contentLabel)
        contentButton.clipsToBounds = true
        contentButton.setBackgroundImage(UIImage(named: "left_message_back"), forState: UIControlState.Normal)
        contentButton.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView).offset(70)
            make.trailing.equalTo(contentLabel.snp_trailing).offset(10)
            make.top.equalTo(headImageView)
            make.bottom.equalTo(contentLabel.snp_bottom).offset(10)
        }
        
        // temporary method
        imageHeightConstraint = NSLayoutConstraint(
            item: contentButton,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.LessThanOrEqual,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: 1000
        )
        imageHeightConstraint.priority = UILayoutPriorityRequired
        contentButton.addConstraint(imageHeightConstraint)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configUIWithModel(model: ChatModel){
        dateLabel.text = model.chatTime
        self.contentLabel.text = model.chatMessage
    }

}
