//
//  BottomScrollViewController.swift
//  MJianshu
//
//  Created by 张星宇 on 15/12/29.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class BottomScrollViewController: UIViewController, UIScrollViewDelegate {
    var reusableViewControllers: Array<ContentTableController> = []
    var visibleViewControllers: Array<ContentTableController> = []
    var currentPage: Int?
    var titleArrayLength: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = view as? BottomScrollView {
            view.bottomScroll.delegate = self
        }
        
        loadPage(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        view = BottomScrollView(pages: getTitleArrayLength())
    }
    
    func addContentViewControllers() {
        for i in 0..<getTitleArrayLength() {
            let contentVC = ContentTableController()
            self.addChildViewController(contentVC)
            (view as! BottomScrollView).addBottomViewAtIndex(i, view: contentVC.view)
        }
    }
}

// MARK: - ViewController重用
extension BottomScrollViewController {
    func loadPage(page: Int) {
        guard currentPage != page else { return }  //还在当前页面就不用加载了
        
        currentPage = page
        var pagesToLoad = [page - 1, page, page + 1]
        var vcsToEnqueue: Array<ContentTableController> = []
        
        for vc in visibleViewControllers {
            if (vc.pageId == nil || !pagesToLoad.contains(vc.pageId!)) {
                vcsToEnqueue.append(vc)  //用不到的vc就进队
            } else if (vc.pageId != nil) {
                pagesToLoad.removeObject(vc.pageId!)
            }
        }
        
        for vc in vcsToEnqueue {
            vc.view.removeFromSuperview()
            visibleViewControllers.removeObject(vc)
            enqueueReusableViewController(vc)
        }
        for page in pagesToLoad {
            addViewControllerForPage(page)
        }
    }
    
    func addViewControllerForPage(page: Int) {
        guard (0..<getTitleArrayLength()).contains(page) else { return }
        
        let vc = dequeueReusableViewController()
        vc.pageId = page
        
        (view as! BottomScrollView).addBottomViewAtIndex(page, view: vc.view)
        visibleViewControllers.append(vc)
    }
    
    func enqueueReusableViewController(viewController: ContentTableController) {
        reusableViewControllers.append(viewController)
    }
    
    func dequeueReusableViewController() -> ContentTableController {
        if reusableViewControllers.count > 0 {
            return reusableViewControllers.removeFirst()
        }
        else {
            let vc = ContentTableController()
            vc.willMoveToParentViewController(self)
            self.addChildViewController(vc)
            vc.didMoveToParentViewController(self)
            return vc
        }
    }
}

// MARK: - 需要调用parentViewController中的方法
extension BottomScrollViewController {
    /**
     通过parentViewController获取顶部scrollview有多少label
     这个方法经常被调用，所以在自己的类内部做一个缓存
     
     :returns: 顶部scrollview中label的数量
     */
    func getTitleArrayLength() -> Int {
        if titleArrayLength == nil,
            let themeScrollViewController = self.parentViewController as? ThemeScrollController{
                titleArrayLength = themeScrollViewController.getTitleArrayNumber()
        }
        return titleArrayLength!
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var page = lroundf(Float(scrollView.contentOffset.x / ScreenWidth))
        page = max(page, 0)
        page = min(page, getTitleArrayLength())
        loadPage(page)
    }
}