//
//  FindViewController.swift
//  MJianshu
//
//  Created by wjl on 15/12/15.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import SnapKit

enum ThemeScrollViewType {
    case Article
    case Subject
}

class FindViewController: UIViewController, FindViewDelegate {
    var dataModel = FindViewModel()
    
    lazy var articleViewController: ThemeScrollController = ThemeScrollController(type: .Article)
    lazy var subjectViewController: ThemeScrollController = ThemeScrollController(type: .Subject)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false

        if let view = view as? FindView {
            navigationItem.titleView = view.segmentView
            
            self.addChildViewController(articleViewController)
            self.addChildViewController(subjectViewController)
            
            view.containerScrollView.addSubview((articleViewController.view)!)
            articleViewController.view?.snp_makeConstraints(closure: { (make) -> Void in
                make.top.left.equalTo(0)
                make.right.equalTo(view)
                make.bottom.equalTo(view).offset(-globalTabbarHeight)
            })
            
            view.containerScrollView.addSubview((subjectViewController.view)!)
            subjectViewController.view?.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo((articleViewController.view)!).offset(ScreenWidth)
                make.top.width.bottom.equalTo((articleViewController.view)!)
            })
        }
    }
    
    override func loadView() {
        view = FindView(delegate: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController!.navigationBar.translucent = false
    }
}

// MARK: - 实现FindViewDelegate
extension FindViewController {
    func segmentValueChanged(){
        if let localView = view as? FindView {
            localView.containerScrollView.setContentOffset(CGPointMake(ScreenWidth * CGFloat(localView.segmentView.selectedSegmentIndex), 0), animated: true)
        }
    }
    
    func segmentTitleArray() -> Array<String> {
        return dataModel.segmentItemTitles
    }
}
