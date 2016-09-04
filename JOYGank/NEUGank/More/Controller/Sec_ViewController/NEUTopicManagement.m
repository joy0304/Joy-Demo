//
//  NEUTopicManagement.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUTopicManagement.h"
#import "NEUTopicDataSource.h"
#import "NEUConcernedTopicVC.h"
#import "UIViewController+Side.h"
#import "UIView+NEUExtension.h"
#import "NEUHTTPService.h"
#import "NEUTopicDectail.h"
#import "UINavigationController+push.h"
#import "MJRefresh.h"
#import "NEUTableViewBaseItem.h"
#import "NEUTableViewSectionObject.h"
#import "NEUDetailWebVC.h"
#import "NEUPublicViewController.h"

@implementation NEUTopicManagement

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已关注话题";
//    [self setUI];
    __weak NEUTopicManagement* weakSelf = self;
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataSource.collectionBlock = ^(){
            [weakSelf.tableView reloadData];
        };
//    }]; 
//    [self.tableView.mj_header beginRefreshing];
}
//
//- (void)setUI {
////    UIBarButtonItem *apostrophe = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(side)];
////    self.navigationItem.rightBarButtonItem = apostrophe;
//    NEUSideTableViewController* sideTableView = [[NEUSideTableViewController alloc] initWithStyle:UITableViewStylePlain];
//    sideTableView.title = @"全部话题";
//    self.sideView = sideTableView.view;
//    sideTableView.view.frame = CGRectMake(0, 0, 250, self.view.bounds.size.height);
//    [self addChildViewController:sideTableView];
//    sideTableView.sideblock =  ^{
//        [self side];
//    };
//    self.HYSideDirectionType = HYSideDirectionLeft;
//    self.hidesBottomBarWhenPushed = NO;
//    if (self.dataSource.sections == nil) {
//        UILabel *notification = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width/4, (self.view.height-20)/3, self.view.width/2, 20)];
//        notification.text = @"你还没有关注任何话题，欢迎添加";
//        notification.textColor = [UIColor grayColor];
//        [self.view addSubview:notification];
//    }
//}

- (void)createDataSource{
    self.dataSource = [[NEUTopicDataSource alloc] init];
}
/*
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"this is my topic management view controller selcted :%ld", indexPath.row);
    switch (indexPath.row) {
        case 0:
        {
            NEUTopicDectail *topicDetail = [[NEUTopicDectail alloc] initWithTopicURL:@"http://gank.io/api/data/iOS/20/2"];
//            [self.navigationController pushViewController:topicDetail animated:YES];
            [self.navigationController pushViewControllerWithTabbarHidden:topicDetail animated:YES];
          break;
        };
        case 1:{
            NEUTopicDectail *topicDetail = [[NEUTopicDectail alloc] initWithTopicURL:@"http://gank.io/api/data/Android/20/2"];
//            [self.navigationController pushViewController:topicDetail animated:YES];
            [self.navigationController pushViewControllerWithTabbarHidden:topicDetail animated:YES];
            break;
        };
        case 2:{
            NEUTopicDectail *topicDetail = [[NEUTopicDectail alloc] initWithTopicURL:@"http://gank.io/api/data/%E5%89%8D%E7%AB%AF/10/2"];
//            [self.navigationController pushViewController:topicDetail animated:YES];
            [self.navigationController pushViewControllerWithTabbarHidden:topicDetail animated:YES];
            break;
        }
        case 3:{
            NEUTopicDectail *topicDetail = [[NEUTopicDectail alloc] initWithTopicURL:@"http://gank.io/api/data/%E6%8B%93%E5%B1%95%E8%B5%84%E6%BA%90/20/2"];
//            [self.navigationController pushViewController:topicDetail animated:YES];
            [self.navigationController pushViewControllerWithTabbarHidden:topicDetail animated:YES];
            break;
        }
        default:
            break;
    }
}
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
    NSLog(@"this is a test for detailwebviewcontroller");
    NEUTableViewSectionObject *sectionObj = self.dataSource.sections[indexPath.section];
    NEUTableViewBaseItem *baseItems = sectionObj.items[indexPath.row];
//    NEUDetailWebVC *detailVC = [[NEUDetailWebVC alloc] initWithUrl:baseItems.itemSubtitle];
    NEUPublicViewController *detailVC = [[NEUPublicViewController alloc] initWithUrl:baseItems.itemSubtitle];
   [self.navigationController pushViewControllerWithTabbarHidden:detailVC animated:YES];
    
}

//#pragma mark - side slide methods
//- (void)side{
//    
//    [self sideAnimateWithDuration:0.25];
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    if (self.isSide) {
//        [self side];
//    }
//}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did deselect row at index");
    
}


@end
