//
//  UIViewController+Side.m
//  
//
//  Created by 周鑫城 on 7/3/16.
//
//

#import "UIViewController+Side.h"
#import <objc/runtime.h>
//导航条高度
const  CGFloat HYNavigationBarHeight = 64;

@implementation UIViewController (Side)

//最开始的view
static UIView * _mainView;

#pragma mark - 通过运行时动态添加属性

//定义关联的Key
static const char * sideViewKey = "sideView";

- (void)setSideView:(UIView *)sideView{
    
    [[UIApplication sharedApplication].keyWindow addSubview:sideView];
    
    objc_setAssociatedObject(self, sideViewKey, sideView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    _mainView = self.navigationController?self.navigationController.view:self.view;
    
}

- (UIView *)sideView{
    return  objc_getAssociatedObject(self, sideViewKey);
}


#pragma mark - 侧滑方向

static const char * sideDirectionTypeKey = "sideDirectionType";

- (HYSideDirection)HYSideDirectionType{
    return  [objc_getAssociatedObject(self, sideDirectionTypeKey) intValue];
}

- (void)setHYSideDirectionType:(HYSideDirection)HYSideDirectionType{
    objc_setAssociatedObject(self, sideDirectionTypeKey, @(HYSideDirectionType), OBJC_ASSOCIATION_ASSIGN);
    CGRect rect = self.sideView.bounds;
    if (HYSideDirectionType == HYSideDirectionRight) {
        _sideWidth = rect.size.width;
        self.sideView.frame = CGRectMake(- rect.size.width, 0, rect.size.width, [UIScreen mainScreen].bounds.size.height);
    }else{
        _sideWidth = -rect.size.width;
        self.sideView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width , 0 , rect.size.width, rect.size.height);
    }
    
}

#pragma mark - 是否侧滑

static const char * isSideKey = "isSide";

- (BOOL)isSide{
    return  [objc_getAssociatedObject(self, isSideKey) integerValue];
}


- (void)setIsSide:(BOOL)isSide{
    
    objc_setAssociatedObject(self, isSideKey, @(isSide), OBJC_ASSOCIATION_ASSIGN);
}


//侧滑出来的宽度
static CGFloat _sideWidth;

- (void)sideAnimateWithDuration:(NSTimeInterval)duration{
    
    if (self.isSide) {
        NSLog(@"是否被滑出");
        self.isSide = NO;
        [self hideSideViewWithDuration:(NSTimeInterval)duration];
        return;
    }
    self.isSide = YES;
    [UIView animateWithDuration:duration animations:^{
        _mainView.transform = CGAffineTransformMakeTranslation(_sideWidth, 0);;
        self.sideView.transform = CGAffineTransformMakeTranslation(_sideWidth, 0);
    }];
    
}

//侧滑时间
- (void)hideSideViewWithDuration:(NSTimeInterval)duration{
    
    [UIView animateWithDuration:duration animations:^{
        _mainView.transform = CGAffineTransformIdentity;
        self.sideView.transform = CGAffineTransformIdentity;
    }];
    
    
}



@end