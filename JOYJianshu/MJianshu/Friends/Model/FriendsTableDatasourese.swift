//
//  FriendsTableDatasourese.swift
//  MJianshu
//
//  Created by wjl on 16/1/2.
//  Copyright © 2016年 Martin. All rights reserved.
//

import UIKit

class FriendsTableDatasourese: NSObject, UITableViewDataSource{
    let friendsModel = FriendsViewModel()
    var friendsNotifyTitleArray = [String]()
    var messageTitleArray = [String]()
    var friendsNotifyIconArray = [String]()
    var messageIconArray = [String]()
    
    override init() {
        super.init()
        updateData()
    }
    
    func updateData(){
        friendsNotifyTitleArray = friendsModel.friendsNotifyTitleArray
        messageTitleArray = friendsModel.messageTitleArray
        friendsNotifyIconArray = friendsModel.friendsNotifyIconArray
        messageIconArray = friendsModel.messageIconArray
    }
}


extension FriendsTableDatasourese {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return friendsNotifyTitleArray.count
        }else{
            return messageTitleArray.count
        }
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard section == 1 else{
            return " "
        }
        return nil
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 0 else{
            return "我的消息"
        }
        return nil
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "friendsCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell=UITableViewCell(style: .Value1, reuseIdentifier: identifier)
            cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell!.selectionStyle = .None
        }
        if indexPath.section == 0{
            cell?.imageView?.image = UIImage(named: friendsNotifyIconArray[indexPath.row])
            cell?.textLabel?.text = friendsNotifyTitleArray[indexPath.row]
        }
        else{
            cell?.imageView?.image = UIImage(named: messageIconArray[indexPath.row])
            cell?.textLabel?.text = messageTitleArray[indexPath.row]
        }
        return cell!
    }
}