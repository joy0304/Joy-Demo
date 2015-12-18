//
//  ThemeScrollController.swift
//  MJianshu
//
//  Created by wjl on 15/12/18.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class ThemeScrollController:UIView,UIScrollViewDelegate{

    
    var topScroll: UIScrollView!
    var bottomScroll: UIScrollView!
    var topScrollMaxX:CGFloat = 0
    var topScrollHeight: CGFloat = 40
    let themeArr = ["热门","七日热门","三十日热门","最新","生活家","世间事","@IT","视频","七嘴八舌","电影","经典","连载","读图","市集"]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置顶部ScrollView
        setTopScroll()
        setBottomScroll()
    }

    func setTopScroll(){
        
        topScroll = UIScrollView(frame: CGRectMake(0, 0, ScreenWidth, topScrollHeight))
        topScroll.showsHorizontalScrollIndicator = false
        topScroll.showsVerticalScrollIndicator = false
        topScroll.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(topScroll)
        //为其增加label，显示theme名字
        for idx in 0..<themeArr.count{
            let labelGapX: CGFloat = 20
            let label = UILabel(frame: CGRectMake(topScrollMaxX + labelGapX, 10, 10, 10))
            label.text = themeArr[idx]
            label.font = UIFont(name: "HYQiHei", size: 19)
            label.textColor = (idx==0) ? UIColor.purpleColor() : UIColor.blackColor()
            label.sizeToFit()
            label.tag = idx
            label.userInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "labelClick:"))
            topScroll.addSubview(label)
            // 记录顶部scroll的X坐标
            topScrollMaxX = label.frame.maxX + labelGapX
        }
        
        //重新计算topScroll contentSize
        topScroll.contentSize = CGSizeMake(topScrollMaxX, topScrollHeight)
    }
    
    //点击头部theme title，触发
    func labelClick(recognizer: UITapGestureRecognizer){
        
        let titleLabel = recognizer.view
        let offSetX = CGFloat((titleLabel?.tag)!) * ScreenWidth
        let offset = CGPointMake(offSetX, 0)
        bottomScroll.setContentOffset(offset, animated: true)
        
    }
    
    func setBottomScroll(){
        
        bottomScroll = UIScrollView(frame: CGRectMake(0, topScrollHeight, ScreenWidth, ScreenHeight - topScrollHeight))
        bottomScroll.contentSize = CGSizeMake(ScreenWidth * 8, ScreenHeight - topScrollHeight)
        bottomScroll.pagingEnabled = true
        bottomScroll.clipsToBounds = true
        bottomScroll.bounces = false
        bottomScroll.delegate = self
        self.addSubview(bottomScroll)
        
        for i in 0..<themeArr.count {
            let contentController = ContentTableController()
            let conWidth = ScreenWidth * CGFloat(i)
            contentController.view.frame = CGRectMake(conWidth, 0, ScreenWidth, ScreenHeight - topScrollHeight)
            bottomScroll.addSubview(contentController.view)
        }
    }
    
    
}
//UIScrollViewDelegate方法
extension ThemeScrollController{
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x / ScreenWidth)

        let titleLabel = self.topScroll.subviews[index] as! UILabel
        var offSetX = titleLabel.center.x - topScroll.frame.size.width * 0.5
        let offSetMaxX = topScroll.contentSize.width - topScroll.frame.size.width
        if offSetX < 0{
            offSetX = 0
        }
        else if (offSetX > offSetMaxX){
            offSetX = offSetMaxX
        }
        self.topScroll.setContentOffset(CGPointMake(offSetX, 0), animated: true)
        
        for idx in 0..<themeArr.count{
            if idx != index{
                let otherLabel = topScroll.subviews[idx] as! UILabel
                otherLabel.transform = CGAffineTransformMakeScale(1,1)
                otherLabel.textColor = UIColor.blackColor()
            }
            else{
                titleLabel.transform = CGAffineTransformMakeScale(1.3,1.3)
                titleLabel.textColor = UIColor.purpleColor()
            }
            
        }
        
    }
    
}



