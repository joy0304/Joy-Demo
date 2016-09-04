//
//  NEUFindDataManager.m
//  NEUGank
//
//  Created by Joy on 16/8/2.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUFindDataManager.h"

@implementation NEUFindDataManager

+ (id)modelTransformationWithResponseObj:(id)responseObject modelClass:(Class)modelClass {
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        id errorFlag = responseObject[@"error"];
        bool flag = [errorFlag boolValue];
        if (flag) {
            NSLog(@"网络不好，请重试");
        }
        else {
            return responseObject;
        }
    }
    return resultArray;
}

@end
