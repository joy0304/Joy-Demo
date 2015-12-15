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
    var articleView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        
        let items = ["文章","专题"]
        segmentView = UISegmentedControl(items: items)
        segmentView.setWidth(60, forSegmentAtIndex: 0)
        segmentView.setWidth(60, forSegmentAtIndex: 1)
        segmentView.selectedSegmentIndex = 1
        navigationItem.titleView = segmentView
        segmentView.addTarget(self, action: "segmentValueChanged", forControlEvents: UIControlEvents.TouchUpInside)
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
            
        }
        
    }
    
    func enterSubjectView(){
        
    }
}