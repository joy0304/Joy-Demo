//
//  NEUHomeViewController.m
//  NEUGank
//
//  Created by Joy on 16/6/28.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUHomeViewController.h"
#import "NEUScrollPageView.h"
#import "NEUTopicScrollView.h"
#import "NEUHTTPSessionManager.h"
#import "AFNetworking.h"
#import "NEUListTableViewCell.h"
#import "NEUHomeDataManager.h"
#import "DetailWebViewController.h"
#import "UINavigationController+push.h"
#import "NEUTopicItemView.h"
#import "NEUTopicViewController.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"

@interface NEUHomeViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, NEUTopicItemViewDelegate>
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) NSMutableArray *resultArray;

@end

@implementation NEUHomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageArray = @[@"scrollPage_1",@"scrollPage_2.png",@"scrollPage_3.png",@"scrollPage_4.png",@"scrollPage_5.png"];
        self.scrollPageView.delegate = self;
        self.scrollIntervalTime = 3.0;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    
    // 添加轮播广告
    [self.headView addSubview:self.scrollPageView];
    [self.scrollPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.headView).offset(0);
        make.height.equalTo(@220);
    }];
    
    // 添加主题 Item
    [self.headView addSubview:self.topicScrollView];
    [self.topicScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).offset(230);
        make.left.right.equalTo(self.headView).priority(750);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.headView).offset(-10);
        
    }];
    // 添加文章列表
    [self.view addSubview:self.listTableView];
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.bottom.right.equalTo(self.view);
    }];
    self.listTableView.tableHeaderView = self.headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prefersStatusBarHidden];

    self.topicScrollView.delegate = self;
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
    // 开始轮播图片
    [self beginTimer];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self stopTimer];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
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

#pragma mark - UIScrollViewDelegate methods
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self beginTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updataWhenFirstOrLast];
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

#pragma mark - NEUTopicItemViewDelegate
- (void)topicViewdDidSelectCategory:(NSString *)category {
    NEUTopicViewController *topicViewController = [[NEUTopicViewController alloc] init];
    [self.navigationController pushViewControllerWithTabbarHidden:topicViewController animated:true];
}

#pragma mark - NSTimer
-(void)beginTimer {
    if(self.scrollTimer == nil) {
        self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollIntervalTime target:self selector:@selector(timerSelector) userInfo:nil repeats:YES];
    }
}

-(void)stopTimer {
    [self.scrollTimer invalidate];
    self.scrollTimer=nil;
}

-(void)timerSelector {
    // 获取并且计算当前页码
    CGPoint currentOffset = self.scrollPageView.scrollPageView.contentOffset;
    currentOffset.x = currentOffset.x + NEUAPPWIDTH;
    // 动画改变当前页码
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollPageView.scrollPageView.contentOffset = currentOffset;
    }completion:^(BOOL finished) {
        [self updataWhenFirstOrLast];
    }];
}

#pragma mark -
-(void)updataWhenFirstOrLast {
    if(self.scrollPageView.scrollPageView.contentOffset.x >= (self.scrollPageView.scrollPageView.contentSize.width- NEUAPPWIDTH)) {
        self.scrollPageView.scrollPageView.contentOffset= CGPointMake(NEUAPPWIDTH, 0);
    }
    else if (self.scrollPageView.scrollPageView.contentOffset.x <= 0) {
        self.scrollPageView.scrollPageView.contentOffset=CGPointMake(self.scrollPageView.scrollPageView.contentSize.width - (2 * NEUAPPWIDTH), 0);
    }
    [self updatePageControl];
}

-(void)updatePageControl {
    NSInteger index = (self.scrollPageView.scrollPageView.contentOffset.x - NEUAPPWIDTH)/ NEUAPPWIDTH;
    self.scrollPageView.pageControl.currentPage = index;
}

#pragma mark - Setter and Getter
- (NEUScrollPageView *)scrollPageView {
    if (!_scrollPageView) {
        _scrollPageView = [[NEUScrollPageView alloc] initWithtFrame:CGRectZero ImageArr:self.imageArray];
        _scrollPageView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollPageView.backgroundColor = [UIColor blueColor];
        _scrollPageView.scrollPageView.contentOffset = CGPointMake(NEUAPPWIDTH, 0);
    }
    return _scrollPageView;
}

- (NEUTopicScrollView *)topicScrollView {
    if (!_topicScrollView) {
        _topicScrollView = [[NEUTopicScrollView alloc] initWithFrame:CGRectZero];
        _topicScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topicScrollView;
}

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

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 280)];
    }
    return _headView;
}
@end
