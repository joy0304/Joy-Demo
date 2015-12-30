//
//  ThemeScrollController.swift
//  MJianshu
//
//  Created by wjl on 15/12/18.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import SnapKit

public let topScrollHeight: CGFloat = 40.0

class ThemeScrollController: UIViewController{
    let topScrollViewController: TopScrollViewController
    let bottomScrollViewController = BottomScrollViewController()
    
    init(type: ThemeScrollViewType) {
        topScrollViewController = TopScrollViewController(type: type)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTopScrollView()
        addBottomScrollView()
    }
    
    func addTopScrollView() {
        addChildViewController(topScrollViewController)
        view.addSubview(topScrollViewController.view)
        topScrollViewController.view.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(view)
            make.height.equalTo(topScrollHeight)
        }
    }
    
    func addBottomScrollView() {
        addChildViewController(bottomScrollViewController)
        view.addSubview(bottomScrollViewController.view)
        bottomScrollViewController.view.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(topScrollViewController.view.snp_bottom)
        }
    }
}

// MARK: - 接收BottomScrollViewController事件
extension ThemeScrollController {
    /**
     从TopScrollViewController那里获取数组长度，方便自己设置scrollview的宽度
     
     :returns: 数组长度
     */
    func getTitleArrayNumber() -> Int {
        guard topScrollViewController.labelTitleArray() != nil else { return 0 }
        
        return topScrollViewController.labelTitleArray()!.count
    }
}

// MARK: - 接收TopScrollViewController事件
extension ThemeScrollController {
    /**
     处理TopScrollViewController的label被点击的事件
     
     :param: recognizer 触摸手势识别器
     */
    func labelClicked(recognizer: UITapGestureRecognizer){
        let targetPage = recognizer.view!.tag
        let previousPage = recognizer.view!.tag - 1
        updateTopScrollViewLabel(targetPage)  // 更新label颜色
        
        if let buttomScrollView = bottomScrollViewController.view as? BottomScrollView {

            let previousOffSetX = CGFloat(previousPage) * ScreenWidth
            buttomScrollView.bottomScroll.setContentOffset(CGPointMake(previousOffSetX, 0), animated: false)
            
            let offSetX = CGFloat(recognizer.view!.tag) * ScreenWidth
            buttomScrollView.bottomScroll.setContentOffset(CGPointMake(offSetX, 0), animated: true)
        }
    }
}

// MARK: - 停止滑动时，更新顶部文字样式
extension ThemeScrollController {
    func updateTopScrollViewLabel(index: Int) {
        topScrollViewController.updateLabelsWithPurpleIndex(index)
    }
}

// MARK - 实现UIScrollViewDelegate协议
extension ThemeScrollController{    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x / ScreenWidth)
        updateTopScrollViewLabel(index)  // 更新label颜色
        
        if let view = topScrollViewController.view as? TopScrollView {
            let titleLabel = view.topScroll.subviews[0].subviews[index] as! UILabel
            var offSetX = titleLabel.center.x - view.topScroll.frame.size.width * 0.5
            let offSetMaxX = view.topScroll.contentSize.width - view.topScroll.frame.size.width
            if offSetX < 0 {
                offSetX = 0
            }
            else if (offSetX > offSetMaxX) {
                offSetX = offSetMaxX
            }
            view.topScroll.setContentOffset(CGPointMake(offSetX, 0), animated: true)
        }
    }
}



