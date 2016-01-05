//
//  DynamicLineCell.swift
//  MJianshu
//
//  Created by wjl on 16/1/5.
//  Copyright © 2016年 Martin. All rights reserved.
//

import UIKit
import SnapKit

class DynamicLineCell: UITableViewCell {
    var previewImage: UIImageView!
    var sourceUserLabel: UILabel!
    var creatTimeLabel: UILabel!
    var eventLabel: UILabel!
    var targetTitleLabel: UILabel!
    var containView: UIView!
    var contentLabel: UILabel!
    // 时间线
    var forepartTimeLineLabel: UILabel!
    var backpartTimeLineLabel: UILabel!
    
    var heightContraint: Constraint?
    
    let gapSpace: CGFloat = 25
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "lineCell")
        
        setSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubviews(){
        
        forepartTimeLineLabel = UILabel()
        forepartTimeLineLabel.backgroundColor = UIColor.lightGrayColor()
        contentView.addSubview(forepartTimeLineLabel)
        forepartTimeLineLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView).offset(gapSpace)
            make.height.equalTo(25)
            make.width.equalTo(1)
            make.top.equalTo(contentView)
        }
        
        previewImage = UIImageView()
        previewImage.layer.cornerRadius = 12
        contentView.addSubview(previewImage)
        previewImage.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(forepartTimeLineLabel.snp_bottom)
            make.centerX.equalTo(forepartTimeLineLabel.snp_centerX)
            make.width.height.equalTo(25)
        }
        
        sourceUserLabel = UILabel()
        sourceUserLabel.font = UIFont.systemFontOfSize(16)
        sourceUserLabel.sizeToFit()
        contentView.addSubview(sourceUserLabel)
        sourceUserLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(previewImage)
            make.left.equalTo(forepartTimeLineLabel.snp_right).offset(gapSpace)
            
        }
        
        creatTimeLabel = UILabel()
        creatTimeLabel.font = UIFont.systemFontOfSize(12)
        creatTimeLabel.textColor = UIColor.lightGrayColor()
        creatTimeLabel.sizeToFit()
        contentView.addSubview(creatTimeLabel)
        creatTimeLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(sourceUserLabel.snp_right).offset(5)
            make.centerY.equalTo(sourceUserLabel)
        }
        
        eventLabel = UILabel()
        eventLabel.font = UIFont.systemFontOfSize(16)
        eventLabel.sizeToFit()
        contentView.addSubview(eventLabel)
        eventLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(sourceUserLabel)
            make.top.equalTo(sourceUserLabel.snp_bottom).offset(10)
        }

        containView = UIView()
        containView.backgroundColor = UIColor.lightGrayColor()
        containView.layer.cornerRadius = 3
        contentView.addSubview(containView)
        containView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(eventLabel.snp_bottom).offset(10)
            make.left.equalTo(forepartTimeLineLabel.snp_right).offset(10)
            make.right.equalTo(contentView).offset(-10)

        }

        contentLabel = UILabel()
        contentLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        contentLabel.font = UIFont.systemFontOfSize(16)
        contentLabel.numberOfLines = 4
        contentLabel.sizeToFit()

        containView.addSubview(contentLabel)
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(containView).inset(UIEdgeInsetsMake(10, 10, 10, 10)).priorityHigh()
        }

        containView.snp_makeConstraints { (make) -> Void in
            self.heightContraint = make.height.equalTo(0).constraint
            make.bottom.equalTo(contentView.snp_bottom).offset(-10)
        }
        
        backpartTimeLineLabel = UILabel()
        backpartTimeLineLabel.backgroundColor = UIColor.lightGrayColor()
        contentView.addSubview(backpartTimeLineLabel)
        backpartTimeLineLabel.snp_makeConstraints { (make) -> Void in
            make.left.width.equalTo(forepartTimeLineLabel)
            make.top.equalTo(previewImage.snp_bottom)
            make.bottom.equalTo(contentView)

        }
        

        
    }
    func cellType(bool: Bool){

        if bool{
            self.heightContraint?.activate()
        }
        else{
            self.heightContraint?.deactivate()
        }
        
    }

}
