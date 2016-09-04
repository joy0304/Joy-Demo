
//
//  NEUTableViewController.m
//  CustomTableView
//
//  Created by 周鑫城 on 7/18/16.
//  Copyright © 2016 ZXC. All rights reserved.
//

#import "NEUTableViewController.h"
#import "NEUTableViewDataSource.h"

@implementation NEUTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        [self createDataSource];
//        [self createTableView];  这TM的大坑  自己挖坑 简直了 
    }
    return self;
}

// 这个方法实际上要被子类重写，生成对应类型的 data source
- (void)createDataSource {
    @throw [NSException exceptionWithName:@"Cann't use this method"
                                   reason:@"You can only call this method in subclass"
                                 userInfo:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}

- (void)createTableView {
    if (!self.tableView) {
        self.tableView = [[NEUBaseTableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
        self.tableView.NEUDelegate = self;
        self.tableView.NEUDataSource = self.dataSource;
//        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.view addSubview:self.tableView];
    }
}

@end
