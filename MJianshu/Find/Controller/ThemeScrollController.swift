//
//  ThemeScrollController.swift
//  MJianshu
//
//  Created by wjl on 15/12/18.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import SnapKit
class ThemeScrollController:UIViewController,ThemeDelegate{

    var themeView: ThemeView!
    var themeDataModel: ThemeScrollViewModel! = {
        return ThemeScrollViewModel()
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeView = ThemeView(delegate: self)
        view.addSubview(themeView)
        themeView.snp_makeConstraints { (make) -> Void in
            make.top.bottom.left.right.equalTo(view).offset(0)
        }
        
    }
}
// MARK - 实现themeDelegate，与UIScrollViewDelegate
extension ThemeScrollController{
    func labelClicked(recognizer: UITapGestureRecognizer){
        
        let titleLabel = recognizer.view
        let offSetX = CGFloat(titleLabel!.tag) * ScreenWidth
        let offset = CGPointMake(offSetX, 0)
        themeView.bottomScroll.setContentOffset(offset, animated: true)
        
    }
    
    func labelTitleArray() -> [String]{
        return themeDataModel.articleViewTitles
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView){
        
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView){
        
        let index = Int(scrollView.contentOffset.x / ScreenWidth)
        
        let titleLabel = themeView.topScroll.subviews[index] as! UILabel
        var offSetX = titleLabel.center.x - themeView.topScroll.frame.size.width * 0.5
        let offSetMaxX = themeView.topScroll.contentSize.width - themeView.topScroll.frame.size.width
        if offSetX < 0{
            offSetX = 0
        }
        else if (offSetX > offSetMaxX){
            offSetX = offSetMaxX
        }
        themeView.topScroll.setContentOffset(CGPointMake(offSetX, 0), animated: true)
        
        for idx in 0..<14{
            if idx != index{
                let otherLabel = themeView.topScroll.subviews[idx] as! UILabel
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

