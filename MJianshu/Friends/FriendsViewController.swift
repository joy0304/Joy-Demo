//
//  FriendsViewController.swift
//  MJianshu
//
//  Created by wjl on 15/12/15.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    var tableView = UITableView()
    var dataSourse = FriendsTableDatasourese()
    
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
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
    }
}

//extension FriendsViewController: UITableViewDelegate{
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    
//        if indexPath.section == 0{
//            
//        }
//    }
//    

//}
