//
//  BottomScrollView.swift
//  MJianshu
//
//  Created by 张星宇 on 15/12/29.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import SnapKit

class BottomScrollView: UIView {
    var bottomScroll = UIScrollView()
    var bottomContainerView = UIView()
    var rightConstraint: Constraint?
    
    init(){
        super.init(frame: CGRectNull)
        setBottomScroll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBottomScroll(){
        bottomScroll.pagingEnabled = true
        bottomScroll.showsHorizontalScrollIndicator = false
        bottomScroll.bounces = false
        
        addSubview(bottomScroll)
        bottomScroll.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        
        bottomContainerView.backgroundColor = bottomScroll.backgroundColor
        bottomScroll.addSubview(bottomContainerView)
        
        bottomContainerView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(bottomScroll)
            make.top.bottom.equalTo(self)
        }
    }
}

extension BottomScrollView {
    func addBottomViews(view: UIView) {
        bottomContainerView.addSubview(view)
        
        view.snp_makeConstraints(closure: { (make) -> Void in
            make.top.height.equalTo(bottomContainerView)
            make.width.equalTo(ScreenWidth)
            if bottomContainerView.subviews.count > 1 {
                let previousView = bottomScroll.subviews[0].subviews[bottomContainerView.subviews.count - 2]
                make.left.equalTo(previousView.snp_right)
            }
            else {
                make.left.equalTo(0)
            }
        })
        
        rightConstraint?.uninstall()
        bottomContainerView.snp_makeConstraints(closure: { (make) -> Void in
            rightConstraint = make.right.equalTo(view).constraint
        })
    }
}
