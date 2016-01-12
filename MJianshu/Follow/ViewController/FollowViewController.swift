//
//  FollowViewController.swift
//  MJianshu
//
//  Created by wjl on 15/12/15.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class FollowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var addItem:UIBarButtonItem?
    var pushItem:UIBarButtonItem?

    var theTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 配置UI
        setupUI()
        
        // 配置TableView
        setupTableView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     配置UI
     */
    func setupUI() {
        view.backgroundColor = UIColor.whiteColor()
        title = "全部关注"
        
        addItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addItemAction")
        addItem?.tintColor = ColorManger.mainColor()
        navigationItem.leftBarButtonItem = addItem
        // 暂时没有找到推送设置的小图标
        pushItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "pushItemAction")
        pushItem?.tintColor = UIColor.lightGrayColor()
        navigationItem.rightBarButtonItem = pushItem
    }
    
    /**
     配置TableView
     */
    func setupTableView() {
        theTableView = UITableView(frame: MainBounds, style: .Plain)
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.tableFooterView = UIView()
        view.addSubview(theTableView)
    }
    
    // MARK: Button Action
    func addItemAction() {
        
    }
    
    func pushItemAction() {
        
    }
}

extension FollowViewController {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
