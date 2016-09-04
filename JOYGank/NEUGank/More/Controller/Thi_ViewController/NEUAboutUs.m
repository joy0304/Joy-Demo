//
//  NEUAboutUs.m
//  NEUGank
//
//  Created by 周鑫城 on 8/7/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUAboutUs.h"
#import "MBProgressHUD.h"

@implementation NEUAboutUs

- (instancetype)initWithAboutUSString:(NSString *)aboutUs {
    self = [super init];
    if (self) {
        self.aboutUsURL = aboutUs;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.detailWebView];
    [self.detailWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
    }];
}

#pragma  mark -- setter and getter 

- (WKWebView *)detailWebView {
    if (!_detailWebView) {
        _detailWebView = [[WKWebView alloc] init];
        _HUD = [MBProgressHUD showHUDAddedTo:_detailWebView animated:YES];
        [_HUD hideAnimated:YES afterDelay:2.0];
        [_detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.aboutUsURL]]];
    }
    return _detailWebView;
}

@end
