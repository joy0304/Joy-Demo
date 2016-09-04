//
//  NEUListTableViewCell.m
//  NEUGank
//
//  Created by Joy on 16/7/3.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUListTableViewCell.h"
#import "NEUHomeDataManager.h"

@implementation NEUListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@80);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(15);
    }];
    
    [self addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.imgView.mas_left).offset(-10);
        make.left.equalTo(self).offset(10);
    }];
    
    [self addSubview:self.userLabel];
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self.desLabel.mas_top).offset(-8);
    }];
    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userLabel.mas_right).offset(6);
        make.bottom.equalTo(self.userLabel);
    }];
    
}
#pragma mark - cellData
- (void)setCellDataWithModel:(HomeModel *)model {
    NSString *timeText = [model.publishTime substringToIndex:10];
    self.timeLabel.text = timeText;
    self.userLabel.text = model.userName;
    self.desLabel.text = model.describe;
    self.imgView.image = [UIImage imageNamed:@"temp"];
}


#pragma mark - Setter and Getter
- (UILabel *)userLabel {
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] init];
        _userLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _userLabel.font = [UIFont systemFontOfSize:14];
        _userLabel.textColor = [UIColor blueColor];
    }
    return _userLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor grayColor];
    }
    return _timeLabel;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imgView;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.numberOfLines = 0;
        _desLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _desLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _desLabel.font = [UIFont systemFontOfSize:18];
        _desLabel.numberOfLines = 2;
    }
    return _desLabel;
}

@end
