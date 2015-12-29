//
//  BottomScrollViewController.swift
//  MJianshu
//
//  Created by 张星宇 on 15/12/29.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class BottomScrollViewController: UIViewController, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = view as? BottomScrollView {
            view.bottomScroll.delegate = self
        }
        
        addContentViewControllers()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        view = BottomScrollView()
    }
    
    func addContentViewControllers() {
        let themeScrollViewController = self.parentViewController as! ThemeScrollController
        for _ in 0..<themeScrollViewController.getTitleArrayNumber() {
            let contentVC = ContentTableController()
            self.addChildViewController(contentVC)
            (view as! BottomScrollView).addBottomViews(contentVC.view)
        }
    }
}

// MARK - 实现UIScrollViewDelegate协议
extension BottomScrollViewController{
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if let parentVC = parentViewController as? ThemeScrollController {
            parentVC.scrollViewWillBeginDragging(scrollView)
        }
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if let parentVC = parentViewController as? ThemeScrollController {
            parentVC.scrollViewDidEndDecelerating(scrollView)
        }
    }
}