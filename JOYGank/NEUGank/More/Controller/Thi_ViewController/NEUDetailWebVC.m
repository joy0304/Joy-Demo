
//
//  NEUDetailWebVC.m
//  NEUGank
//
//  Created by 周鑫城 on 8/10/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUDetailWebVC.h"
#import "MBProgressHUD.h"

@interface NEUDetailWebVC ()

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation NEUDetailWebVC

- (instancetype)initWithUrl:(NSString *)urlString {
    self = [super init];
    if (self) {
        self.detailURL = urlString;
    }
    return  self;
}

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.detailWebView];
    [self.detailWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
    }];
}


- (WKWebView *)detailWebView {
    if (!_detailWebView) {
        _detailWebView = [[WKWebView alloc] init];
        _HUD = [MBProgressHUD showHUDAddedTo:_detailWebView animated:YES];
        [_HUD hideAnimated:YES afterDelay:2.0];
        [_detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailURL]]];
    }
    return _detailWebView;
}

@end
