//
//  NEUTopicCell.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUTopicCell.h"
#import "UIView+NEUExtension.h"
#import "NEUTableViewBaseItem.h"

@implementation NEUTopicCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - setter and getter

- (UIImageView *)articleImageView {
    if (!_articleImageView) {
        _articleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    }
    return  _articleImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 20, 100, 25)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    return _titleLabel;
}

- (UIImageView *)accessoryImageView {
    if (!_accessoryImageView) {
        _accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width+10, self.height-20, 15, 15)];
    }
    return  _accessoryImageView;
}

#pragma  mark -- override the initWithStyle to build custom cell style
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.articleImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.accessoryImageView];
    }
    return self;
}

#pragma mark -- 重写setObject方法
- (void)setObject:(NEUTableViewBaseItem *)object { // 子类在这个方法中解析数据
    self.articleImageView.image = [UIImage imageNamed:object.itemTitle];
    self.titleLabel.text = object.itemTitle;
    self.accessoryImageView.image = [UIImage imageNamed:@"arrow"];
//    self.accessoryView = [[UIImageView alloc] initWithImage:object.itemAccessoryImage];
    NSLog(@"set the custom topic cell");
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(NEUTableViewBaseItem *)object {
    return 70;
}


@end
