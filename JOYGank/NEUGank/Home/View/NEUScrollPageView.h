//
//  NEUScrollPageView.h
//  NEUGank
//
//  Created by Joy on 16/6/28.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NEUScrollPageView : UIView

@property (nonatomic, strong) UIScrollView *scrollPageView;
@property (nonatomic, strong) UIView *ContainerView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat intervalTime;
@property (nonatomic, weak) id<UIScrollViewDelegate> delegate;
// 轮播图片数组
@property (nonatomic, strong) NSMutableArray *imageArray;

- (instancetype)initWithtFrame:(CGRect)frame ImageArr:(NSArray *)imageNameArray;
@end
