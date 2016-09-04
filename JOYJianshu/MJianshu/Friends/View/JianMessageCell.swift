//
//  JianMessageCell.swift
//  MJianshu
//
//  Created by wjl on 16/1/8.
//  Copyright © 2016年 Martin. All rights reserved.
//

import UIKit

class JianMessageCell: UITableViewCell {

    @IBOutlet weak var previewImage: UIImageView!{
        didSet{
            previewImage.layer.cornerRadius = 30
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!{
        didSet{
            contentLabel.font = UIFont.systemFontOfSize(15)
            contentLabel.textColor = UIColor.lightGrayColor()
            contentLabel.sizeToFit()
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!{
        didSet{
            timeLabel.font = UIFont.systemFontOfSize(15)
            timeLabel.textColor = UIColor.lightGrayColor()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureForCell(){
        previewImage.image = UIImage(named: "img_avatar_message_default")
        userNameLabel.text = "我是干不死的小强"
        contentLabel.text = "新年快乐 迎接更棒的2016"
        timeLabel.text = "3天前"
    }
}
