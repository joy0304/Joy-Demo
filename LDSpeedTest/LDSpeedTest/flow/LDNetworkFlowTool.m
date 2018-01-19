//
//  LDNetworkFlowTool.m
//  LDSpeedTest
//
//  Created by wangjiale on 2018/1/16.
//  Copyright © 2018年 Joy. All rights reserved.
//

#import "LDNetworkFlowTool.h"
#include <arpa/inet.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <net/if_dl.h>

@interface LDNetworkFlowTool()

@property (nonatomic, strong) NSTimer *collectingTimer;
@property (nonatomic, assign) int expectedTimes;
@property (nonatomic, assign) int currentTimes;
@property (nonatomic, assign) long long startFlowValue;
@property (nonatomic, assign) long long endFlowValue;
@property (nonatomic, assign) NSTimeInterval startTimeStamp;
@property (nonatomic, assign) NSTimeInterval endTimeStamp;
@property (nonatomic, strong) LDFlowBlock flowBlock;

@end

@implementation LDNetworkFlowTool

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)startWithTimes:(int)times flowBlock:(LDFlowBlock)flowBlock {
    if (times > 1) {
        self.expectedTimes = times;
    } else {
        self.expectedTimes = 2;
    }
    
    self.flowBlock = flowBlock;
    
    if (self.expectedTimes > 1) {
        [self startMonitor];
    }
}

- (void)startMonitor {
    self.collectingTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(startCollectData) userInfo:nil repeats:YES];
}

- (void)startCollectData {
    
    // 第一次，记录开始时间戳和此时的流量
    if (self.currentTimes == 0) {
        self.startTimeStamp = [[NSDate date] timeIntervalSince1970];
        long long value = [self getDeviceCurrentBytesCount];
        self.startFlowValue = value;
    }
    
    self.currentTimes = self.currentTimes + 1;
    
    // 达到最后一次，则记录停止时间戳和此时的流量
    if (self.currentTimes == self.expectedTimes) {
        self.endTimeStamp = [[NSDate date] timeIntervalSince1970];
        self.endFlowValue = [self getDeviceCurrentBytesCount];
        
        self.currentTimes = 0;
        [self stopCollectingData];
    }
}

- (void)stopCollectingData {
    [self.collectingTimer invalidate];
    self.collectingTimer = nil;
    
    float value = (self.endFlowValue - self.startFlowValue) / (self.endTimeStamp - self.startTimeStamp);
    float speed = value / 1024;
    self.flowBlock(speed);
}

#pragma mark - get
- (long long)getDeviceCurrentBytesCount {
    struct ifaddrs* addrs;
    const struct ifaddrs* cursor;

    long long currentBytesValue = 0;
    
    if (getifaddrs(&addrs) == 0) {
        cursor = addrs;
        while (cursor != NULL) {
            const struct if_data* ifa_data = (struct if_data*)cursor->ifa_data;
            if (ifa_data) {
                // total number of octets received
                int receivedData = ifa_data->ifi_ibytes;
                
                currentBytesValue += receivedData;
            }
            cursor = cursor->ifa_next;
        }
    }
    freeifaddrs(addrs);
    
    NSLog(@"BytesCount:%lld",currentBytesValue);

    return currentBytesValue;
}

@end
