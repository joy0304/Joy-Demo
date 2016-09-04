//
//  NEUAboutUs.h
//  NEUGank
//
//  Created by 周鑫城 on 8/7/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"

@interface NEUAboutUs : UIViewController

@property (nonatomic, strong)WKWebView *detailWebView;
@property (nonatomic, strong)NSString *aboutUsURL;
@property (nonatomic, strong) MBProgressHUD *HUD;

- (instancetype)initWithAboutUSString:(NSString *)aboutUs;

@end
