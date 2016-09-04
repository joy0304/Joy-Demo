 //
//  NEUFindViewController.m
//  NEUGank
//
//  Created by Joy on 16/6/28.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUFindViewController.h"
#import "NEUHeadView.h"
#import "NEULoginInViewController.h"
#import "NEUListTableViewCell.h"
#import "DetailWebViewController.h"
#import "NEUHomeDataManager.h"
#import "UINavigationController+push.h"
#import "NEUFindDataManager.h"
#import "YYModel.h"
#import "UIImageView+WebCache.h"
#import "NEUHTTPSessionManager.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "FindDetailviewController.h"
@interface NEUFindViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) NSArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *iOSArray;
@property (nonatomic, strong) NSMutableArray *androidArray;
@property (nonatomic, strong) NSMutableArray *otherSourceArray;
@property (nonatomic, strong) NSMutableArray *videoArray;
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) NSMutableArray *girlArray;
@end

@implementation NEUFindViewController

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.listTableView];
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
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
    
}

#pragma mark - load Data
- (void)loadListData {
    // 添加tableview的数据
    __weak __typeof(self)weakSelf = self;
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [NEUFindDataManager getWithURL:@"http://gank.io/api/day/2015/08/06" parameters:nil modelClass:[HomeModel class] responseHandler:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (error) {
            _HUD.label.text = @"网络错误";
            [_HUD hideAnimated:YES afterDelay:2.0];
            [strongSelf.listTableView.mj_header endRefreshing];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                strongSelf.sectionArray = responseObject[@"category"];
                id object = responseObject[@"results"];
                id iOSObject = object[@"iOS"];
                id androidObject = object[@"Android"];
                id videoObject = object[@"休息视频"];
                id otherObject = object[@"拓展资源"];
                id girlObject = object[@"福利"];
                strongSelf.iOSArray = [[NSMutableArray alloc] initWithArray:[NSArray yy_modelArrayWithClass:[HomeModel class] json:iOSObject]];
                strongSelf.androidArray = [[NSMutableArray alloc] initWithArray:[NSArray yy_modelArrayWithClass:[HomeModel class] json:androidObject]];
                strongSelf.videoArray = [[NSMutableArray alloc] initWithArray:[NSArray yy_modelArrayWithClass:[HomeModel class] json:videoObject]];
                strongSelf.otherSourceArray = [[NSMutableArray alloc] initWithArray:[NSArray yy_modelArrayWithClass:[HomeModel class] json:otherObject]];
                strongSelf.girlArray = [[NSMutableArray alloc] initWithArray:[NSArray yy_modelArrayWithClass:[HomeModel class] json:girlObject]];
                HomeModel *girl = strongSelf.girlArray[0];
                NSURL *url = [[NSURL alloc] initWithString:girl.detailURL];
                [strongSelf.listHeadView.backgroundImageView sd_setImageWithURL:url];
                [strongSelf.listTableView.mj_header endRefreshing];
                [strongSelf.listTableView reloadData];
            });
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark -
- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - UITableViewDelegate and DataSourse
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArray.count;
}

-(NSString* )tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        return @" ";
    }
    return self.sectionArray[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *title = self.sectionArray[section];
    if ([title isEqualToString:@"Android"]) {
        return self.androidArray.count;
    }
    else if ([title isEqualToString:@"iOS"]) {
        return self.iOSArray.count;
    }
    else if ([title isEqualToString:@"休息视频"]) {
        return self.videoArray.count;
    }
    else if ([title isEqualToString:@"拓展资源"]) {
        return self.otherSourceArray.count;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"listCell";
    NEUListTableViewCell *cell = [self.listTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NEUListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *title = self.sectionArray[indexPath.section];
    if ([title isEqualToString:@"Android"]) {
        [cell setCellDataWithModel:self.androidArray[indexPath.row]];
    }
    else if ([title isEqualToString:@"iOS"]) {
        [cell setCellDataWithModel:self.iOSArray[indexPath.row]];
    }
    else if ([title isEqualToString:@"休息视频"]) {
        [cell setCellDataWithModel:self.videoArray[indexPath.row]];
    }
    else if ([title isEqualToString:@"拓展资源"]) {
        [cell setCellDataWithModel:self.otherSourceArray[indexPath.row]];
    }
    cell.timeLabel.text = @"2016-08-12";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModel *model;
    if (indexPath.section == 0) {
        model = self.iOSArray[indexPath.row];
    }
    else if (indexPath.section == 1) {
        model = self.otherSourceArray[indexPath.row];
    }
    else if (indexPath.section == 2) {
        model = self.androidArray[indexPath.row];
    }
    else {
        model = self.videoArray[indexPath.row];
    }
    FindDetailviewController *detailViewController = [[FindDetailviewController alloc] initWithDetailURL:model.detailURL descTitle:model.describe];
    [self.navigationController pushViewControllerWithTabbarHidden:detailViewController animated:YES];
}
#pragma mark - UIScrollViewDelegate methods
- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    if(scrollView.contentOffset.y < 0){
        CGRect initialFrame;
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        initialFrame.origin.y = - offsetY * 1;
        initialFrame.origin.x = - offsetY / 2;
        initialFrame.size.width  = NEUAPPWIDTH + offsetY;
        initialFrame.size.height = 220 + offsetY;
        self.listHeadView.backgroundImageView.frame = initialFrame;
    }
}

#pragma mark - Setter and Getter
- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] init];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.rowHeight = 110;
        _listTableView.tableHeaderView = self.listHeadView;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.showsHorizontalScrollIndicator = NO;
    }
    return _listTableView;
}

- (NEUHeadView *)listHeadView {
    if (!_listHeadView) {
        
        _listHeadView = [[NEUHeadView alloc] initWithFrame:CGRectMake(0, 0, NEUAPPWIDTH, 220)];
    }
    return _listHeadView;
}

@end
