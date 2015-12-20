//
//  ThemeView.swift
//  MJianshu
//
//  Created by wjl on 15/12/19.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

protocol ThemeDelegate:UIScrollViewDelegate{
    func labelClicked(recognizer: UITapGestureRecognizer)
    func labelTitleArray() -> [String]
}

class ThemeView: UIView {

    var topScroll: UIScrollView!
    var bottomScroll: UIScrollView!
    var topScrollMaxX: CGFloat = 0.0
    let labelGapX: CGFloat = 15.0
    var topScrollHeight: CGFloat = 40.0
    let themeArr = ["热门","七日热门","三十日热门","最新","生活家","世间事","@IT","视频","七嘴八舌","电影","经典","连载","读图","市集"]
    
    weak var delegate: ThemeDelegate?
    
    init(delegate: ThemeDelegate){
        //空矩形和零矩形 待？
        super.init(frame: CGRectNull)
        self.delegate = delegate
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
            make.left.right.top.equalTo(self)
            make.height.equalTo(topScrollHeight)
        }
        //为其增加label，显示theme名字
        for idx in 0..<themeArr.count{

            let label = UILabel(frame: CGRectMake(topScrollMaxX + labelGapX, 10, 10, 10))
            label.text = themeArr[idx]
            label.font = UIFont(name: "HYQiHei", size: 19)
            label.textColor = (idx==0) ? UIColor.purpleColor() : UIColor.blackColor()
            label.sizeToFit()
            label.tag = idx
            label.userInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "labelClicked:"))
            topScroll.addSubview(label)
            // 记录顶部scroll的X坐标
            topScrollMaxX = label.frame.maxX + labelGapX
        }

        //重新计算topScroll contentSize
        topScroll.contentSize = CGSizeMake(topScrollMaxX, topScrollHeight)
    }


    func setBottomScroll(){

        bottomScroll = UIScrollView(frame: CGRectMake(0, topScrollHeight, ScreenWidth, ScreenHeight - topScrollHeight))
        bottomScroll.contentSize = CGSizeMake(ScreenWidth * 8, ScreenHeight - topScrollHeight)
        bottomScroll.pagingEnabled = true
        bottomScroll.clipsToBounds = true
        bottomScroll.bounces = false
        bottomScroll.delegate = delegate
        addSubview(bottomScroll)
        bottomScroll.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(self).offset(topScrollHeight)
        }

        for i in 0..<themeArr.count {
            let contentController = ContentTableController()
            let conWidth = ScreenWidth * CGFloat(i)
            contentController.view.frame = CGRectMake(conWidth, 0, ScreenWidth, ScreenHeight - topScrollHeight)
            bottomScroll.addSubview(contentController.view)
        }
    }
    
    func labelClicked(recognizer: UITapGestureRecognizer){
        delegate?.labelClicked(recognizer)
    }
//    
//    func labelTitleArray() -> [String]{
//        delegate?.labelTitleArray()
//    }
 
}
