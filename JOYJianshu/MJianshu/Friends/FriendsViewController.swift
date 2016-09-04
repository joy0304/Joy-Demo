//
//  FriendsViewController.swift
//  MJianshu
//
//  Created by wjl on 15/12/15.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController,UITableViewDelegate{
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
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(globalNavigationBarHeight)
            make.left.right.bottom.equalTo(0)
        }
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
    }
}

extension FriendsViewController{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        if indexPath.section == 0{
            if indexPath.row == 0{
                let friendsDynamicVC = FriednsDynamicController()
                navigationController?.pushViewControllerWithTabbarHidden(friendsDynamicVC, animated: true)
            }
        }
        else{
            let jianMessageVC = JianMessageController()
            navigationController?.pushViewControllerWithTabbarHidden(jianMessageVC, animated: true)
        }
    }
    

}
