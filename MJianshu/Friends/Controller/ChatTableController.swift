//
//  ChatTableController.swift
//  MJianshu
//
//  Created by wjl on 16/1/8.
//  Copyright © 2016年 Martin. All rights reserved.
//

import UIKit

class ChatTableController: UIViewController ,UITableViewDelegate{

    var chatTableView: UITableView!
    var inputBackView: UIInputView!
    var dataSourse = ChatTableDataSourse()
    var inputViewConstraint: NSLayoutConstraint? = nil

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardFrameChanged:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        chatTableView.dataSource = dataSourse
        chatTableView.delegate = self
        chatTableView.estimatedRowHeight = 100

    }
    
    func setupSubViews(){
        inputBackView = UIInputView()
        self.view.addSubview(inputBackView)
        inputViewConstraint = NSLayoutConstraint(
            item: inputBackView,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0
        )
        inputBackView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(self.view)
        }
        view.addConstraint(inputViewConstraint!)
        
        inputBackView.sendMessage { [weak self](text, textView) -> Void in
            self!.dataSourse.dataArray.append(ChatModel.creatMessageFromMeByText(text))
            self!.chatTableView.reloadData()
            self!.chatTableView.scrollToBottom(animation: true)
            
        }
        
        chatTableView = UITableView.init(frame: CGRectZero, style: .Plain)

        chatTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        chatTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.Interactive
        chatTableView.estimatedRowHeight = 60
        self.view.addSubview(chatTableView)
        chatTableView.snp_makeConstraints { (make) -> Void in
            make.top.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(inputBackView.snp_top)
        }
        chatTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
    }
    
    private func mainScreenSize() -> CGSize {
        return UIScreen.mainScreen().bounds.size
    }
    
}

extension ChatTableController{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.view.endEditing(true)
    }
    
    func keyboardFrameChanged(notification: NSNotification) {
        
        let dict = NSDictionary(dictionary: notification.userInfo!)
        let keyboardValue = dict.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let bottomDistance = mainScreenSize().height - keyboardValue.CGRectValue().origin.y
        let duration = Double(dict.objectForKey(UIKeyboardAnimationDurationUserInfoKey) as! NSNumber)
        
        UIView.animateWithDuration(duration, animations: {
            self.inputViewConstraint!.constant = -bottomDistance
            self.view.layoutIfNeeded()
            }, completion: {
                (value: Bool) in
                self.chatTableView.scrollToBottom(animation: true)
        })
    }

}

