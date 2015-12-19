//
//  FindViewController.swift
//  MJianshu
//
//  Created by wjl on 15/12/15.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import SnapKit

class FindViewController: UIViewController {

    var segmentView: UISegmentedControl!
    var containerScrollView: UIScrollView = UIScrollView()
    var articleViewController: ThemeScrollController?
    var subjectViewController: ThemeScrollController?
    var naviBarHeight: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        setContainerScrollView()
        setSegmentView()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController!.navigationBar.translucent = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("articleViewController frame : \(articleViewController?.view.frame)")
        print("subjectViewController frame : \(subjectViewController?.view.frame)")
    }
}
//设置导航栏的segmentView
extension FindViewController{
    func setContainerScrollView() {

        view.addSubview(containerScrollView)
        containerScrollView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(-globalTabbarHeight)
        }

        articleViewController = ThemeScrollController()
        containerScrollView.addSubview((articleViewController?.view)!)

        articleViewController?.view?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(view).offset(-globalTabbarHeight)
        })
        
        subjectViewController = ThemeScrollController()
        containerScrollView.addSubview((subjectViewController?.view)!)
        subjectViewController?.view?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(ScreenWidth)
            make.width.equalTo(ScreenWidth)
            make.bottom.equalTo(view).offset(-globalTabbarHeight)
            make.top.equalTo(view)
        })
    }
    
    func setSegmentView(){
        
        let items = ["文章","专题"]
        segmentView = UISegmentedControl(items: items)
        segmentView.setWidth(60, forSegmentAtIndex: 0)
        segmentView.setWidth(60, forSegmentAtIndex: 1)

        navigationItem.titleView = segmentView
        segmentView.selectedSegmentIndex = 0
        segmentView.addTarget(self, action: "segmentValueChanged", forControlEvents: UIControlEvents.ValueChanged)

    }
    func segmentValueChanged(){
        containerScrollView.setContentOffset(CGPointMake(ScreenWidth * CGFloat(segmentView.selectedSegmentIndex), 0), animated: true)
    }
}
