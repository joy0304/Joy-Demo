//
//  NEULoginInViewController.m
//  NEUGank
//
//  Created by Joy on 16/8/6.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEULoginInViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MBProgressHUD.h"
#import "NEUMoreViewController.h"
#import "NEURegistController.h"
#import "CloudAPI.h"

@interface NEULoginInViewController ()

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation NEULoginInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.layer.cornerRadius = 60;
    [self.imageView.layer masksToBounds];
    
    self.passWord.secureTextEntry = YES;
}

- (void)loginWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
        [[CloudAPI giveMeApi] loginWithUserName:userName andPassWord:passWord andSuccess:^(id response) {
            
            if (self.sendValueBlock != nil) {
                self.sendValueBlock(@"退出登录");
            }
            [self.navigationController popViewControllerAnimated:YES];
            successBlock(nil);
        } andFailure:^(NSError *error) {
            failureBlock(error);
            NSLog(@"avuser failed");
            _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            _HUD.label.text = @"密码或者用户名不正确";
            [_HUD hideAnimated:YES afterDelay:1.0];
       }];
}



- (IBAction)loginIn:(id)sender {
    [self loginWithUserName:self.userName.text andPassWord:self.passWord.text andSuccess:^(id qwq) {
        
    } andFailure:^(NSError * qwe) {
        
    }];
}

- (IBAction)regist:(UIButton *)sender {
    NEURegistController *registerVC =[[NEURegistController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    NSLog(@"regist controller");
}
//
//[AVUser logInWithUsernameInBackground:userName password:passWord block:^(AVUser *user, NSError *error) {
//    if (user != nil)
//    {
//        //存入objectId
//        NSString * objectId = [user objectForKey:@"objectId"];
//        [[NSUserDefaults standardUserDefaults]setObject:objectId forKey:@"objectId"];
//        NSLog(@"objectId:%@",objectId);
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSMutableString *mutableIsLog = [NSMutableString stringWithString:@"1"];
//        NSString *islog = [mutableIsLog copy];
//        [defaults setObject:islog forKey:@"isLogin"];
//        
//        //            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        //            NSString *gender = [defaults objectForKey:@"gender"];
//        //            gender = [regionItem.itemTitle copy];
//        //            [defaults setObject:gender forKey:@"gender"];
//        //
//        [defaults setObject:[user objectForKey:@"gender"] forKey:@"gender"];
//        [defaults setObject:[user objectForKey:@"nickName"] forKey:@"nickName"];
//        [defaults setObject:[user objectForKey:@"region"] forKey:@"region"];
//        [defaults setObject:[user objectForKey:@"avaterUrl"] forKey:@"avaterUrl"];
//        [defaults setObject:[user objectForKey:@"signature"] forKey:@"signature"];
//        
//        

        //            NSDictionary * userDic = @{
        //                                       @"nickName":[user objectForKey:@"nickName"] == nil ?@"":[user objectForKey:@"nickName"],
        //
        //                                       @"gender":[user objectForKey:@"gender"] == nil ?@"":[user objectForKey:@"gender"],
        //
        ////                                       @"ID":[user objectForKey:@"ID"] == nil?@"":[user objectForKey:@"wxID"],
        //
        //                                       @"avaterUrl":[user objectForKey:@"avaterUrl"] == nil?@"":[user objectForKey:@"avaterUrl"],
        //
        //                                       @"signature":[user objectForKey:@"signature"] == nil?@"":[user objectForKey:@"signature"],
        //                                       @"region":[user objectForKey:@"region"] == nil?@"":[user objectForKey:@"region"]
        //                                       };
        //            NSLog(@"%@", userDic);
        //            [[NSUserDefaults standardUserDefaults]setObject:userDic forKey:@"userInfo"];
    
//    
//    let query = AVQuery(className: "AllUser")
//    query.whereKey("userName", equalTo: self.userName.text)
//    query.getFirstObjectInBackgroundWithBlock { (isUser, e) -> Void in
//        
//        let localData = isUser!.valueForKey("localData")
//        let leanUser = localData?.valueForKey("userName") as! String
//        let leanPass = localData?.valueForKey("password") as! String
//        guard isUser != nil else{
//            self.userName.becomeFirstResponder()
//            self.errorNotice("用户不存在")
//            return
//        }
//        guard self.password.text == leanPass else{
//            self.userName.becomeFirstResponder()
//            self.errorNotice("密码不正确")
//            return
//        }

//    AVQuery *query = [AVQuery queryWithClassName:@"NEUUser"];
//    [query whereKey:@"userName" equalTo:self.userName.text];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if ([objects count] == 0) {
//            _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            _HUD.label.text = @"用户不存在";
//            [_HUD hideAnimated:YES afterDelay:2.0];
//        }
//        else {
//            AVObject *obj = objects[0];
//            id data = obj[@"localData"];
//            NSLog(@"%@", obj);
//            if ([data isKindOfClass:[NSDictionary class]]) {
//                if ([self.passWord.text isEqualToString:data[@"password"]]) {
//                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                    NSLog(@"%@",data[@"password"]);
//                    NSLog(@"%@", data[@"gender"]);
//                    NSString *gender = data[@"gender"];
//                    [defaults setObject:gender forKey:@"gender"];
//                    NSLog(@"gender = %@", [defaults objectForKey:@"gender"]);
//                    NSString *nickName = data[@"nickName"];
//                    [defaults setObject:nickName forKey:@"nickName"];
//                    NSLog(@"nickname = %@", [defaults objectForKey:@"nickName"]);
//                    NSString *region = data[@"region"];
//                    [defaults setObject:region forKey:@"region"];
//                    NSLog(@"region = %@", [defaults objectForKey:@"region"]);
//                    NSString *signature = data[@"signature"];
//                    NSLog(@"signature = %@" , signature);
//                    [defaults setObject:signature forKey:@"signature"];
//                    NSLog(@"region = %@", [defaults objectForKey:@"signature"]);
//                    NSMutableString *mutableIsLog = [NSMutableString stringWithString:@"1"];
//                    NSString *islog = [mutableIsLog copy];
//                    [defaults setObject:islog forKey:@"isLogin"];
//                    NSString *zxc = [defaults objectForKey:@"isLogin"];
//                    NSLog(@"zxc.intValue = %d", zxc.intValue);
//                    NSString *objectId = obj.objectId;
//                    NSLog(@"objectId = %@", objectId);
//                    [defaults setObject:objectId forKey:@"objectId"];
//                    if (self.sendValueBlock != nil) {
//                        self.sendValueBlock(@"退出登录");
//                    }
//                    [self.navigationController popViewControllerAnimated:YES];
//                }
//                else {
//
//                    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                    _HUD.label.text = @"密码不正确";
//                    [_HUD hideAnimated:YES afterDelay:1.0];
//                }
//            }
//        }
//
//
//    }];




@end
