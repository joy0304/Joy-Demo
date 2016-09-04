//
//  NEUCover.m
//  NEUGank
//
//  Created by 周鑫城 on 8/12/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUCover.h"

@implementation NEUCover

+(instancetype)show
{
    NEUCover *cover = [[NEUCover alloc] init];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.5;
    cover.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    return cover;
}


@end
