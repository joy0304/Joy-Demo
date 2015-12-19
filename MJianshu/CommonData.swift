//
//  CommonData.swift
//  MJianshu
//
//  Created by wjl on 15/12/15.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

 /// Some Constant Value
public let ScreenWidth = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight = UIScreen.mainScreen().bounds.size.height
public let MainBounds = UIScreen.mainScreen().bounds
public let globalTabbarHeight = 49
public let globalNavigationBarHeight = 64
public let globalSizeWithoutNavbarOrTabbar = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - CGFloat(globalTabbarHeight + globalNavigationBarHeight))
public let statusBar = 20
