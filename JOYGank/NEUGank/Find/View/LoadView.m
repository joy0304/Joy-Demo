//
//  LoadView.m
//  NEUGank
//
//  Created by 中软国际08 on 16/7/14.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "LoadView.h"
#define COLOR_RGB(R,G,B) [UIColor colorWithRed:(R)/255 green:(G)/255 blue:(B)/255 alpha:1.0]
#define NEW_FEACURE_COUNT 3

@interface LoadView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIPageControl* pageView;
@property (nonatomic, strong)UIScrollView* scrollView;

@end

@implementation LoadView

+(void)showView {
    LoadView* lview = [[LoadView alloc] initWithFrame:CGRectMake(0, 0, NEUAPPWIDTH,NEUAPPHEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:lview];
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI {
    //加载UIScrollView
    [self addSubview:self.scrollView];
    
    [self scrollViewWithImage];
    
    [self addSubview:self.pageView];
    
}

-(UIScrollView*)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, NEUAPPWIDTH, NEUAPPHEIGHT)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator  = NO;
        
        _scrollView.pagingEnabled = YES;
        _scrollView.contentOffset = CGPointZero;
        
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.delegate = self;
        
    }
    return _scrollView;
}

- (UIPageControl*)pageView{
    if (!_pageView) {
        _pageView = [[UIPageControl alloc] initWithFrame:CGRectMake((NEUAPPWIDTH-300)/2, NEUAPPHEIGHT-44, 300, 30)];
        _pageView.backgroundColor = [UIColor clearColor];
        _pageView.numberOfPages = NEW_FEACURE_COUNT;
        //_pageView.currentPage = 0;
    }
    return _pageView;
}


-(void)scrollViewWithImage {
    
    self.scrollView.contentSize = CGSizeMake(NEUAPPWIDTH*NEW_FEACURE_COUNT, NEUAPPHEIGHT);
    
/*    NSString* imageName = [NSString stringWithFormat:@"S.H.I.E.L.D_0.jpg"];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NEUAPPWIDTH, NEUAPPHEIGHT)];
    imageView.image = [UIImage imageNamed:imageName];
    [self.scrollView addSubview:imageView];
    
    
    imageView.userInteractionEnabled = YES;
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake((NEUAPPWIDTH-300)/2, NEUAPPHEIGHT-44-30, 300, 30)];
    [btn setTitle:@"欢迎进入" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
   [imageView addSubview:btn];
 */
    for (int index = 0; index < NEW_FEACURE_COUNT; index++) {
        NSString* imageName = [NSString stringWithFormat:@"wel_%d.jpg",index+1];
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*NEUAPPWIDTH, 0, NEUAPPWIDTH, NEUAPPHEIGHT)];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
        if (index == (NEW_FEACURE_COUNT-1)) {
            imageView.userInteractionEnabled = YES;
            UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake((NEUAPPWIDTH-300)/2, NEUAPPHEIGHT-240, 300, 50)];
            //[btn setTitle:@"欢迎进入0.0" forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:btn];
        }
    }

}

-(void)btnClicked:(id)sender {
    //渐变的方式，先逐渐修改Alpha到 0
    [UIView animateWithDuration:2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0;
    }completion:^(BOOL f){
        //把自身从父窗体中移除
        [self removeFromSuperview];
    }];
}


#pragma mark - UIScrollViewDelegate methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = (int)(floor(scrollView.contentOffset.x - pageWidth/2)/pageWidth+1);
    self.pageView.currentPage = page;
}

@end

