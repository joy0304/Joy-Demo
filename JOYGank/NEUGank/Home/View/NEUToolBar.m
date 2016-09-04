//
//  NEUToolBar.m
//  NEUGank
//
//  Created by Joy on 16/8/2.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUToolBar.h"

@implementation NEUToolBar

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.shareButton];
        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@30);
            make.top.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-5);
        }];
    }
    return self;
}


- (UIButton *)shareButton {
    if (_shareButton) {
        _shareButton = [[UIButton alloc] init];
        _shareButton.backgroundColor = [UIColor redColor];
    }
    return _shareButton;
}

@end
