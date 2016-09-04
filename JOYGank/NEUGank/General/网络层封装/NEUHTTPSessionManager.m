//
//  NEUHTTPSessionManager.m
//  NEUGank
//
//  Created by Joy on 16/6/29.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUHTTPSessionManager.h"
#import "AFURLResponseSerialization.h"
#import "AFNetworking.h"

@implementation NEUHTTPSessionManager

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
    self = [self initWithSessionConfiguration:configuration timeoutInterval:5.0];
    return self;
}

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration timeoutInterval:(NSTimeInterval) timeoutInterval {
    self = [super initWithSessionConfiguration:configuration];
    if (self) {
        self.requestSerializer.timeoutInterval = timeoutInterval;
    }
    return self;
}

+ (instancetype)jsonClient {
    static NEUHTTPSessionManager *_jsonClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _jsonClient = [[NEUHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        _jsonClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    return _jsonClient;
}

+ (instancetype)httpClient {
    static NEUHTTPSessionManager *_httpClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _httpClient = [[NEUHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        _httpClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return _httpClient;
}

#pragma mark - GET methods
- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *progress))progress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError *error))failure; {
    void (^neuSuccess)(NSURLSessionDataTask *, id) =  ^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(task, responseObject);
        }
    };
    void (^neuFailure)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    };
    return [super GET:URLString parameters:parameters progress:progress success:neuSuccess failure:neuFailure];

}

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError *error))failure {
    return [self GET:URLString parameters:parameters progress:nil success:success failure:failure];
}

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                               success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError *error))failure {
    return [self GET:URLString parameters:nil progress:nil success:success failure:failure];
}

#pragma mark - POST methods
- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *progress))progress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError *error))failure {
    void (^neuSuccess)(NSURLSessionDataTask *, id) =  ^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(task, responseObject);
        }
    };
    void (^neuFailure)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    };
    return [super POST:URLString parameters:parameters progress:progress success:neuSuccess failure:neuFailure];
}

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))neuSuccess
                                failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError *error))neuFailure {
    return [self POST:URLString parameters:parameters progress:nil success:neuSuccess failure:neuFailure];
}


@end
