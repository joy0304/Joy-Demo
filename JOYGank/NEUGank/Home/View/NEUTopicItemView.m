//
//  NEUTopicItemView.m
//  NEUGank
//
//  Created by Joy on 16/6/29.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUTopicItemView.h"
#import "Masonry.h"

@implementation NEUTopicItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundImage];
        [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self).offset(0);
        }];
        
        [self addSubview:self.topicButton];
        [self.topicButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@100);
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

#pragma mark - Setter and Getter
- (UIButton *) topicButton {
    if (!_topicButton) {
        _topicButton = [[UIButton alloc] init];
        //[_topicButton setTitle:@"你好" forState:UIControlStateNormal];
        //[_topicButton setImage:[UIImage imageNamed:@"topic_botn_drive"] forState:UIControlStateNormal];
        [_topicButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    return _topicButton;
}

- (UIImageView *)backgroundImage {
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc] init];
        //_backgroundImage.image = [UIImage imageNamed:@"frontend"];
        _backgroundImage.contentMode =     UIViewContentModeScaleAspectFill;
        _backgroundImage.layer.cornerRadius = 5.0;
    }
    return _backgroundImage;
}


@end
