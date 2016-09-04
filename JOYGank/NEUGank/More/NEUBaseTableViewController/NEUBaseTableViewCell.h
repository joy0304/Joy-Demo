//
//  NEUTableViewCell.h
//  CustomTableView
//
//  Created by 周鑫城 on 7/14/16.
//  Copyright © 2016 ZXC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NEUTableViewBaseItem;

@interface NEUBaseTableViewCell : UITableViewCell

@property (nonatomic, retain) id object;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(NEUTableViewBaseItem *)object;

@end
