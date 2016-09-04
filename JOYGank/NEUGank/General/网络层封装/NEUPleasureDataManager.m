//
//  NEUPleasureDataManager.m
//  NEUGank
//
//  Created by Joy on 16/7/27.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUPleasureDataManager.h"
#import "YYModel.h"

@implementation PleasureModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"imageID" : @"_id",
              @"type" : @"type",
              @"publishTime" : @"publishedAt",
              @"imageURL" : @"url" };
}
@end


@implementation NEUPleasureDataManager

+ (id)modelTransformationWithResponseObj:(id)responseObject modelClass:(Class)modelClass {

    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        id errorFlag = responseObject[@"error"];
        bool flag = [errorFlag boolValue];
        if (flag) {
            NSLog(@"网络不好，请重试");
        }
        else {
            id resultObject = responseObject[@"results"];
            if ([resultObject isKindOfClass:[NSArray class]]) {
                [resultArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[PleasureModel class] json:resultObject]];
            }
        }
    }
    return resultArray;
}
@end

