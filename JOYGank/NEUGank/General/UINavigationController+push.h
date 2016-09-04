//
//  UINavigationController+push.h
//  NEUGank
//
//  Created by Joy on 16/7/14.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (push)

- (void)pushViewControllerWithTabbarHidden:(UIViewController *)viewController animated:(BOOL)animated;

@end
