//
//  CloudAPI.m
//  NEUGank
//
//  Created by 周鑫城 on 8/10/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "CloudAPI.h"

@implementation CloudAPI
+ (CloudAPI *)giveMeApi
{
    static CloudAPI * api = nil;
    if (api == nil) {
        api = [[CloudAPI alloc]init];
    }
    return api;
}

- (void)loginWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
    [AVUser logInWithUsernameInBackground:userName password:passWord block:^(AVUser *user, NSError *error) {
        if (user != nil)
        {
            //存入objectId
            NSString * objectId = [user objectForKey:@"objectId"];
            [[NSUserDefaults standardUserDefaults]setObject:objectId forKey:@"objectId"];
            NSLog(@"objectId:%@",objectId);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSMutableString *mutableIsLog = [NSMutableString stringWithString:@"1"];
            NSString *isLogin = [mutableIsLog copy];
            [defaults setObject:isLogin forKey:@"isLogin"];
            [defaults setObject:[user objectForKey:@"gender"] forKey:@"gender"];
            [defaults setObject:[user objectForKey:@"nickName"] forKey:@"nickName"];
            [defaults setObject:[user objectForKey:@"region"] forKey:@"region"];
            [defaults setObject:[user objectForKey:@"avaterUrl"] forKey:@"avaterUrl"];
            [defaults setObject:[user objectForKey:@"signature"] forKey:@"signature"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            successBlock(nil);
        }
        else
        {
            failureBlock(error);
        }
    }];
}

- (void)registerWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock
{
    AVUser * user = [AVUser user];
    user.username = userName;
    user.password = passWord;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            successBlock(nil);
        }
        else
        {
            failureBlock(error);
        }
    }];
}

- (void)updataAvaterWithImg:(UIImage *)img andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock {
    
    NSData *imageData = UIImagePNGRepresentation(img);
    AVFile *imageFile = [AVFile fileWithName:@"image.png" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded)
        {
            AVUser *currentUser = [AVUser currentUser];
            currentUser[@"avaterUrl"] = imageFile.url;
            NSLog(@"%@", currentUser[@"avaterUrl"]);
            [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
             {
                 if (succeeded)
                 {
                     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                     [defaults setObject:imageFile.url forKey:@"avaterUrl"];
                     [defaults synchronize];
                     NSLog(@"%@", [defaults objectForKey:@"avaterUrl"]);
                     successBlock(imageFile.url);
                 }
                 else
                 {
                     failureBlock(error);
                 }
             }];
            
        }
        
    } progressBlock:^(NSInteger percentDone) {
        
    }];
    
}

- (void)updataSexWithIsMan:(NSString *)isMan andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
    AVUser *currentUser = [AVUser currentUser];
    currentUser[@"gender"] = isMan;
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
//            NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
//            NSMutableDictionary * muDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
//            [muDic setObject:[NSNumber numberWithInt:isMan] forKey:@"sex"];
//            [[NSUserDefaults standardUserDefaults]setObject:[muDic copy] forKey:wUserInfo];
//            [[NSUserDefaults standardUserDefaults]synchronize];
            NSLog(@"更改性别成功");
            successBlock(nil);
        }
        else
        {
            NSLog(@"更改性别 failed");
            failureBlock(error);
        }
    }];
    
}

- (void)updataUserNameWithName:(NSString *)name andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
    AVUser *currentUser = [AVUser currentUser];
    currentUser[@"nickName"] = name;
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
//            NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
//            NSMutableDictionary * muDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
//            [muDic setObject:name forKey:@"nickName"];
//            [[NSUserDefaults standardUserDefaults]setObject:[muDic copy] forKey:wUserInfo];
//            [[NSUserDefaults standardUserDefaults]synchronize];
            NSLog(@"更改昵称成功");
            successBlock(nil);
        }
        else
        {
            failureBlock(error);
        }
    }];
}

- (void)updataUserSignatureWithSignature:(NSString *)signature andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock {
    AVUser *currentUser = [AVUser currentUser];
    currentUser[@"signature"] = signature;
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            NSLog(@"更改签名成功");
            successBlock(nil);
        }
        else
        {
            failureBlock(error);
        }
    }];

}

- (void)updateRegionWithRegion:(NSString *)region andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock {
    AVUser *currentUser = [AVUser currentUser];
    currentUser[@"region"] = region;
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            NSLog(@"更改地区成功");
            successBlock(nil);
        }
        else
        {
            failureBlock(error);
        }
    }];

}


@end
