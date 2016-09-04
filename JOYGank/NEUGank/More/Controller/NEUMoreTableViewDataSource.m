//
//  NEUMoreTableViewDataSource.m
//  NEUGank
//
//  Created by 周鑫城 on 8/1/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUMoreTableViewDataSource.h"
#import "NEUMoreTableViewCell.h"
#import "NEUTableViewSectionObject.h" // 这个实际使用时应该是对应的子类
#import "NEUTableViewBaseItem.h" // 这个实际使用时应该是对应的子类

@implementation NEUMoreTableViewDataSource
- (instancetype)init
{
    self = [super init];
    if (self) {
        NEUTableViewSectionObject *firstSectionObject = [[NEUTableViewSectionObject alloc] initWithItemArray:[NSMutableArray arrayWithObjects:
                                                                                                            [[NEUTableViewBaseItem alloc] initWithImage:[UIImage imageNamed:@"first"] Title:@"我的收藏" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[NEUTableViewBaseItem alloc] initWithImage:[UIImage imageNamed:@"second"] Title:@"我发布的文章" SubTitle:nil AccessoryImage:nil],
                                                                        [[NEUTableViewBaseItem alloc] initWithImage:nil Title:nil
                                                                         SubTitle:nil AccessoryImage:nil],
                                                                                                               [[NEUTableViewBaseItem alloc] initWithImage:[UIImage imageNamed:@"fourth"] Title:@"话题管理" SubTitle:nil AccessoryImage:nil],
                                                                                                              [[NEUTableViewBaseItem alloc] initWithImage:nil Title:nil
                                                                                                                                                 SubTitle:nil AccessoryImage:nil], [[NEUTableViewBaseItem alloc] initWithImage:[UIImage imageNamed:@"fifth"] Title:@"我的设置" SubTitle:nil AccessoryImage:nil], nil]];
                self.sections = [NSMutableArray arrayWithObjects:firstSectionObject, nil];
    }
    return self;
}



- (Class)tableView:(UITableView *)tableView cellClassForObject:(NEUTableViewBaseItem *)object {
    return [NEUMoreTableViewCell class];
}

@end
