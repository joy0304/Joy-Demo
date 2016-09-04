//
//  NEUTableViewBaseItem.h
//  CustomTableView
//
//  Created by 周鑫城 on 7/14/16.
//  Copyright © 2016 ZXC. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT CGFloat const CellInvalidHeight;

@interface NEUTableViewBaseItem : NSObject

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, retain) NSString *itemIdentifier;
@property (nonatomic, retain) UIImage *itemImage;
@property (nonatomic, retain) NSString *itemTitle;
@property (nonatomic, retain) NSString *itemSubtitle;
@property (nonatomic, retain) UIImage *itemAccessoryImage;

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)title SubTitle:(NSString *)subTitle AccessoryImage:(UIImage *)accessoryImage;

@end
