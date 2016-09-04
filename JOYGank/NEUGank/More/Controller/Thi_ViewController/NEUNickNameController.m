//
//  NEUNickNameController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/2/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUNickNameController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CloudAPI.h"

@implementation NEUNickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark - set up UI
- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *saveNNButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveNickName)];
    self.navigationItem.rightBarButtonItem = saveNNButton;
//    UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/10)];
//    nickLabel.text = @"请输入你的昵称";
//    self.nickTextField.textAlignment = NSTextAlignmentLeft;
    self.nickTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height/10)];
    NSMutableString *prePlaceOrder = [NSMutableString stringWithString:@"请输入你的"];
    [prePlaceOrder appendFormat:@"%@",self.title];
    self.nickTextField.placeholder = [prePlaceOrder copy];
    self.nickTextField.textAlignment = NSTextAlignmentLeft;
    self.nickTextField.textColor = [UIColor  blackColor];
    self.nickTextField.backgroundColor = [UIColor whiteColor];
    self.nickTextField.userInteractionEnabled = YES;
    self.nickTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nickTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.nickTextField.returnKeyType = UIReturnKeyDone;
    self.nickTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.nickTextField.delegate = self;
    [self.view addSubview:self.nickTextField];

}

- (void)saveNickName {
    NSLog(@"%@", @"保存");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *nickName = [defaults objectForKey:@"nickName"];
    nickName = [self.nickTextField.text copy];
    [defaults setObject:nickName forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self updataUserNameWithName:nickName andSuccess:^(id name) {
        
    } andFailure:^(NSError * error) {
        
    }];
//    AVObject *userData = [AVObject objectWithClassName:@"NEUUser" objectId:[defaults objectForKey:@"objectId"]];
//    [userData setObject:nickName forKey:@"nickName"];
//    [userData saveInBackground];
    self.sendValueBlock(self.nickTextField.text);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nickTextField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往
    self.sendValueBlock(self.nickTextField.text);
    [self updataUserNameWithName:self.nickTextField.text andSuccess:^(id name) {
        
    } andFailure:^(NSError * error) {
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

- (void)updataUserNameWithName:(NSString *)name andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock {
    [[CloudAPI giveMeApi] updataUserNameWithName:name andSuccess:^(id response) {
        NSLog(@"updatae the nick name successfully");
    } andFailure:^(NSError *error) {
        NSLog(@"update the nickname failed");
    }];
}

@end
