//
//  LDNetworkFlowTool.h
//  LDSpeedTest
//
//  Created by wangjiale on 2018/1/16.
//  Copyright © 2018年 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LDFlowBlock) (float speed);

@interface LDNetworkFlowTool : NSObject

+ (instancetype)sharedInstance;

// 传入次数，次数代表读取几次网卡数据来求均值
- (void)startWithTimes:(int)times flowBlock:(LDFlowBlock)flowBlock;

@end
