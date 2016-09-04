//
//  NEUTableViewBaseItem.m
//  CustomTableView
//
//  Created by 周鑫城 on 7/14/16.
//  Copyright © 2016 ZXC. All rights reserved.
//

#import "NEUTableViewBaseItem.h"

CGFloat const CellInvalidHeight = -1;

@implementation NEUTableViewBaseItem

- (instancetype)init {
    self = [self initWithImage:nil Title:nil SubTitle:nil AccessoryImage:nil];
    return self;
}

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)title SubTitle:(NSString *)subTitle AccessoryImage:(UIImage *)accessoryImage {
    self = [super init];
    if (self) {
        _cellHeight = CellInvalidHeight;
        _itemImage = image;
        _itemTitle = title;
        _itemSubtitle = subTitle;
        _itemAccessoryImage = accessoryImage;
    }
    return self;
}

@end