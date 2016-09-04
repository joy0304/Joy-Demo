//
//  NEUDetailWebVC.h
//  NEUGank
//
//  Created by 周鑫城 on 8/10/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface NEUDetailWebVC : UIViewController

@property (nonatomic, strong)WKWebView *detailWebView;
@property (nonatomic, copy)NSString *detailURL;

- (instancetype)initWithUrl:(NSString *)urlString;

@end
