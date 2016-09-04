//
//  NEUMyPassageViewController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUMyPassageViewController.h"
#import "NEUMyPassageDataSource.h"
#import "DetailWebViewController.h"
#import "NEUMyPassageItem.h"
#import "NEUDetailWebVC.h"
#import "NEUTableViewSectionObject.h"
#import "NEUNewPassage.h"
#import "MBProgressHUD.h"

@interface NEUMyPassageViewController ()

@property (nonatomic, strong) MBProgressHUD *HUD;


@end

@implementation NEUMyPassageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的文章";
    _HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [_HUD hideAnimated:YES afterDelay:1.5];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newPassage)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    __weak NEUMyPassageViewController * collectionVC = self;
    self.dataSource.collectionBlock = ^(){
        [collectionVC.tableView reloadData];
    };
}

#pragma mark -- edit the new passage 

- (void)newPassage {
    NSLog(@"edit the new passage!!!");
    NEUNewPassage *newPassage = [[NEUNewPassage alloc] init];
    [self presentViewController:newPassage animated:YES completion:nil];
}

- (void)createDataSource {
    self.dataSource = [[NEUMyPassageDataSource alloc] init];
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"this is my passage view controller selcted :%ld", indexPath.row);
    NEUTableViewSectionObject *sectionObj = self.dataSource.sections[indexPath.section];
    NEUMyPassageItem *passItem = (NEUMyPassageItem
                                  *)sectionObj.items[indexPath.row];
    NEUDetailWebVC *detailVC = [[NEUDetailWebVC alloc] initWithUrl:passItem.urlString];
    [self.navigationController pushViewControllerWithTabbarHidden:detailVC animated:YES];
}

- (void)willDeleteRow {
    NSLog(@"will delete the row");
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did deselect row at index");
    
}

#pragma mark -- the life method

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

@end
