//
//  ViewController.swift
//  GCDReadWriteLock
//
//  Created by wjl on 16/2/25.
//  Copyright © 2016年 Martin. All rights reserved.
//

import UIKit


import UIKit

class ViewController: UIViewController {
    
    var wrt: dispatch_semaphore_t!
    var mutex: dispatch_semaphore_t!
    var readCount: Int = 0
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wrt = dispatch_semaphore_create(1)
        mutex = dispatch_semaphore_create(1)
        
        for _ in 0...20{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), { () -> Void in
                self.写()
            })
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), {() -> Void  in
                self.读()
            })
            
        }
        
    }
    
    func 读(){
        
        dispatch_semaphore_wait(mutex, DISPATCH_TIME_FOREVER)
        readCount = readCount + 1
        print(readCount)
        if readCount == 1{
            dispatch_semaphore_wait(wrt, DISPATCH_TIME_FOREVER)
        }
        
        dispatch_semaphore_signal(mutex)
        
        print("\(readCount)个人在读")
        sleep(1)
        print("读完一个人")
        
        dispatch_semaphore_wait(mutex, DISPATCH_TIME_FOREVER)
        readCount--
        if readCount == 0{
            dispatch_semaphore_signal(wrt)
            
        }
        dispatch_semaphore_signal(mutex)
        
    }
    
    func  写(){
        
        dispatch_semaphore_wait(wrt, DISPATCH_TIME_FOREVER)
        print("开始写")
        sleep(1)
        print("写完一波")
        
        dispatch_semaphore_signal(wrt)
    }
    
}



