//
//  WriteViewController.swift
//  MJianshu
//
//  Created by wjl on 15/12/15.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {
    var dismissViewControllerBlock: (() -> ()) = {}
    //需要修改背景色
    //
    ///
    @IBOutlet weak var navigationBar: UINavigationBar!{
        didSet{
            navigationBar.backgroundColor = UIColor.whiteColor()
        }
    }
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerBlock()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
    }
    
    
    
    
}
