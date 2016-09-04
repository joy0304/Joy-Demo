//
//  NEUConcernedTopicVC.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUConcernedTopicVC.h"
#import "NEUConcernedTopicDS.h"

@implementation NEUConcernedTopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已关注话题";
}

- (void)createDataSource{
    self.dataSource = [[NEUConcernedTopicDS alloc] init];
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"this is my topic management view controller selcted :%ld", indexPath.row);
}


@end
