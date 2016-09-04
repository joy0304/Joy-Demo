//
//  NEUTopicScrollView.m
//  NEUGank
//
//  Created by Joy on 16/6/29.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUTopicScrollView.h"
#import "Masonry.h"
#import "NEUTopicItemView.h"

static const CGFloat SCROLLHEIGHT = 40;
static const CGFloat ITEMWIDTH = 100;

@implementation NEUTopicScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.imageArray = @[@"frontend",@"ios",@"android",@"tuozhan",@"fuli"];
        
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(SCROLLHEIGHT));
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
        }];
        
        self.ContainerView = [[UIView alloc] init];
        [self.scrollView addSubview:self.ContainerView];
        CGFloat containWidth = (ITEMWIDTH + 10) * 5;
        [self.ContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            make.height.equalTo(@(SCROLLHEIGHT));
            make.width.equalTo(@(containWidth));
        }];
        
        NSInteger index = 0;
        while (index < 5) {
            [self addItemWithIndex:index];
            index++;
        }
    }
    return self;
}

#pragma mark - private methods
- (void)addItemWithIndex:(NSInteger)index {
    self.topicItemView = [[NEUTopicItemView alloc] init];
    [self.topicItemView.topicButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.ContainerView addSubview:self.topicItemView];
    CGFloat leftPadding = (ITEMWIDTH + 10 )* index;
    [self.topicItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ITEMWIDTH));
        make.height.equalTo(@(SCROLLHEIGHT));
        make.top.equalTo(self.ContainerView);
        make.left.equalTo(self.ContainerView.mas_left).offset(leftPadding);
    }];
    
    self.topicItemView.backgroundImage.image = [UIImage imageNamed:self.imageArray[index]];
}

- (void)buttonAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(topicViewdDidSelectCategory:)]) {
        [_delegate topicViewdDidSelectCategory:@"iOS"];
    }
}

#pragma mark - Setter and Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

@end
