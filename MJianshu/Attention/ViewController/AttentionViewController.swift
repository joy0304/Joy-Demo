//
//  FollowViewController.swift
//  MJianshu
//
//  Created by wjl on 15/12/15.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit


class AttentionViewController: UIViewController {
    
    var addItem:UIBarButtonItem?
    var pushItem:UIBarButtonItem?

    var theTableView: AttentionTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 配置UI
        setupUI()
        
        // 配置TableView
        setupTableView()
        
        // 添加 切换类型menu
        let menuNavLable = UILabel()
        menuNavLable.textAlignment = .Center
        menuNavLable.frame = CGRectMake(0, 0, 200, 44)
        menuNavLable.text = theTableView.theAttentionType.rawValue
        navigationItem.titleView = menuNavLable
        menuNavLable.addTappGestureWithActionBlock { (tapGesture) -> () in
            print("change type")
        }
        
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
        // 添加关注
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
        theTableView = AttentionTableView(frame: MainBounds, style: .Plain)
        theTableView.tableFooterView = UIView()
        view.addSubview(theTableView)
        title = theTableView.theAttentionType.rawValue
    }
    
    // MARK: Button Action
    func addItemAction() {
        
    }
    
    func pushItemAction() {
        
    }
}

