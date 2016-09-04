//
//  NEUAllTopicDataSource.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUAllTopicDataSource.h"
#import "NEUTableViewSectionObject.h"
#import "NEUTableViewBaseItem.h"
#import "NEUAllTopicCell.h"

@implementation NEUAllTopicDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        NEUTableViewSectionObject *firstSection = [[NEUTableViewSectionObject alloc] initWithItemArray:[NSMutableArray arrayWithObjects:
                                                                                                        [[NEUTableViewBaseItem alloc] initWithImage:nil Title:@"IOS " SubTitle:nil AccessoryImage:nil],[[NEUTableViewBaseItem alloc] initWithImage:nil Title:@"Android" SubTitle:nil AccessoryImage:nil],
                                                                                                        [[NEUTableViewBaseItem alloc] initWithImage:nil Title:@"Web" SubTitle:nil AccessoryImage:nil],
                                                                                                        [[NEUTableViewBaseItem alloc] initWithImage:nil Title:@"PHP" SubTitle:nil AccessoryImage:nil],nil]];
        self.sections = [NSMutableArray arrayWithObjects:firstSection, nil];
    }
    return self;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(NEUTableViewBaseItem *)object {
    return [NEUAllTopicCell  class];
}


@end
