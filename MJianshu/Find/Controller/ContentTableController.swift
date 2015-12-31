//
//  ContentTableController.swift
//  MJianshu
//
//  Created by wjl on 15/12/18.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import Kingfisher
import MJRefresh
class ContentTableController: UIViewController, UITableViewDelegate {
    var tableView = UITableView()
    var page: Int?
    var dataSource: ContentTableDatasource? {
        didSet {
            tableView.dataSource = dataSource
        }
    }
    var pageID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        setUpTableView()
    }
    
    func setUpTableView() {
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        // 下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: dataSource, refreshingAction: Selector("updateInfoList"))
        tableView.mj_header.beginRefreshing()
        // 上拉刷新
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: dataSource, refreshingAction: "loadMoreInfo")
        
    }

}
