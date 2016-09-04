//
//  NEUAllTopicViewController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUAllTopicViewController.h"
#import "NEUAllTopicDataSource.h"

@implementation NEUAllTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文章";
}

- (void)createDataSource {
    self.dataSource = [[NEUAllTopicDataSource alloc] init];
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"this is my passage view controller selcted :%ld", indexPath.row);
}


@end
