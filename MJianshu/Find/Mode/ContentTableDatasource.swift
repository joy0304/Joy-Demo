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
    var repository: Repository = ArticleRepository()
    var updateCompletionHnadler: () -> ()
    var page: Int
    
    init(page: Int,updateCompletionHnadler: () -> ()) {
        self.page = page
        self.updateCompletionHnadler = updateCompletionHnadler
        super.init()
        update()
    }
    
    func update() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 2)) {
            self.articleArray = self.repository.loadArticles(self.page)
            dispatch_async(dispatch_get_main_queue()) {
                self.updateCompletionHnadler()
            }
        }
    }
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