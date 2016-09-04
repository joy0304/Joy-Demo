//
//  JianMessageDataSourse.swift
//  MJianshu
//
//  Created by wjl on 16/1/8.
//  Copyright © 2016年 Martin. All rights reserved.
//

import UIKit

class JianMessageDataSourse: NSObject ,UITableViewDataSource {

    override init() {
        super.init()
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "JianMessageCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? JianMessageCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("JianMessageCell", owner: nil, options: nil).last as? JianMessageCell
        }
        cell?.configureForCell()
        return cell!
    }

}
