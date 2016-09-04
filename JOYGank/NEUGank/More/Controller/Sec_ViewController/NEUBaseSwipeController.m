//
//  NEUBaseSwipeController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUBaseSwipeController.h"
#import "NEUTableViewController.h"
#import "UIView+NEUExtension.h"
#import "NEUAllTopicDataSource.h"

@implementation NEUBaseSwipeController 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.leftTableViewController.title;
}

- (instancetype)initWithLeftController:(NEUTableViewController *)leftController rightController:(NEUTableViewController *)rightController{
    self = [super init];
    if (self) {
        _leftTableViewController = leftController;
        _rightTableViewController = rightController;
        [self createScrollView];
    }
    return  self;
}

- (void)createScrollView{
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _leftTableViewController.tableView = [[NEUBaseTableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,self.view.frame.size.height)];
//        _leftTableViewController.tableView.dataSource = [[NEUAllTopicDataSource alloc] init];
        _leftTableViewController.tableView.backgroundColor = [UIColor whiteColor];
        _rightTableViewController.tableView = [[NEUBaseTableView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, self.view.width,self.view.height)];
        _rightTableViewController.tableView.backgroundColor = [UIColor whiteColor];
        _leftTableViewController.tableView.userInteractionEnabled = YES;
        _rightTableViewController.tableView.userInteractionEnabled = YES;
//        _leftTableViewController.tableView.backgroundColor = [UIColor whiteColor];
//        _rightTableViewController.tableView.backgroundColor = [UIColor redColor];
        [_scrollView addSubview:_leftTableViewController.tableView];
        [_scrollView addSubview:_rightTableViewController.tableView];
        //设置scrollview内容的尺寸
        _scrollView.contentSize = CGSizeMake(_leftTableViewController.tableView.bounds.size.width*2, _leftTableViewController.tableView.bounds.size.height);
        //设置内容的偏移量，contentOffset参照contentSize的坐标系
        _scrollView.contentOffset = CGPointMake(0, 0);
        //设置是否回弹
        _scrollView.bounces = NO;
        //设置内容的边距
        _scrollView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        //设置是否可以滚动
        _scrollView.scrollEnabled = YES;
        //是否可以滚动到内容的顶部（点击状态栏）
        _scrollView.scrollsToTop = YES;
        //按页滚动
        _scrollView.pagingEnabled =YES;
        //是否显示水平和垂直方向的指示器
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        //设置指示器的样式
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        //设置代理
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToView:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToView:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [_leftTableViewController.tableView addGestureRecognizer:swipeLeft];
        [_rightTableViewController.tableView addGestureRecognizer:swipeRight];
        NSLog(@"create scrollview xxx");
    }
}

- (void)swipeToView:(UISwipeGestureRecognizer *)sender{
    NSLog(@"xxxxxxxxxxxx");
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.scrollView.contentOffset = self.view.frame.origin;
        self.title = self.leftTableViewController.title;
        NSLog(@"fasdfasdf");
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
        self.title = self.rightTableViewController.title;
        NSLog(@"fasdfasdffasdf");
    }
}


@end
