//
//  NEUMoreTableViewCell.h
//  NEUGank
//
//  Created by 周鑫城 on 8/1/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NEUBaseTableViewCell.h"

@interface NEUMoreTableViewCell : NEUBaseTableViewCell

@property (nonatomic, strong) UIImageView *articlePicture;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *accessoryImageView;
@property (nonatomic, strong) UIView *intervalView;
@end
