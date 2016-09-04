//
//  NEUListTableViewCell.h
//  NEUGank
//
//  Created by Joy on 16/7/3.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeModel;
@interface NEUListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *desLabel;

- (void)setCellDataWithModel:(HomeModel *)model;

@end
