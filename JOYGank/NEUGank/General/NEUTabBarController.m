//
//  NEUTabBarController.m
//  NEUGank
//
//  Created by Joy on 16/6/28.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUTabBarController.h"
#import "NEUHomeViewController.h"
#import "NEUFindViewController.h"
#import "NEUMoreViewController.h"
#import "NEUPleasureViewController.h"

@implementation NEUTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildViewController];
}

- (void)addAllChildViewController {
    
    NEUHomeViewController *homeViewController = [[NEUHomeViewController alloc] init];
    [self addChildViewController:homeViewController title:@"主页" normalImage:@"icon_tabbar_home" selectedImage:@"icon_tabbar_home_active"];
    
    NEUFindViewController *findViewController = [[NEUFindViewController alloc] init];
    [self addChildViewController:findViewController title:@"发现" normalImage:@"tabbar_find" selectedImage:@"tabbar_find_active"];
                                                 
    
    NEUPleasureViewController *pleasureViewController = [[NEUPleasureViewController alloc] init];
    [self addChildViewController:pleasureViewController title:@"娱乐" normalImage:@"yule" selectedImage:@"tabbar_yule_active"];
    
    NEUMoreViewController *moreViewController = [[NEUMoreViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:moreViewController title:@"我的" normalImage:@"icon_tabbar_me" selectedImage:@"icon_tabbar_me_active"];
}

- (void)addChildViewController:(UIViewController *)childViewController title:(NSString *)title normalImage:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    childViewController.tabBarItem.title = title;
    childViewController.tabBarItem.image = [UIImage imageNamed:image];
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    UINavigationController *childNavigationController = [[UINavigationController alloc] initWithRootViewController:childViewController];
    [self addChildViewController:childNavigationController];
}

@end
