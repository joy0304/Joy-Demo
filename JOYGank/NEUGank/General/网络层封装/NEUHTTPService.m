//
//  NEUHTTPService.m
//  NEUGank
//
//  Created by Joy on 16/7/1.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUHTTPService.h"
#import "NEUHTTPSessionManager.h"

@implementation NEUHTTPService

+ (nullable NSURLSessionDataTask *)getWithURL:(NSString *)URLString
                                   parameters:(nullable id)parameters
                                   modelClass:(Class)modelClass
                              responseHandler:(nullable void (^)(id responseObject, NSError *error))responseDataHandler {
    NSURLSessionDataTask *dataTask = [[NEUHTTPSessionManager jsonClient]GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        id dataObject;
        dataObject = [self modelTransformationWithResponseObj:responseObject modelClass:modelClass];
        responseDataHandler(dataObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseDataHandler(nil, error);
    }];
    
    return dataTask;
}

+ (nullable NSURLSessionDataTask *)postWithURL:(NSString *)URLString
                                    parameters:(nullable id)parameters
                                    modelClass:(Class)modelClass
                               responseHandler:(nullable void (^)(id responseObject, NSError *error))responseDataHandler {
    NSURLSessionDataTask *dataTask = [[NEUHTTPSessionManager jsonClient] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        id dataObject;
        dataObject = [self modelTransformationWithResponseObj:responseObject modelClass:modelClass];
        responseDataHandler(dataObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseDataHandler(nil, error);
    }];
    
    return dataTask;
}

+ (id)modelTransformationWithResponseObj:(id)responseObject modelClass:(Class)modelClass {
    return nil;
}

@end
