//
//  NEUCollectionItem.h
//  NEUGank
//
//  Created by 周鑫城 on 8/6/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUTableViewBaseItem.h"

@interface NEUCollectionItem : NEUTableViewBaseItem

@property (nonatomic, strong) NSString *articleClass;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *time;

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)title SubTitle:(NSString *)subTitle AccessoryImage:(UIImage *)accessoryImage Article:(NSString *)articleClass URL:(NSString*)urlString;

@end
