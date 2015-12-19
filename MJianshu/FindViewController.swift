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
    var articleView: ThemeScrollController?
    var subjectView: ThemeScrollController?
    var naviBarHeight: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        setSegmentView()

    }
}
//设置导航栏的segmentView
extension FindViewController{
    
    func setSegmentView(){
        
        let items = ["文章","专题"]
        segmentView = UISegmentedControl(items: items)
        segmentView.setWidth(60, forSegmentAtIndex: 0)
        segmentView.setWidth(60, forSegmentAtIndex: 1)
        segmentView.selectedSegmentIndex = 1
        navigationItem.titleView = segmentView
        segmentView.selectedSegmentIndex = 0
        segmentView.addTarget(self, action: "segmentValueChanged", forControlEvents: UIControlEvents.ValueChanged)
        segmentView.selectedSegmentIndex = 0
    }
    func segmentValueChanged(){
        if segmentView.selectedSegmentIndex == 0{
            enterArticleView()
        }
        else{
            enterSubjectView()
        }
    }
    
    func enterArticleView(){
        
        if articleView == nil{
            articleView = ThemeScrollController()

            view.addSubview(articleView!)
            articleView?.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo((navigationController?.navigationBar.snp_bottom)!).offset(0)
                make.bottom.left.right.equalTo(view).offset(0)
            })
        }
        else{
            view.sendSubviewToBack(subjectView!)
            view.bringSubviewToFront(articleView!)
        }
        
    }
    
    func enterSubjectView(){
        if subjectView == nil{
            subjectView = ThemeScrollController()
            view.addSubview(subjectView!)
            subjectView?.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo((navigationController?.navigationBar.snp_bottom)!).offset(0)
                make.bottom.left.right.equalTo(view).offset(0)
            })
        }
        else{
            view.sendSubviewToBack(articleView!)
            view.bringSubviewToFront(subjectView!)
        }
    }
}
