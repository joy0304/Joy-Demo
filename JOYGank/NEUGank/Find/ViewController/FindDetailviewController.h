//
//  FindDetailviewController.h
//  NEUGank
//
//  Created by 中软国际08 on 16/8/10.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class FindToolBar;
@interface FindDetailviewController : UIViewController

@property (nonatomic, strong)WKWebView *detailWebView;
@property (nonatomic, copy)NSString *detailURL;
@property (nonatomic, strong)UIProgressView *progressBar;
@property (nonatomic,strong) FindToolBar *toolBar;
@property (nonatomic, copy) NSString *descTitle;
- (instancetype)initWithDetailURL:(NSString *)detailURL descTitle:(NSString *)descTitle;

@end
