//
//  NEUMyPassageItem.m
//  NEUGank
//
//  Created by 周鑫城 on 8/10/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUMyPassageItem.h"

@implementation NEUMyPassageItem

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)desc SubTitle:(NSString *)publishedTime AccessoryImage:(UIImage *)accessoryImage ArticleClass:(NSString *)articleClass ImageUrl:(NSString *)imageUrl URL:(NSString *)urlString{
    self = [super initWithImage:image Title:desc SubTitle:publishedTime AccessoryImage:accessoryImage];
    if (self) {
        _articleClass = articleClass;
        _imageUrl = imageUrl;
        _urlString = urlString;
    }
    return self;
}

@end
