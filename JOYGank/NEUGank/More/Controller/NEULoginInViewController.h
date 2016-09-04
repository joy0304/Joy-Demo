//
//  NEULoginInViewController.h
//  NEUGank
//
//  Created by Joy on 16/8/6.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sendValue)(NSString *value);

@interface NEULoginInViewController : UIViewController

@property (nonatomic, copy)sendValue sendValueBlock;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)loginIn:(id)sender;

@end
