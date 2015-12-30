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
    var dataSource: ContentTableDatasource? {
        didSet {
            tableView.dataSource = dataSource
        }
    }
    var pageID: Int?
    
    init(pageID: Int) {
        self.pageID = pageID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        setUpTableView()
        dataSource = ContentTableDatasource(pageID: pageID!){[weak self] in
            self?.tableView.reloadData()
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
