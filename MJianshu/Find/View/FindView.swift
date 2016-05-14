//
//  FindView.swift
//  MJianshu
//
//  Created by 张星宇 on 15/12/19.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

@objc protocol FindViewDelegate {
    func segmentValueChanged()
    func segmentTitleArray() -> Array<String>
}

class FindView: UIView {
    let segmentItemWidth: CGFloat = 60
    
    weak var delegate: FindViewDelegate?
    var segmentView: UISegmentedControl!
    var containerScrollView: UIScrollView = UIScrollView()
    var articleViewController: ThemeScrollController?
    var subjectViewController: ThemeScrollController?
    
    init(delegate: FindViewDelegate) {
        super.init(frame: CGRectNull)
        self.delegate = delegate
        setContainerScrollView()
        setSegmentView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContainerScrollView() {
        addSubview(containerScrollView)
        containerScrollView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(self).offset(-globalTabbarHeight)
        }
    }
    
    func setSegmentView(){
        if let items = delegate?.segmentTitleArray() {
            segmentView = UISegmentedControl(items: items)
            segmentView.setWidth(segmentItemWidth, forSegmentAtIndex: 0)
            segmentView.setWidth(segmentItemWidth, forSegmentAtIndex: 1)
            
            segmentView.selectedSegmentIndex = 0
            segmentView.addTarget(self, action: #selector(FindViewDelegate.segmentValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        }
    }
    
    func segmentValueChanged() {
        delegate?.segmentValueChanged()
    }
    
    deinit{
        print("销毁")
    }
}
