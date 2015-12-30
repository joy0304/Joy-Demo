//
//  ContentTableController.swift
//  MJianshu
//
//  Created by wjl on 15/12/18.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import Kingfisher

class ContentTableController: UIViewController, UITableViewDelegate {
    var tableView = UITableView()
    var repository: Repository = ArticleRepository()
    var articleArray: [Article]?
    var dataSource = ContentTableDatasource()
    var pageId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        setUpTableView()
        loadDatas(dataSource)
    }
    
    func loadDatas(dataSource: ContentTableDatasource){
        tableView.dataSource = dataSource
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            self.dataSource.articleArray = self.repository.loadArticles()
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    func setUpTableView() {
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }
}
