//
//  FriendsDynamicDataSourse.swift
//  MJianshu
//
//  Created by wjl on 16/1/5.
//  Copyright © 2016年 Martin. All rights reserved.
//

import UIKit

class FriendsDynamicDataSourse: NSObject, UITableViewDataSource{
    
    var dynamicArray: [String] = ["他才华横溢能力出众，人生的蓝图早已规划，凭什么还要将就这样的你","","I Love Girl","2015中国控制与决策年会的见闻，综合分析了近年来中国在学术领域取得的突破性进展和国际影响，并着重阐述了在东北大学流程工业综合自动化国家重点实验室的参观经历和感受，对柴天佑院士带领实验室取得的研究成果给予了极高的评价和肯定。",""]
    
    override init() {
        super.init()
        
    }
}

extension FriendsDynamicDataSourse{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dynamicArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "lineCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? DynamicLineCell
        if cell == nil{
            cell = DynamicLineCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        cell!.previewImage.image = UIImage(named: "img_avatar_user_default_small")
        cell!.sourceUserLabel.text = "粉色的伞"
        cell?.eventLabel.text = "评论了你的《不曾错付的时光》"
        cell?.creatTimeLabel.text = "2016.02.10 12:09"
        cell?.contentLabel.text = dynamicArray[indexPath.row]
        if cell?.contentLabel.text == ""{
            cell?.cellType(true)
        }
        else{
            cell?.cellType(false)
        }
        return cell!
    }
}