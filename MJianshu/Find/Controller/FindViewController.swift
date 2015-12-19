//
//  FindViewController.swift
//  MJianshu
//
//  Created by wjl on 15/12/15.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import SnapKit

class FindViewController: UIViewController, FindViewDelegate {
    var dataModel = FindViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false

        if let localView = view as? FindView {
            navigationItem.titleView = localView.segmentView
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
