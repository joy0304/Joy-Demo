//
//  NEUHTTPService.h
//  NEUGank
//
//  Created by Joy on 16/7/1.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NEUHTTPService : NSObject

/**
 GET请求转模型
 */
+ (nullable NSURLSessionDataTask *)getWithURL:(NSString *)URLString
                          parameters:(nullable id)parameters
                          modelClass:(Class)modelClass
                       responseHandler:(nullable void (^)(id responseObject, NSError *error))responseDataHandler;
/**
 POST请求转模型
 */
+ (nullable NSURLSessionDataTask *)postWithURL:(NSString *)URLString
                                   parameters:(nullable id)parameters
                                   modelClass:(Class)modelClass
                              responseHandler:(nullable void (^)(id responseObject, NSError *error))responseDataHandler;
/**
 数组、字典转模型，提供给子类的接口
 */
+ (id)modelTransformationWithResponseObj:(id)responseObject modelClass:(Class)modelClass;


@end
NS_ASSUME_NONNULL_END