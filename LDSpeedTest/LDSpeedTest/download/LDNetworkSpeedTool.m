//
//  LDNetworkSpeedTool.m
//  LDSpeedTest
//
//  Created by wangjiale on 2018/1/16.
//  Copyright © 2018年 Joy. All rights reserved.
//

#import "LDNetworkSpeedTool.h"

@interface LDNetworkSpeedTool() <NSURLSessionDownloadDelegate>

@property (nonatomic, assign) long long firstDownloadSize;
@property (nonatomic, assign) long long totalDownloadSize;
@property (nonatomic, assign) int totalDownTime;
@property (nonatomic, assign) NSTimeInterval startTimeStamp;
@property (nonatomic, assign) NSTimeInterval endTimeStamp;
@property (nonatomic, strong) LDSpeedBlock speedBlock;
@property (nonatomic, strong) NSURL *requestURL;

@end

@implementation LDNetworkSpeedTool

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)startWithURL:(NSURL*)url  speedblock:(LDSpeedBlock)speedBlock {
    self.requestURL = url;
    
    self.speedBlock = speedBlock;
    
    if (self.requestURL) {
        [self startMonitor];
    }
}

// 开始下载任务
- (void)startMonitor {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:[NSURLRequest requestWithURL:self.requestURL]];
    
    [task resume];
}

// 结束下载任务，开始计算网速值
- (void)endMonitor {
    float value = (self.totalDownloadSize - self.firstDownloadSize) / (self.endTimeStamp - self.startTimeStamp);
    float speed = value / 1024;
    self.speedBlock(speed);
}

#pragma mark - delegte
// 每次写入调用(会调用多次)
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    NSLog(@"value:%lld",totalBytesWritten);
    
    if (self.firstDownloadSize < 1) {
        self.firstDownloadSize = bytesWritten;
        // 开始计时：从第一次收到数据开始计时
        self.startTimeStamp = [[NSDate date] timeIntervalSince1970];
    }
    
    self.totalDownloadSize = totalBytesWritten;
}

// 下载完成调用
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    self.endTimeStamp = [[NSDate date] timeIntervalSince1970];
    
    // 删除下载好的文件
    [[NSFileManager defaultManager] removeItemAtURL:location error:nil];
}

// 任务完成调用
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        // 如果发生错误则计算失效
        self.totalDownloadSize = 0;
        self.firstDownloadSize = 0;
    } else {
        [self endMonitor];
    }
}

@end
