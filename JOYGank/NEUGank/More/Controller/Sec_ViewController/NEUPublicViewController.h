//
//  NEUPublicViewController.h
//  NEUGank
//
//  Created by 周鑫城 on 8/6/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "NEUHTTPSessionManager.h"
#import "AFNetworking.h"

@interface NEUPublicViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

// 热门文章列表
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) NSString *urlString;

- (instancetype)initWithUrl:(NSString *)urlString;

@end
