//
//  NEUPublicViewController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/6/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUPublicViewController.h"
#import "NEUHomeDataManager.h"
#import "NEUListTableViewCell.h"
#import "MBProgressHUD.h"

@interface NEUPublicViewController ()

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation NEUPublicViewController

- (void)loadView {
    [super loadView];
    //添加文章列表
    [self.view addSubview:self.listTableView];
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.bottom.right.equalTo(self.view);
    }];
//    self.listTableView.tableHeaderView = self.headView;
}

- (instancetype)initWithUrl:(NSString *)urlString {
    self = [super init];
    if (self) {
        _urlString = urlString;
    }
    return self;
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
//        [weakSelf loadMoreData];
        NSLog(@"there is no more");
    }];
}

#pragma mark - load Data
- (void)loadListData {
    // 添加tableview的数据
    __weak __typeof(self)weakSelf = self;
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NEUHomeDataManager getWithURL:self.urlString parameters:nil modelClass:[HomeModel class] responseHandler:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
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
    
    [NEUHomeDataManager getWithURL:self.urlString parameters:nil modelClass:[HomeModel class] responseHandler:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
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


#pragma mark -- tableview controller delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"listCell";
    NEUListTableViewCell *cell = [self.listTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NEUListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setCellDataWithModel:self.resultArray[indexPath.row]];
    cell.userLabel.text = nil;
    cell.timeLabel.text = nil;
    return cell;
}


#pragma mark - UITableViewDelegate and DataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.resultArray count]/4;
}


#pragma mark -- setter and getter
- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] init];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.rowHeight = 110;
        _listTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.showsHorizontalScrollIndicator = NO;
    }
    return _listTableView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _headView;
}

#pragma mark -- datasource
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setEditing:YES animated:YES];
    return UITableViewCellEditingStyleDelete;
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setEditing:NO animated:YES];
    [self.resultArray removeObjectAtIndex:indexPath.row];
    [self.listTableView reloadData];
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isEditing) {
        [tableView reloadData];
    }
}

@end
