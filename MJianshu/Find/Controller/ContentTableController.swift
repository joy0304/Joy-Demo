//
//  ContentTableController.swift
//  MJianshu
//
//  Created by wjl on 15/12/18.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class ContentTableController: UITableViewController {

    var re: Repository = ArticleRepository()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        let a: [Article] = re.loadArticles()
        for i in a{
            print(i)
            print(i.readNumber)
        }
    }

}
// MARK: - TableView dataSource
extension ContentTableController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "contentCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ContentTableCell
        if cell == nil{
            cell = ContentTableCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        cell?.articleTitle.text = "打看精神科d额外企鹅王企鹅sdsa大师的撒的算"
        cell?.userLable.text = "Martin"
        cell?.previewImage.image = UIImage(named: "temp")
        cell?.timeLabel.text = "12.23"
        return cell!
    }
    
}
