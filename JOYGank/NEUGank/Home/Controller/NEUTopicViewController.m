//
//  NEUTopicViewController.m
//  NEUGank
//
//  Created by Joy on 16/7/25.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUTopicViewController.h"
#import "NEUListTableViewCell.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "NEUHomeDataManager.h"
#import "DetailWebViewController.h"

@interface NEUTopicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) NSMutableArray *resultArray;

@end

@implementation NEUTopicViewController

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.listTableView];
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(self)weakSelf = self;
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadListData];
    }];
    [self.listTableView.mj_header beginRefreshing];
    
    self.listTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

#pragma mark - load Data
- (void)loadListData {
    // 添加tableview的数据
    __weak __typeof(self)weakSelf = self;
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [NEUHomeDataManager getWithURL:@"http://gank.io/api/random/data/Android/20" parameters:nil modelClass:[HomeModel class] responseHandler:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (error) {
            _HUD.label.text = @"网络错误";
            [_HUD hideAnimated:YES afterDelay:2.0];
            [strongSelf.listTableView.mj_header endRefreshing];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                strongSelf.resultArray = responseObject;
                [strongSelf.listTableView.mj_header endRefreshing];
                [strongSelf.listTableView reloadData];
            });
        }
    }];
}

- (void)loadMoreData {
    __weak __typeof(self)weakSelf = self;
    
    [NEUHomeDataManager getWithURL:@"http://gank.io/api/random/data/Android/20" parameters:nil modelClass:[HomeModel class] responseHandler:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (error) {
            [strongSelf.listTableView.mj_footer endRefreshing];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [strongSelf.resultArray addObjectsFromArray:responseObject];
                [strongSelf.listTableView.mj_footer endRefreshing];
                [strongSelf.listTableView reloadData];
            });
        }
    }];
}

#pragma maek - UITableViewDelegate and DataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"listCell";
    NEUListTableViewCell *cell = [self.listTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NEUListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setCellDataWithModel:self.resultArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModel *model = self.resultArray[indexPath.row];
    DetailWebViewController *detailViewController = [[DetailWebViewController alloc] initWithModel:model];
    [self.navigationController pushViewControllerWithTabbarHidden:detailViewController animated:YES];
}
#pragma mark - Setter and Getter
- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] init];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.rowHeight = 110;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.showsHorizontalScrollIndicator = NO;
    }
    return _listTableView;
}
@end

