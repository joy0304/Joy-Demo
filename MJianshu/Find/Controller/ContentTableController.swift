//
//  ContentTableController.swift
//  MJianshu
//
//  Created by wjl on 15/12/18.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class ContentTableController: UITableViewController {

    var repository: Repository = ArticleRepository()
    var articleArray: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        loadDatas()

    }
    
    func loadDatas(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { () -> Void in
            self.articleArray = self.repository.loadArticles()
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
    }

}
// MARK: - TableView dataSource
extension ContentTableController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "contentCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ContentTableCell
        if cell == nil{
            cell = ContentTableCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        cell?.model = articleArray?[indexPath.row]
        cell?.articleTitle.text = "打看精神科d额外企鹅王企鹅sdsa大师的撒的算"
        //cell?.userLable.text = "Martin"
        cell?.previewImage.image = UIImage(named: "temp")
        //cell?.timeLabel.text = "12.23"
        return cell!
    }
    
}
