//
//  DetailWebViewController.h
//  NEUGank
//
//  Created by Joy on 16/7/14.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class NEUToolBar, HomeModel;
@interface DetailWebViewController : UIViewController

@property (nonatomic, strong)WKWebView *detailWebView;
@property (nonatomic, copy)NSString *detailURL;
@property (nonatomic, strong)UIProgressView *progressBar;
@property (nonatomic,strong) NEUToolBar *toolBar;
@property (nonatomic, copy) NSString *descTitle;
@property (nonatomic, copy) NSString *pubTime;
@property (nonatomic, copy) NSString *pubName;

- (instancetype)initWithModel:(HomeModel *)model;

@end
