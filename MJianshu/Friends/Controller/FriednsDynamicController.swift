//
//  FriednsDynamicController.swift
//  MJianshu
//
//  Created by wjl on 16/1/5.
//  Copyright © 2016年 Martin. All rights reserved.
//

import UIKit

class FriednsDynamicController: UIViewController{

    var tableView = UITableView()
    var dataSourse = FriendsDynamicDataSourse()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "简友圈"
        automaticallyAdjustsScrollViewInsets = false
        
        setUpTableView()
    }
    
    func setUpTableView(){
        tableView.dataSource = dataSourse
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(globalNavigationBarHeight)
            make.left.right.bottom.equalTo(0)
        }
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableFooterView = UIView()
    }
    
}
