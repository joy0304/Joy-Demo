//
//  NEUTableViewSectionObject.m
//  CustomTableView
//
//  Created by 周鑫城 on 7/14/16.
//  Copyright © 2016 ZXC. All rights reserved.
//

#import "NEUTableViewSectionObject.h"

@implementation NEUTableViewSectionObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.headerTitle = @"";
        self.footerTitle = @"";
        self.items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setHeaderView:(UIView *)headerView {
    if (!_headerView) {
        _headerView = headerView;
    }
}

- (instancetype)initWithItemArray:(NSMutableArray *)items {
    self = [self init];
    if (self) {
        [self.items addObjectsFromArray:items];
    }
    return self;
}

@end
