//
//  UINavigationExtension.swift
//  MJianshu
//
//  Created by 张星宇 on 15/12/19.
//  Copyright © 2015年 Martin. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    /**
     调用系统的pushViewController方法，同时隐藏底部Tabbar
     
     :param: viewController 即将跳转的viewController
     :param: animated       是否开启动画
     */
    func pushViewControllerWithTabbarHidden(viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        pushViewController(viewController, animated: true)
    }
}

extension Array where Element : Equatable {
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}