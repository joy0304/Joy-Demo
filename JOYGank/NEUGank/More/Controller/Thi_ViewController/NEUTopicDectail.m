//
//  NEUTopicDectail.m
//  NEUGank
//
//  Created by 周鑫城 on 8/7/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUTopicDectail.h"
#import "MBProgressHUD.h"
#import "NEUHomeDataManager.h"
#import "MJRefreshHeader.h"
#import "MJRefreshHeader.h"
#import "MJRefreshFooter.h"
#import <objc/runtime.h>
#import "NEUListTableViewCell.h"
#import "DetailWebViewController.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"

@interface NEUTopicDectail ()
@property (nonatomic, strong) MBProgressHUD *HUD;
//@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) NSMutableArray *resultArray;
@end

@implementation NEUTopicDectail

- (instancetype)initWithTopicURL:(NSString *)topicURL {
    self = [super init];
    if (self) {
        self.topicURL = topicURL;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    // 添加文章列表
    [self.view addSubview:self.listTableView];
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.bottom.right.equalTo(self.view);
    }];

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prefersStatusBarHidden];
    __weak __typeof(self)weakSelf = self;
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadListData];
    }];
    [self.listTableView.mj_header beginRefreshing];
    
    self.listTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}

#pragma mark - load Data
- (void)loadListData {
    // 添加tableview的数据
    __weak __typeof(self)weakSelf = self;
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [NEUHomeDataManager getWithURL:self.topicURL parameters:nil modelClass:[HomeModel class] responseHandler:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
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
    
    [NEUHomeDataManager getWithURL:self.topicURL parameters:nil modelClass:[HomeModel class] responseHandler:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
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

#pragma mark - UITableViewDelegate and DataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.resultArray count];
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
        _listTableView.dataSource = self;
        _listTableView.rowHeight = 110;
        _listTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.showsHorizontalScrollIndicator = NO;
    }
    return _listTableView;
}



@end
