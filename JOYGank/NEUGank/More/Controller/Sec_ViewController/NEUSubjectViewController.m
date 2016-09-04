//
//  NEUSubjectViewController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUSubjectViewController.h"
#import "NEUSubjectDataSource.h"
#import "UIViewController+Side.h"
#import "UIView+NEUExtension.h"

@implementation NEUSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已关注专题";
//    [self setUI];
}
/*
- (void)setUI {
    UIBarButtonItem *apostrophe = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(side)];
    self.navigationItem.rightBarButtonItem = apostrophe;
//    NEUSideTableViewController* sideTableView = [[NEUSideTableViewController alloc] initWithStyle:UITableViewStylePlain];
    sideTableView.title = @"全部专题";
    self.sideView = sideTableView.view;
    sideTableView.view.frame = CGRectMake(0, 0, 250, self.view.bounds.size.height);
    [self addChildViewController:sideTableView];
    sideTableView.sideblock =  ^{
        [self side];
    };
    self.HYSideDirectionType = HYSideDirectionLeft;
    self.hidesBottomBarWhenPushed = NO;
    if (self.dataSource.sections == nil) {
        UILabel *notification = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width/4, (self.view.height-20)/3, self.view.width/2, 20)];
        notification.text = @"你还没有关注任何专题，欢迎添加";
        notification.textColor = [UIColor grayColor];
        [self.view addSubview:notification];
    }
}
*/
- (void)createDataSource {
    self.dataSource = [[NEUSubjectDataSource alloc] init];
}


#pragma mark - side slide methods
- (void)side{
    [self sideAnimateWithDuration:0.25];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.isSide) {
        [self side];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
}

@end
