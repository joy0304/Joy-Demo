//
//  ChatTableDataSourse.swift
//  MJianshu
//
//  Created by wjl on 16/1/10.
//  Copyright © 2016年 Martin. All rights reserved.
//

import UIKit


class ChatTableDataSourse: NSObject ,UITableViewDataSource{
    
    let leftCellId = "chatMessageLeftCell"
    let rightCellId = "chatMessageRightCell"
    var dataArray: [AnyObject]!
    
    override init() {
        super.init()
        
        dataArray = ChatModel.creatRandomArray(count: 5)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model = dataArray[indexPath.row] as! ChatModel
        if model.chatFrom == .Me {
            var cell = tableView.dequeueReusableCellWithIdentifier(rightCellId) as?ChatMessageRightCell
            if cell == nil{
                cell = ChatMessageRightCell(style: UITableViewCellStyle.Default, reuseIdentifier: leftCellId)
            }
            cell!.configUIWithModel(model)
            return cell!
        }
        else {
            var cell = tableView.dequeueReusableCellWithIdentifier(leftCellId) as? ChatMessageLeftCell
            if cell == nil{
                cell = ChatMessageLeftCell(style: UITableViewCellStyle.Default, reuseIdentifier: leftCellId)
            }
            cell!.configUIWithModel(model)
            return cell!
        }
    }
}
