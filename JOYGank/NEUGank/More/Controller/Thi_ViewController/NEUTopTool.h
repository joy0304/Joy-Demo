//
//  NEUTopTool.h
//  NEUGank
//
//  Created by 周鑫城 on 8/12/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NEUTopTool;

@protocol NEUReleaseDelegate <NSObject>

-(void)NEUTopToolOutLoginBtnClick;

@end

@interface NEUTopTool : UIView

@property (nonatomic, weak) id<NEUReleaseDelegate>delegate;
@property (nonatomic,strong) void(^releaseOnClick)();
- (void)setUpTopView;

@end
