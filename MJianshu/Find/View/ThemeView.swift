//
//  ThemeView.swift
//  MJianshu
//
//  Created by wjl on 15/12/19.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import SnapKit

protocol ThemeDelegate:UIScrollViewDelegate{
    func labelClicked(recognizer: UITapGestureRecognizer)
    func labelTitleArray() -> [String]?
}

private let topScrollHeight: CGFloat = 40.0

class ThemeView: UIView {
    let labelGapX: CGFloat = 15.0
    var rightConstraint: Constraint?
    
    var themeArr: Array<String>!
    
    var topScroll: UIScrollView!
    var bottomScroll: UIScrollView!
    var topContainerView = UIView()
    var bottomContainerView = UIView()
    
    weak var delegate: ThemeDelegate?
    
    init(delegate: ThemeDelegate){
        super.init(frame: CGRectNull)
        
        self.delegate = delegate
        themeArr = labelTitleArray()
        
        setTopScroll()
        setBottomScroll()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTopScroll(){
        topScroll = UIScrollView()
        topScroll.showsHorizontalScrollIndicator = false
        topScroll.showsVerticalScrollIndicator = false
        topScroll.backgroundColor = UIColor.lightGrayColor()
        addSubview(topScroll)
        
        topScroll.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.height.equalTo(topScrollHeight)
            make.left.right.equalTo(self)
        }
        
        topContainerView.backgroundColor = topScroll.backgroundColor
        topScroll.addSubview(topContainerView)
        
        topContainerView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(topScroll)
            make.height.equalTo(topScrollHeight)
        }
        
        //为其增加label，显示theme名字
        for idx in 0..<themeArr.count{
            let label = UILabel()
            label.text = themeArr[idx]
            label.font = UIFont(name: "HYQiHei", size: 19)
            label.textColor = (idx==0) ? UIColor.purpleColor() : UIColor.blackColor()
            label.sizeToFit()
            label.tag = idx
            label.userInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "labelClicked:"))
            topContainerView.addSubview(label)
            
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(topContainerView)
                if idx > 0, let previousLabel = topScroll.subviews[0].subviews[idx - 1] as? UILabel {
                    make.left.equalTo(previousLabel.snp_right).offset(labelGapX * 2)
                } else {
                    make.left.equalTo(labelGapX)
                }
            })
            
            if idx == themeArr.count - 1 {
                topContainerView.snp_makeConstraints(closure: { (make) -> Void in
                    make.right.equalTo(label)
                })
            }
        }
    }


    func setBottomScroll(){
        bottomScroll = UIScrollView()
        bottomScroll.pagingEnabled = true
        bottomScroll.showsHorizontalScrollIndicator = false
        bottomScroll.bounces = false
        bottomScroll.delegate = delegate
        addSubview(bottomScroll)
        bottomScroll.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topScroll.snp_bottom)
            make.left.right.bottom.equalTo(self)
        }
        
        bottomContainerView.backgroundColor = bottomScroll.backgroundColor
        bottomScroll.addSubview(bottomContainerView)
        
        bottomContainerView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(bottomScroll)
            make.bottom.equalTo(self)
            make.top.equalTo(self).offset(topScrollHeight)
        }
    }
}

extension ThemeView {
    func addBottomViews(view: UIView) {
        bottomContainerView.addSubview(view)
        
        view.snp_makeConstraints(closure: { (make) -> Void in
            make.top.height.equalTo(bottomContainerView)
            make.width.equalTo(ScreenWidth)
            if bottomContainerView.subviews.count > 1 {
                let previousView = bottomScroll.subviews[0].subviews[bottomContainerView.subviews.count - 2] 
                make.left.equalTo(previousView.snp_right)
                print(view)
                print(previousView)
                print("")
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

// MARK: - ThemeDelegate协议
extension ThemeView {
    func labelClicked(recognizer: UITapGestureRecognizer){
        delegate?.labelClicked(recognizer)
    }
    
    func labelTitleArray() -> [String]?{
        return delegate?.labelTitleArray()
    }
}