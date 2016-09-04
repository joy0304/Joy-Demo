//
//  NEUCollectionTableViewCell.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUCollectionTableViewCell.h"
#import "UIView+NEUExtension.h"
#import "NEUCollectionItem.h"
#import "UIView+NEUExtension.h"

@interface NEUCollectionTableViewCell ()

@property (nonatomic, strong) UIView *intrvalView;

@end

@implementation NEUCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(NEUTableViewBaseItem *)object {
    return 80;
}

#pragma mark -- the setter and getter 

- (UILabel *)userLabel {
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 20)];
        _userLabel.font = [UIFont systemFontOfSize:14.0f];
        _userLabel.textColor = [UIColor blueColor];
    }
    return _userLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMinY(self.userLabel.frame)+20, [UIScreen mainScreen].bounds.size.width-60, 30)];
        _titleLabel.text = @"default title";
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
    }
    return _titleLabel;
}

- (UILabel *)articleCla {
    if (!_articleCla) {
        _articleCla = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame)+5, 50, 20)];
        _articleCla.text = @"default articleClass";
        _articleCla.font = [UIFont systemFontOfSize:12.0f];
        _articleCla.layer.cornerRadius = 10.0f;
        _articleCla.layer.masksToBounds = YES;
        _articleCla.layer.borderColor = [UIColor redColor].CGColor;
        _articleCla.layer.borderWidth = 0.5;
        _articleCla.backgroundColor = [UIColor clearColor];
        _articleCla.textColor = [UIColor redColor];
        _articleCla.textAlignment = NSTextAlignmentCenter;
    }
    return  _articleCla;
}

- (UIImageView *)articlePicture {
    if (!_articlePicture) {
        _articlePicture = [[UIImageView alloc] initWithFrame:CGRectMake(self.width, (self.height-10)/2, 40, 40)];
    }
    return _articlePicture;
}

- (UIView *)intrvalView {
    if (!_intrvalView) {
        _intrvalView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.articleCla.frame)+1.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
        _intrvalView.backgroundColor = [UIColor grayColor];
//        _intrvalView.backgroundColor = [UIColor colorWithRed:217.0f green:217.0f blue:217.0f alpha:0];
    }
    return _intrvalView;
}

#pragma  mark -- set the override object
- (void)setObject:(NEUCollectionItem *)object { // 子类在这个方法中解析数据
    self.articlePicture.image = object.itemImage;
    self.userLabel.text = object.itemSubtitle;
    self.titleLabel.text = object.itemTitle;
//    self.userPicture.image = object.itemAccessoryImage;
    self.articleCla.text = object.articleClass;
    NSLog(@"set the custom collection cell");
}

#pragma  mark -- override the initWithStyle to build custom cell style
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.userLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.articleCla];  
        [self.contentView addSubview:self.articlePicture];
//        [self.contentView addSubview:self.userPicture];
        [self.contentView addSubview:self.intrvalView];
    }
    return self;
}


@end
