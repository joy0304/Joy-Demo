//
//  NEUSignalViewController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/2/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUSignalViewController.h"

@implementation NEUSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark - set up UI
- (void)setUI {
    self.title = @"签名";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *saveNNButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveNickName)];
    self.navigationItem.rightBarButtonItem = saveNNButton;
    //    UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/10)];
    //    nickLabel.text = @"请输入你的签名";
    //    nickLabel.textAlignment = NSTextAlignmentLeft;
    self.signalTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height/10)];
    self.signalTextField.textAlignment = NSTextAlignmentLeft;
    self.signalTextField.placeholder = @"请输入你的签名";
    self.signalTextField.textColor = [UIColor  blackColor];
    //    self.signalTextField.text = @"请输入你的签名";
    self.signalTextField.backgroundColor = [UIColor whiteColor];
    self.signalTextField.userInteractionEnabled = YES;
    self.signalTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.signalTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.signalTextField.returnKeyType = UIReturnKeyDone;
    self.signalTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.signalTextField.delegate = self;
    [self.view addSubview:self.signalTextField];
    NSLog(@"%@", @"请输入你的签名");
}

- (void)saveNickName {
    NSLog(@"%@", @"保存");
    self.sendValueBlock(self.signalTextField.text);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.signalTextField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往
    self.sendValueBlock(self.signalTextField.text);
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

@end
