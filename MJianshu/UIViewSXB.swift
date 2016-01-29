//
//  UIViewSXB.swift
//  MJianshu
//
//  Created by hy on 1/11/16.
//  Copyright © 2016 SXB. All rights reserved.
//

import Foundation

// MARK: - 简化UIView的操作
extension UIView {
    var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }

    var right: CGFloat{
        get{
            return self.x + self.width
        }
        set{
            var r = self.frame
            r.origin.x = newValue - frame.size.width
            self.frame = r
        }
    }

    var bottom: CGFloat{
        get{
            return self.y + self.height
        }
        set{
            var r = self.frame
            r.origin.y = newValue - frame.size.height
            self.frame = r
        }
    }
    
    
    var centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    var centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }
    
    
    var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.x = newValue.x
            self.y = newValue.y
        }
    }
    
    var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
    /**
     删除所以的子View
     */
    func sxbRemoveAllSubView() {
        for subView :AnyObject in self.subviews { subView.removeFromSuperview() }
    }
    
    
    // http://stackoverflow.com/a/34615469/3085137
    private static func firstAvailableUIViewController(fromResponder responder: UIResponder) -> UIViewController? {
        func traverseResponderChainForUIViewController(responder: UIResponder) -> UIViewController? {
            if let nextResponder = responder.nextResponder() {
                if let nextResp = nextResponder as? UIViewController {
                    return nextResp
                } else {
                    return traverseResponderChainForUIViewController(nextResponder)
                }
            }
            return nil
        }
        
        return traverseResponderChainForUIViewController(responder)
    }
    /**
     获取当前view的viewcontroller
     */
    func sxbViewController() -> UIViewController? {
        return UIView.firstAvailableUIViewController(fromResponder: self)
    }
}

// MARK: - Tap Block

// from https://github.com/Nero5023/ConvenienceAddTapGesture
typealias TapBlockType = [UIView: (UITapGestureRecognizer -> ())]
var tapBlockDic = TapBlockType()

extension UIView {
    func addTappGestureWithActionBlock(gestureAction:(UITapGestureRecognizer -> ())) {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("tapPerformBlock:"))
        tapBlockDic[self] = gestureAction
        self.userInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    func tapPerformBlock(tap: UITapGestureRecognizer) {
        if let tapView = tap.view {
            if let block = tapBlockDic[tapView] {
                block(tap)
            }
            
        }
    }
}

