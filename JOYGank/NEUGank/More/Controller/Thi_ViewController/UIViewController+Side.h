//
//  UIViewController+Side.h
//  
//
//  Created by 周鑫城 on 7/3/16.
//
//


#import <UIKit/UIKit.h>


typedef enum{
    HYSideDirectionRight,
    HYSideDirectionLeft
} HYSideDirection;


@interface UIViewController (Side)

/**     侧滑出来的View   */
@property (weak,nonatomic) UIView * sideView;

/**    侧滑的方向,也决定了sideView是在mainPanelView 的左边还是右边    */
@property (assign,nonatomic) HYSideDirection HYSideDirectionType;
/**    滑出状态 */
@property (assign,nonatomic) BOOL  isSide;

/**     侧滑并设置侧滑动画时间      */
- (void)sideAnimateWithDuration:(NSTimeInterval)duration;

@end