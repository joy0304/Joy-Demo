
//
//  NEUSigntureController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/9/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUSigntureController.h" 
#import <AVOSCloud/AVOSCloud.h>
#import "CloudAPI.h"

@implementation NEUSigntureController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark - set up UI
- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *saveNNButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveNickName)];
    self.navigationItem.rightBarButtonItem = saveNNButton;
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
    NSString *signature = [defaults objectForKey:@"signature"];
    signature = [self.nickTextField.text copy];
    self.sendValueBlock(self.nickTextField.text);
    [defaults setObject:signature forKey:@"signature"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self updataUserSignatureWithSignature:self.nickTextField.text andSuccess:^(id success) {
        
    } andFailure:^(NSError *error) {
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nickTextField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往
    self.sendValueBlock(self.nickTextField.text);
    [self updataUserSignatureWithSignature:self.nickTextField.text andSuccess:^(id success) {
        
    } andFailure:^(NSError *error) {
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

- (void)updataUserSignatureWithSignature:(NSString *)signature andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock {
    [[CloudAPI giveMeApi] updataUserSignatureWithSignature:signature andSuccess:^(id success) {
        
    } andFailure:^(NSError * error) {
        
    }];
}

@end
