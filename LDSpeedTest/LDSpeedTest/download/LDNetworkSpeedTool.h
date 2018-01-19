//
//  LDNetworkSpeedTool.h
//  LDSpeedTest
//
//  Created by wangjiale on 2018/1/16.
//  Copyright © 2018年 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LDSpeedBlock) (float speed);

@interface LDNetworkSpeedTool : NSObject

+ (instancetype)sharedInstance;

// 获取网速值，如果网速值为 0，则是获取失败
- (void)startWithURL:(NSURL*)url  speedblock:(LDSpeedBlock)speedBlock;

@end
