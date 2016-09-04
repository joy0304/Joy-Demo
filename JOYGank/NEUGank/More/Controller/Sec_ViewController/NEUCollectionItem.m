//
//  NEUCollectionItem.m
//  NEUGank
//
//  Created by 周鑫城 on 8/6/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUCollectionItem.h"

@implementation NEUCollectionItem

#pragma  mark - override the set item

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)title SubTitle:(NSString *)subTitle AccessoryImage:(UIImage *)accessoryImage Article:(NSString *)articleClass URL:(NSString *)urlString{
    self = [super init];
    if (self) {
       self = [super initWithImage:image Title:title SubTitle:subTitle AccessoryImage:accessoryImage];
        _articleClass = articleClass;
        _urlString = urlString;
    }
    return  self;
}
@end
