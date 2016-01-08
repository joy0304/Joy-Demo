//
//  UIInputView.swift
//  MJianshu
//
//  Created by wjl on 16/1/8.
//  Copyright © 2016年 Martin. All rights reserved.
//

import UIKit

typealias TextBlock  = (text:String,    textView:UITextView)->Void

class UIInputView: UIToolbar ,UITextViewDelegate{

    var leftButton: UIButton!
    var contentTextView: UITextView!
    var rightButton: UIButton!
    var placeHolderLabel: UILabel!
    var contentViewHeightConstraint: NSLayoutConstraint!
    var sendTextBlock :TextBlock!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews(){
        
        leftButton = UIButton()
        addSubview(leftButton)
        leftButton.setImage(UIImage(named: "icon_comment_emoji"), forState: .Normal)
        leftButton.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self).offset(8)
            make.bottom.equalTo(self).offset(-8)
            make.width.height.equalTo(30)
        }
        
        rightButton = UIButton()
        addSubview(rightButton)
        rightButton.setImage(UIImage(named: "icon_tabbar_input_send"), forState: .Normal)
        //        rightButton.addTarget(self, action: Selector("sendImage"), forControlEvents: .TouchUpInside)
        rightButton.snp_makeConstraints { (make) -> Void in
            make.trailing.bottom.equalTo(self).offset(-8)
            make.height.width.equalTo(30)
        }
        contentTextView = UITextView()
        addSubview(contentTextView)
        contentTextView.layer.cornerRadius = 4
        contentTextView.layer.borderWidth = 0.5
        contentTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        contentTextView.delegate = self
        contentTextView.returnKeyType = .Send
        contentTextView.enablesReturnKeyAutomatically = true
        contentTextView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self).offset(45)
            make.trailing.equalTo(self).offset(-45)
            make.top.equalTo(self).offset(8)
            make.bottom.equalTo(self).offset(-8)
            make.height.greaterThanOrEqualTo(30)
        }
        
        contentViewHeightConstraint = NSLayoutConstraint(
            item: contentTextView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: 30
        )
        contentViewHeightConstraint.priority = UILayoutPriorityDefaultHigh
        contentTextView.addConstraint(contentViewHeightConstraint)
        
        placeHolderLabel = UILabel()
        placeHolderLabel.text = "输入文字..."
        placeHolderLabel.textColor = UIColor.lightGrayColor()
        placeHolderLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        contentTextView.addSubview(placeHolderLabel)
        placeHolderLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(contentTextView)
        }
    }
    func sendMessage(textBlock:TextBlock){
        self.sendTextBlock = textBlock
    }
}

//MARK: textViewDelegate
extension UIInputView{
    func textViewDidBeginEditing(textView: UITextView) {
        placeHolderLabel.hidden = true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        placeHolderLabel.hidden = !textView.text.isEmpty
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text != "\n" {
            return true
        } else {
            self.sendTextBlock!(text: contentTextView.text, textView: contentTextView)
            textView.text = ""
            textViewDidChange(textView)
            return false
        }
    }
    //使输入内容的高度为30-100
    func textViewDidChange(textView: UITextView) {
        let textContentH = textView.contentSize.height
        let textHeight = textContentH>30 ? (textContentH<100 ? textContentH:100):30
        UIView.animateWithDuration(0.2) { () -> Void in
            self.contentViewHeightConstraint.constant = textHeight
            self.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
            let chatTableVC = self.responderViewController() as! ChatTableController
            chatTableVC.view.layoutIfNeeded()
            chatTableVC.chatTableView.scrollToBottom(animation: true)
        }
    }
    
}
extension UIView {
    
    func responderViewController() -> UIViewController {
        var responder: UIResponder! = nil
        for var next = self.superview; (next != nil); next = next!.superview {
            responder = next?.nextResponder()
            if (responder!.isKindOfClass(UIViewController)){
                return (responder as! UIViewController)
            }
        }
        return (responder as! UIViewController)
    }
}
extension UIScrollView {
    
    func scrollToBottom(animation animation:Bool) {
        let visibleBottomRect = CGRectMake(0, contentSize.height-bounds.size.height, 1, bounds.size.height)
        UIView.animateWithDuration(animation ? 0.2 : 0.01) { () -> Void in
            self.scrollRectToVisible(visibleBottomRect, animated: true)
        }
    }
}
