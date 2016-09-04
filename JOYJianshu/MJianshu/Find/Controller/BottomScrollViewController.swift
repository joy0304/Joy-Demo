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
    var dataSources: [Int: ContentTableDatasource] = [:]  // 键是页数，值是datasource对象
    var currentPage: Int = -1
    var titleArrayLength: Int? = nil
    var shouldLoadPage = true
    
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
}

// MARK: - ViewController重用
extension BottomScrollViewController {
    func loadPage(page: Int) {
        guard currentPage != page else { return }  //还在当前页面就不用加载了
        
        currentPage = page
        guard shouldLoadPage else { return }
        var pagesToLoad = [page - 1, page, page + 1]
        var vcsToEnqueue: Array<ContentTableController> = []
        
        for vc in visibleViewControllers {
            if (vc.pageID == nil || !pagesToLoad.contains(vc.pageID!)) {
                vcsToEnqueue.append(vc)  //用不到的vc就进队
            } else if (vc.pageID != nil) {
                pagesToLoad.removeObject(vc.pageID!)
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
    
    func loadAllPages(page: Int) {
        let pagesToLoad = [page - 1, page, page + 1]
        for vc in visibleViewControllers {
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
        vc.pageID = page
        bindDataSourceWithViewController(vc, page: page)
        
        (view as! BottomScrollView).addBottomViewAtIndex(page, view: vc.view)
        visibleViewControllers.append(vc)
    }
    
    /**
     从缓存中找，如果datasource已经存在就直接读取，否则新创建并加入缓存
     
     :param: viewController 视图控制器
     :param: page           视图控制器是第几页，根据页数去字典中找
     */
    func bindDataSourceWithViewController(viewController: ContentTableController, page: Int) {
        if dataSources[page] == nil {
            let dataSource = ContentTableDatasource(page: page) {
                viewController.tableView.reloadData()
                viewController.tableView.mj_header.endRefreshing()
                viewController.tableView.mj_footer.endRefreshing()
            }
            dataSources[page] = dataSource
        }
        
        viewController.dataSource = dataSources[page]
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

// MARK: - 和parentViewController有关的方法
extension BottomScrollViewController {
    /**
     通过parentViewController获取顶部scrollview有多少label
     这个方法经常被调用，所以在自己的类内部做一个缓存
     
     :returns: 顶部scrollview中label的数量
     */
    func getTitleArrayLength() -> Int {
        if titleArrayLength == nil,
            let themeScrollViewController = self.parentViewController as? ThemeScrollController {
                titleArrayLength = themeScrollViewController.getTitleArrayNumber()
        }
        return titleArrayLength!
    }
    
    func currentDisplayViewController() -> ContentTableController? {
        for vc in visibleViewControllers {
            if vc.pageID == currentPage { return vc }
        }
        return nil
    }
}

// MARK - 实现UIScrollViewDelegate协议
extension BottomScrollViewController{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if let parentVC = parentViewController as? ThemeScrollController {
            parentVC.scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if let parentVC = parentViewController as? ThemeScrollController {
            parentVC.scrollViewDidEndScrollingAnimation(scrollView)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var page = lroundf(Float(scrollView.contentOffset.x / ScreenWidth))
        page = max(page, 0)
        page = min(page, getTitleArrayLength())
        loadPage(page)
    }
}