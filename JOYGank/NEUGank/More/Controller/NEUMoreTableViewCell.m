//
//  NEUMoreTableViewCell.m
//  NEUGank
//
//  Created by 周鑫城 on 8/1/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUMoreTableViewCell.h"
#import "NEUTableViewBaseItem.h"
#import "UIView+NEUExtension.h"

@implementation NEUMoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(NEUTableViewBaseItem *)object {
    if (object.itemTitle == nil) {
        return 10;
    }
    return 50;
}

#pragma mark -- setter and getter

- (UIView *)intervalView{
    if (!_intervalView) {
        _intervalView = [[UIView alloc] initWithFrame:CGRectMake(self.articlePicture.width+5, 49.5, self.width, 0.5)];
        _intervalView.backgroundColor = [UIColor grayColor];
    }
    if (self.titleLabel.text == nil) {
        return nil;
    }
    return  _intervalView;
}

- (UIImageView *)articlePicture {
    if (!_articlePicture) {
        _articlePicture = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
        _articlePicture.image = [UIImage imageNamed:@"default"];
    }
    return  _articlePicture;
}

- (UIImageView *)accessoryImageView {
    if (!_accessoryImageView) {
        _accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-20, (self.height-40)/2, 20, 40)];
        _accessoryImageView.image = [UIImage imageNamed:@"default"];
    }
    return  _accessoryImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, self.width/2, 30)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _titleLabel;
}

#pragma  mark -- set the object
- (void)setObject:(NEUTableViewBaseItem *)object { // 子类在这个方法中解析数据
    self.articlePicture.image = object.itemImage;
    self.titleLabel.text = object.itemTitle;
    self.accessoryImageView.image = object.itemAccessoryImage;
    NSLog(@"set the custom moretableview cell ");
}


#pragma mark -- override the initwithStyle to build custom cell style
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.articlePicture];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.accessoryImageView];
        [self.contentView addSubview:self.intervalView];
    }
    return self;
}

@end
