//
//  NEURegistController.h
//  NEUGank
//
//  Created by 周鑫城 on 8/10/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NEURegistController : UIViewController


@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *passWordTF;
@property (nonatomic, strong) UIButton *registerButton;

- (void)registerWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;

@end
