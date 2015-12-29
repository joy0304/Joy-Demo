//
//  ContentTableController.swift
//  MJianshu
//
//  Created by wjl on 15/12/18.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import Kingfisher

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
                self.tableView.reloadData()
            }
        }
    }

}
// MARK: - TableView dataSource
extension ContentTableController {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard articleArray != nil else{
            return 0
        }
        return articleArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "contentCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ContentTableCell
        if cell == nil{
            cell = ContentTableCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        let imageURl = articleArray?[indexPath.row].previewImageStr
        cell?.previewImage.kf_setImageWithURL(NSURL(string: imageURl!)!,
            placeholderImage:  UIImage(named: "temp"),
            optionsInfo: [.Transition(ImageTransition.Fade(1))])
        cell?.model = articleArray?[indexPath.row]
        return cell!

    }
    
}
