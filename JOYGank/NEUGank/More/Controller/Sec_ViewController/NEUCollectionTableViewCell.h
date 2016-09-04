//
//  NEUCollectionTableViewCell.h
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUBaseTableViewCell.h"

@interface NEUCollectionTableViewCell : NEUBaseTableViewCell

@property (nonatomic, strong) UIImageView* articlePicture;
//@property (nonatomic, strong) UIImageView* userPicture;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *articleCla;


@end
