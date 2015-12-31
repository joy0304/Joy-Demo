//
//  TopScrollView.swift
//  MJianshu
//
//  Created by 张星宇 on 15/12/29.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

@objc protocol TopScrollViewDelegate{
    func labelClicked(recognizer: UITapGestureRecognizer)
    func labelTitleArray() -> [String]?
}

class TopScrollView: UIView {
    let labelGapX: CGFloat = 15.0
    var themeArr: Array<String>!
    
    var topScroll: UIScrollView!
    var topContainerView = UIView()
    
    weak var delegate: TopScrollViewDelegate?
    
    init(delegate: TopScrollViewDelegate){
        super.init(frame: CGRectNull)
        
        self.delegate = delegate
        themeArr = labelTitleArray()
        
        setTopScroll()
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
            label.transform = (idx==0) ? CGAffineTransformMakeScale(1.1,1.1) : CGAffineTransformMakeScale(1,1)
            label.sizeToFit()
            label.tag = idx
            label.userInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "labelClicked:"))
            topContainerView.addSubview(label)
            
            if themeArr.count == 3{
                topContainerView.snp_makeConstraints(closure: { (make) -> Void in
                    make.width.equalTo(ScreenWidth)
                })
                label.snp_makeConstraints(closure: { (make) -> Void in
                    make.height.equalTo(topContainerView)
                    if idx == 1 {
                        make.center.equalTo(topContainerView)
                    }
                    else if idx == 0{
                        make.left.equalTo(labelGapX * 3)
                    }
                    else{
                        make.right.equalTo(-(labelGapX * 2))
                    }
                })
            }
            else{
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
    }
}

// MARK: - TopScrollViewDelegate协议
extension TopScrollView {
    func labelClicked(recognizer: UITapGestureRecognizer){
        delegate?.labelClicked(recognizer)
    }
    
    func labelTitleArray() -> [String]?{
        return delegate?.labelTitleArray()
    }
}