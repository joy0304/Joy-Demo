//
//  NEUHomeDataManager.m
//  NEUGank
//
//  Created by Joy on 16/7/12.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUHomeDataManager.h"
#import "YYModel.h"

@implementation HomeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"userName" : @"who",
              @"describe" : @"desc",
              @"publishTime" : @"publishedAt",
              @"detailURL" : @"url" };
}

@end

@implementation NEUHomeDataManager

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
                [resultArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HomeModel class] json:resultObject]];
            }
        }
    }
    return resultArray;
}



@end
