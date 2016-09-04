//
//  NEUCollectionViewController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUCollectionViewController.h"
#import "NEUCollectionDataSource.h"
#import "DetailWebViewController.h"
#import "NEUDetailWebVC.h"
#import "NEUCollectionItem.h"
#import "NEUTableViewSectionObject.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"

@interface NEUCollectionViewController ()

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation NEUCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
//    self.HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    __weak NEUCollectionViewController* weakSelf = self;
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataSource.collectionBlock = ^(){
            [weakSelf.tableView reloadData];
        };
//    }];
//    [self.tableView.mj_header beginRefreshing];
    //    [self createDataSource];  TM的 又给自己挖了个大坑
}

//- (void)loadView {
//    [super loadView];
//    __weak NEUCollectionViewController* collectionVC = self;
//    self.dataSource.collectionBlock = ^(){
//        [collectionVC.tableView reloadData];
//    };
//}

- (void)createDataSource {
    self.dataSource = [[NEUCollectionDataSource alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
    NSLog(@"this is a test for detailwebviewcontroller");
    NEUTableViewSectionObject *sectionObj = self.dataSource.sections[indexPath.section];
    NEUCollectionItem *collItems = (NEUCollectionItem *)sectionObj.items[indexPath.row];
    NEUDetailWebVC *detailVC = [[NEUDetailWebVC alloc] initWithUrl:collItems.urlString];           
    [self.navigationController pushViewControllerWithTabbarHidden:detailVC animated:YES];

}

- (void)willDeleteRow {
    NSLog(@"will delete the row");
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did deselect row at index");
    
}





@end
