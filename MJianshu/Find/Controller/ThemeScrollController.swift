//
//  ThemeScrollController.swift
//  MJianshu
//
//  Created by wjl on 15/12/18.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import SnapKit

class ThemeScrollController: UIViewController, ThemeDelegate{
    
    var currentPage = 0
    var themeView: ThemeView!
    var type: ThemeScrollViewType?
    var contentViewControllers: Array<ContentTableController> = []
    lazy var themeDataModel: ThemeScrollViewModel = ThemeScrollViewModel()
    
    init(type: ThemeScrollViewType) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContentViewControllers()
    }
    
    override func loadView() {
        view = ThemeView(delegate: self)
    }
    
    func addContentViewControllers() {
        for i in (labelTitleArray()?.indices)! {
            let contentVC = ContentTableController()
            self.addChildViewController(contentVC)
            (view as! ThemeView).addBottomViews(contentVC.view)
        }
    }
}

// MARK: - 实现themeDelegate协议
extension ThemeScrollController {
    func labelTitleArray() -> [String]?{
        switch type {
        case .Some(.Article): return themeDataModel.articleViewTitles
        case .Some(.Subject): return themeDataModel.subjectViewTitles
        default: return []
        }
    }
    
    func labelClicked(recognizer: UITapGestureRecognizer){
        let titleLabel = recognizer.view
        let offSetX = CGFloat(titleLabel!.tag) * ScreenWidth
        let offset = CGPointMake(offSetX, 0)
        if let view = view as? ThemeView {
            view.bottomScroll.setContentOffset(offset, animated: true)
            currentPage = Int(view.bottomScroll.contentOffset.x / ScreenWidth)
        }
    }
}

// MARK: - 停止滑动时，更新顶部文字样式
extension ThemeScrollController {
    func updateTopScrollViewLabel() {
        if let view = view as? ThemeView {
            if let currentLabel = view.topScroll.subviews[0].subviews[currentPage] as? UILabel {
                currentLabel.transform = CGAffineTransformMakeScale(1,1)
                currentLabel.textColor = UIColor.blackColor()
            }
            currentPage = Int(view.bottomScroll.contentOffset.x / ScreenWidth)
            if let currentLabel = view.topScroll.subviews[0].subviews[currentPage] as? UILabel {
                currentLabel.transform = CGAffineTransformMakeScale(1.3,1.3)
                currentLabel.textColor = UIColor.purpleColor()
            }
        }
    }
}

// MARK - 实现UIScrollViewDelegate协议
extension ThemeScrollController{
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView){
        
        let index = Int(scrollView.contentOffset.x / ScreenWidth)
        if let view = view as? ThemeView {
            let titleLabel = view.topScroll.subviews[0].subviews[index] as! UILabel
            var offSetX = titleLabel.center.x - view.topScroll.frame.size.width * 0.5
            let offSetMaxX = view.topScroll.contentSize.width - view.topScroll.frame.size.width
            if offSetX < 0{
                offSetX = 0
            }
            else if (offSetX > offSetMaxX){
                offSetX = offSetMaxX
            }
            print(offSetX)
            view.topScroll.setContentOffset(CGPointMake(offSetX, 0), animated: true)
        }
        
        updateTopScrollViewLabel()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if let view = view as? ThemeView {
            currentPage = Int(view.bottomScroll.contentOffset.x / ScreenWidth)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updateTopScrollViewLabel()
    }
}



