//
//  CloudAPI.h
//  NEUGank
//
//  Created by 周鑫城 on 8/10/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface CloudAPI : NSObject

/**
 *  单例
 */
+ (CloudAPI *)giveMeApi;
/**
 *  登录
 */
- (void)loginWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void(^)(id response))successBlock andFailure:(void(^)(NSError * error))failureBlock;

/**
 *  注册
 */
- (void)registerWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;

/**
 *  上传图片
 */
- (void)updataAvaterWithImg:(UIImage *)img andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;

/**
 *  更改性别
 */
- (void)updataSexWithIsMan:(NSString *)isMan andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;
/**
 *  @brief 更改你的地理 区域信息
 *
 *  @param region       <#region description#>
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 */
- (void)updateRegionWithRegion:(NSString *)region andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;


/**
 *  更改用户名
 */
- (void)updataUserNameWithName:(NSString *)name andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;
/**
 *  @brief 更改签名
 *
 *  @param signature    <#signature description#>
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 */
- (void)updataUserSignatureWithSignature:(NSString *)signature andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock;


@end
