//
//  NEUTopTool.m
//  NEUGank
//
//  Created by 周鑫城 on 8/12/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUTopTool.h"
#import "UIView+NEUExtension.h"
#import <AVOSCloud/AVOSCloud.h>
#import "NEUNewPassage.h"

@interface NEUTopTool()

@property (nonatomic, weak) UILabel *textCount;

@end

@implementation NEUTopTool


- (void)setUpTopView {
    //添加左边按钮
    UIButton *leftBtn = [self addOneButton:@"关闭"];
    leftBtn.frame = CGRectMake(5, 0, 44, 44);
    [leftBtn addTarget:self action:@selector(outLoginBtnClick) forControlEvents:UIControlEventTouchDown];
    [self addSubview:leftBtn];
    //添加右边按钮
    UIButton *rightBtn = [self addOneButton:@"发布"];
    CGFloat rightBtnX = [UIScreen mainScreen].bounds.size.width - 49;
    rightBtn.frame = CGRectMake(rightBtnX, 0, 44, 44);
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchDown];
    [self addSubview:rightBtn];
    //添加中间字数显示
    UILabel *textCount = [self addTextCountLabel];
    textCount.textAlignment =  NSTextAlignmentCenter;
    textCount.size = CGSizeMake(100, 100);
    textCount.centerX = self.centerX;
    textCount.centerY = self.height* 0.5;
    [self addSubview:textCount];
    self.textCount = textCount;

}

#pragma mark - 添加一个按钮
-(UIButton *)addOneButton:(NSString *)btnName
{
    //创建自定义按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //设置按钮状态
    [btn setTitle:btnName forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:217/255.0 green:110/255.0 blue:93/255.0 alpha:1] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:(15.0f)];
    [btn setTitleColor:[UIColor colorWithRed:217/255.0 green:110/255.0 blue:93/255.0 alpha:0.5] forState:UIControlStateHighlighted];
    return btn;
}

#pragma mark - 添加字数显示
-(UILabel *)addTextCountLabel
{
    UILabel *textCount = [[UILabel alloc] init];
    textCount.text = @"0字";
    textCount.font = [UIFont systemFontOfSize:(10.0f)];
    textCount.textColor = [UIColor lightGrayColor];
    _textCount = textCount;
    return textCount;
}

#pragma mark - 点击了退出按钮
-(void)outLoginBtnClick
{
    if ([self.delegate respondsToSelector:@selector(NEUTopToolOutLoginBtnClick)]) {
        [self.delegate NEUTopToolOutLoginBtnClick];
    }
}

#pragma mark - 点击了发布按钮
-(void)rightBtnClick
{
    if (self.releaseOnClick) {
        self.releaseOnClick();
        NSLog(@"I AM THE RIGHTBUNCLICK HAHAHA");
        AVObject *publication = [AVObject objectWithClassName:@"Publication"];
        [publication setObject:@"更加有优美的使用uiscrollview" forKey:@"desc"];
        [publication setObject:@"iOS" forKey:@"articleCategory"];
        NSLog(@"self.delegate xxxx %@", ((NEUNewPassage *)self.delegate).title);
        [publication saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // 存储成功
                NSLog(@"存储成功 存储成功 存储成功");
            } else {
                // 失败的话，请检查网络环境以及 SDK 配置是否正确
                NSLog(@"存储失败 存储失败 存储失败！");
            }
        }];
    }
}



@end
