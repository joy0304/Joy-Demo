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

// 一种简化的multi-binding语法
func if_let<T> (values: T?..., fn:(params: [T]) -> ()) {
    for value in values {
        guard value != nil else { return }
    }
    let unwrappedArray = values.map{ $0! }
    fn(params: unwrappedArray)
}

typealias Task = (cancel : Bool) -> ()

func delay(time:NSTimeInterval, task:()->()) ->  Task? {
    
    func dispatch_later(block:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(time * Double(NSEC_PER_SEC))),
            dispatch_get_main_queue(),
            block)
    }
    
    var closure: dispatch_block_t? = task
    var result: Task?
    
    let delayedClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                dispatch_async(dispatch_get_main_queue(), internalClosure);
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(cancel: false)
        }
    }
    
    return result;
}

func cancel(task:Task?) {
    task?(cancel: true)
}