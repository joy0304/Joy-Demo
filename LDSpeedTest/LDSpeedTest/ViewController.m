//
//  ViewController.m
//  LDSpeedTest
//
//  Created by wangjiale on 2018/1/16.
//  Copyright © 2018年 Joy. All rights reserved.
//

#import "ViewController.h"
#import "LDNetworkSpeedTool.h"
#import "LDNetworkFlowTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 30M
    // http://down.sandai.net/thunder7/Thunder_dl_7.9.34.4908.exe
    
    //3M
    //http://dl.360safe.com/wifispeed/wifispeed.test
    
    [[LDNetworkSpeedTool sharedInstance] startWithURL:[NSURL URLWithString:@"http://down.sandai.net/thunder7/Thunder_dl_7.9.34.4908.exe"] speedblock:^(float speed) {
        NSLog(@"LDNetworkSpeedTool speed:%@",[NSString stringWithFormat:@"%f",speed]);
    }];

    [[LDNetworkFlowTool sharedInstance] startWithTimes:10 flowBlock:^(float speed) {
        NSLog(@"LDNetworkFlowTool speed:%@",[NSString stringWithFormat:@"%f",speed]);
    }];
}
@end
