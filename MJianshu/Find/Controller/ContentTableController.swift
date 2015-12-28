//
//  ContentTableController.swift
//  MJianshu
//
//  Created by wjl on 15/12/18.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class ContentTableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView = UITableView()
    var repository: Repository = ArticleRepository()
    var articleArray: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        loadDatas()

    }
    
    func loadDatas(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            self.articleArray = self.repository.loadArticles()
            dispatch_async(dispatch_get_main_queue()) {
                print(self.articleArray)
                self.tableView.reloadData()
            }
        }
    }

}
// MARK: - TableView dataSource
extension ContentTableController {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "contentCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ContentTableCell
        if cell == nil{
            cell = ContentTableCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        cell?.model = articleArray?[indexPath.row]
        cell?.articleTitle.text = "打看精神科d额外企鹅王企鹅sdsa大师的撒的算"
        cell?.previewImage.image = UIImage(named: "temp")
        
        return cell!
    }
    
}
