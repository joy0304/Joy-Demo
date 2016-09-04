//
//  NEUHeadView.m
//  NEUGank
//
//  Created by Joy on 16/7/3.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUHeadView.h"
#import "UIImageView+WebCache.h"

static const CGFloat HEADERHEIGHT = 220;

@implementation NEUHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.contentView];
    }
    return self;
}

#pragma mark - Setter and Getter
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NEUAPPWIDTH, HEADERHEIGHT)];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImageView.clipsToBounds = YES;
        //_backgroundImageView.image = [UIImage imageNamed:@"image_06"];
    }
    return _backgroundImageView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.backgroundImageView.bounds];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

@end
