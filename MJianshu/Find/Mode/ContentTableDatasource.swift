//
//  ContentTableDatasource.swift
//  MJianshu
//
//  Created by 张星宇 on 15/12/29.
//  Copyright © 2015年 Martin. All rights reserved.
//

import Foundation
import Kingfisher

class ContentTableDatasource: NSObject, UITableViewDataSource {
    var articleArray: [Article]? = nil
}

extension ContentTableDatasource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard articleArray != nil else{ return 0 }
        
        return articleArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "contentCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ContentTableCell
        if cell == nil{
            cell = ContentTableCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        let article = articleArray![indexPath.row]
        cell?.configureForCell(article)
        return cell!
    }
}