//
//  NEUScrollPageView.m
//  NEUGank
//
//  Created by Joy on 16/6/28.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUScrollPageView.h"
#import "Masonry.h"

static const CGFloat SCROLLPAGEHEIGHT = 220;

@interface NEUScrollPageView ()

@end

@implementation NEUScrollPageView

- (instancetype)initWithtFrame:(CGRect)frame ImageArr:(NSArray *)imageNameArray {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self addSubview:self.scrollPageView];
        [self.scrollPageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(SCROLLPAGEHEIGHT));
            make.top.equalTo(self).offset(0);
            make.left.right.equalTo(self).offset(0);
        }];
        
        self.ContainerView = [[UIView alloc] init];
        [self.scrollPageView addSubview:self.ContainerView];
        CGFloat ContainerWidth = NEUAPPWIDTH * (imageNameArray.count + 2) ;
        [self.ContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollPageView);
            make.height.equalTo(@(SCROLLPAGEHEIGHT));
            make.width.equalTo(@(ContainerWidth));
        }];
        
        self.imageArray = [[NSMutableArray alloc] initWithArray:imageNameArray];
        [self.imageArray insertObject:[imageNameArray lastObject] atIndex:0];
        [self.imageArray addObject:[imageNameArray firstObject]];
        NSInteger index = 0;
        while (index < self.imageArray.count) {
            [self addImageViewWithIndexPage:index];
            index++;
        }
        
        [self addSubview:self.pageControl];
        self.pageControl.numberOfPages = imageNameArray.count;
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.bottom.equalTo(self.scrollPageView).offset(0);
            make.height.equalTo(@30);
            make.width.equalTo(@(NEUAPPWIDTH));
        }];
        
    }
    return self;
}

#pragma mark - private methods
- (void)addImageViewWithIndexPage:(NSInteger)index {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageArray[index]]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.ContainerView addSubview:imageView];
    
    CGFloat leftPadding = index * NEUAPPWIDTH;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.height.equalTo(@(SCROLLPAGEHEIGHT));
        make.width.equalTo(@(NEUAPPWIDTH));
        make.left.equalTo(self.ContainerView).offset(leftPadding);
    }];
}

#pragma mark - Setter and Getter
- (UIScrollView *)scrollPageView {
    if (!_scrollPageView) {
        _scrollPageView = [[UIScrollView alloc] init];
        _scrollPageView.pagingEnabled = YES;
        _scrollPageView.showsVerticalScrollIndicator = NO;
        _scrollPageView.showsHorizontalScrollIndicator = NO;
        _scrollPageView.scrollsToTop = NO;
        _scrollPageView.bounces = NO;
    }
    return _scrollPageView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
    return _pageControl;
}

@end
