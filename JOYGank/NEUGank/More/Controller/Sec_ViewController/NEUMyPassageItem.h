//
//  NEUMyPassageItem.h
//  NEUGank
//
//  Created by 周鑫城 on 8/10/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUTableViewBaseItem.h"

@interface NEUMyPassageItem : NEUTableViewBaseItem

@property (nonatomic, strong) NSString *articleClass;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *publishedTime;
@property (nonatomic, strong) NSString *urlString;

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)desc SubTitle:(NSString *)publishedTime AccessoryImage:(UIImage *)accessoryImage ArticleClass:(NSString *)articleClass ImageUrl:(NSString *)imageUrl URL:(NSString *)urlString;

@end
