//
//  NEUSubjectDataSource.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUSubjectDataSource.h"
#import "NEUTableViewSectionObject.h"
#import "NEUTableViewBaseItem.h"
#import "NEUSubjectCell.h"

@implementation NEUSubjectDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
//        NEUTableViewSectionObject *firstSectionObject =
//        [[NEUTableViewSectionObject alloc] initWithItemArray:[NSMutableArray arrayWithObjects:
//                                                                                                              [[NEUTableViewBaseItem alloc] initWithImage:nil Title:@"切腹的茄子" SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]],
//                                                                                                              [[NEUTableViewBaseItem alloc] initWithImage:nil Title:@"写个签名更懂你" SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]],
//                                                                                                              [[NEUTableViewBaseItem alloc] initWithImage:nil Title:@"地区" SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]],
//                                                                                                              [[NEUTableViewBaseItem alloc] initWithImage:nil Title:@"性别" SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]],
//                                                                                                              
//                                                                                                              nil]];
//        
        self.sections = nil;
//        [NSMutableArray arrayWithObjects:firstSectionObject, nil];
    }
    return self;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(NEUTableViewBaseItem *)object {
    return [NEUSubjectCell class];
}


@end
