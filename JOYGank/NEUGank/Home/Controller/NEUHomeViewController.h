//
//  NEUHomeViewController.h
//  NEUGank
//
//  Created by Joy on 16/6/28.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NEUScrollPageView;
@class NEUTopicScrollView;
@interface NEUHomeViewController : UIViewController

// 轮播图片相关属性
@property (nonatomic, strong) NEUScrollPageView *scrollPageView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSTimer *scrollTimer;
@property (nonatomic, assign) CGFloat scrollIntervalTime;
// 主题 Item 属性
@property (nonatomic, strong) NEUTopicScrollView *topicScrollView;
// 热门文章列表
@property (nonatomic, strong) UITableView *listTableView;

@end
