//
//  TopScrollViewController.swift
//  MJianshu
//
//  Created by 张星宇 on 15/12/29.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class TopScrollViewController: UIViewController, TopScrollViewDelegate {
    var type: ThemeScrollViewType?
    var lastClickedLabelTag: Int = 0  // 最后一次被选中的按钮的tag
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        view = TopScrollView(delegate: self)
    }
}

// MARK: - 实现TopScrollViewDelegate协议
extension TopScrollViewController {
    func labelTitleArray() -> [String]?{
        switch type {
        case .Some(.Article): return themeDataModel.articleViewTitles
        case .Some(.Subject): return themeDataModel.subjectViewTitles
        default: return []
        }
    }
    
    func labelClicked(recognizer: UITapGestureRecognizer){
        let controller = parentViewController as? ThemeScrollController
        controller?.labelClicked(recognizer)
        lastClickedLabelTag = recognizer.view!.tag
    }
}

// MARK: - 处理父ViewController请求
extension TopScrollViewController {
    func updateLabelsWithPurpleIndex(index: Int) {
        if let view = view as? TopScrollView {
            for label in (view.topScroll.subviews[0].subviews as? [UILabel])! {
                if label.tag == index {
                    label.transform = CGAffineTransformMakeScale(1.3,1.3)
                    label.textColor = UIColor.purpleColor()
                }
                else {
                    label.transform = CGAffineTransformMakeScale(1,1)
                    label.textColor = UIColor.blackColor()
                }
            }
        }
    }
}