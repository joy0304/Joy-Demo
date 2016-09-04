//
//  NEUHTTPSessionManager.h
//  NEUGank
//
//  Created by Joy on 16/6/29.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface NEUHTTPSessionManager : AFHTTPSessionManager

/**
 *  初始化 AFHTTPSessionManager
 */
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration timeoutInterval:(NSTimeInterval) timeoutInterval;

/**
 *  初始化 NEUHTTPSessionManager
 */
+ (instancetype)jsonClient;
+ (instancetype)httpClient;

/**
 *  GET REQUEST
 *
 *  @param URLString  请求的 URL
 *  @param parameters 请求参数
 *  @param progress   进度
 *  @param neuSuccess 成功后的回调
 *  @param neuFailure 失败后的回调
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress *progress))progress
                               success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))neuSuccess
                               failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError *error))neuFailure;

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))neuSuccess
                               failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError *error))neuFailure;

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                               success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))neuSuccess
                               failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError *error))neuFailure;

/**
 *  POST REQUEST
 *
 *  @param URLString  请求的 URL
 *  @param parameters 请求参数
 *  @param progress   进度
 *  @param neuSuccess 成功后的回调
 *  @param neuFailure 失败后的回调
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *progress))progress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))neuSuccess
                                failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError *error))neuFailure;

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))neuSuccess
                                failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError *error))neuFailure;

@end
NS_ASSUME_NONNULL_END