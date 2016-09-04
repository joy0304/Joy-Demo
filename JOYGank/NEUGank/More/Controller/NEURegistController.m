//
//  NEURegistController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/10/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEURegistController.h"
#import <AVOSCloud/AVOSCloud.h>


@implementation NEURegistController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];

}

- (void)setUI {
    [self.view addSubview:self.userNameTF];
    [self.view addSubview:self.passWordTF];
    [self.view addSubview:self.registerButton];
}

- (UITextField *)userNameTF {
    if (!_userNameTF) {
        _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 100, NEUAPPWIDTH - 5, 40)];
        _userNameTF.layer.borderWidth = 0.5f;
        _userNameTF.layer.borderColor = [UIColor grayColor].CGColor;
        _userNameTF.backgroundColor = [UIColor whiteColor];
        _userNameTF.placeholder = @"请输入用户名";
    }
    return  _userNameTF;
}

- (UITextField *)passWordTF {
    if (!_passWordTF) {
        _passWordTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userNameTF.frame), 141, NEUAPPWIDTH - 5, 40)];
        _passWordTF.layer.borderWidth = 0.5f;
        _passWordTF.layer.borderColor = [UIColor grayColor].CGColor;
        _passWordTF.backgroundColor = [UIColor whiteColor];
        _passWordTF.placeholder = @"请输入密码";
        _passWordTF.secureTextEntry = YES;
    }
    return _passWordTF;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 220, 300, 40)];
        _registerButton.layer.cornerRadius = 10;
        [_registerButton.layer masksToBounds];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        _registerButton.backgroundColor = [UIColor blueColor];
        [_registerButton setTintColor:[UIColor blueColor]];
        [_registerButton addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (void)registerWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock
{
    NSLog(@"regist button clicked");
    AVUser * user = [AVUser user];
    user.username = userName;
    user.password = passWord;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            NSLog(@"regist successed");
            successBlock(nil);
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误信息" message:@"用户名和密码不能为空！！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"重新注册");
            }];
            [alertController addAction:confirmAction];
            [self presentViewController:alertController animated:YES completion:^{
                NSLog(@"successfully present the alertcontroller");
            }];

            NSLog(@"regist failed");
            failureBlock(error);
        }
    }];
}

- (void)regist {
    NSLog(@"regist button clicked");
    [self registerWithUserName:self.userNameTF.text andPassWord:self.passWordTF.text andSuccess:^(id respons){
            NSLog(@"regist ing");
    } andFailure:^(NSError *error) {
            NSLog(@"regist failing");
    }];
}

//判断字符串是否为空或空格
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


@end
