//
//  UINavigationController+push.m
//  NEUGank
//
//  Created by Joy on 16/7/14.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "UINavigationController+push.h"

@implementation UINavigationController (push)

- (void)pushViewControllerWithTabbarHidden:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [self pushViewController:viewController animated:YES];
}


@end
