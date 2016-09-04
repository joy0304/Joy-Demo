//
//  NEUTableViewController.h
//  CustomTableView
//
//  Created by 周鑫城 on 7/18/16.
//  Copyright © 2016 ZXC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NEUBaseTableView.h"

@class NEUTableViewDataSource;

@protocol NEUTableViewControllerDelegate <NSObject>

@required
- (void)createDataSource;

@end

@interface NEUTableViewController : UIViewController<NEUTableViewDelegate, NEUTableViewControllerDelegate>

@property (nonatomic, strong) NEUBaseTableView *tableView;
@property (nonatomic, strong) NEUTableViewDataSource *dataSource;
@property (nonatomic, assign) UITableViewStyle tableViewStyle; // 用来创建 tableView

- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
