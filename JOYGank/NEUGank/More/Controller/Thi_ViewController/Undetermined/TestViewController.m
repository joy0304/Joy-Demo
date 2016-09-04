//
//  TestViewController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/9/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "TestViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "NEULoginInViewController.h"

@implementation TestViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"NEULoginIn" bundle:nil];
    NEULoginInViewController *loginInViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginInController"];
    [self.navigationController pushViewControllerWithTabbarHidden:loginInViewController animated:YES];
//    [self setUI];
//    self.view.backgroundColor = [UIColor whiteColor];
//    AVObject *obj = [AVObject objectWithClassName:@"NEUUser" objectId:@"57a97df5165abd00616d844c"];
//    AVQuery *query = [AVQuery queryWithClassName:@"NEUUser"];
//    [query getObjectInBackgroundWithId:@"57a97df5165abd00616d844c" block:^(AVObject *object, NSError *error) {
//        if (!error) {
//            
//        }
//    }];
//    UIImage *avarter = [UIImage imageNamed:@"android"];
//    NSData *image1 = UIImagePNGRepresentation(avarter);
//    AVFile *photo = [AVFile fileWithName:@"photo.png" data:image1];
//    [obj setObject:photo forKey:@"userPicture"];
//    [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        NSLog(@"%d", succeeded);
//    }];
}

- (void)setUI {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 300, 300)];
    [self.view addSubview:self.imageView];
}


////    AVQuery *query = [AVQuery queryWithClassName:@"UserPicture"];
//    NSData *data = [@"作经历" dataUsingEncoding:NSUTF8StringEncoding];
//    AVFile *file = [AVFile fileWithName:@"resume.txt" data:data];
//    UIImage *image = [UIImage imageNamed:@"AppIcon"];
//    NSData *imageData = UIImagePNGRepresentation(image);
//    AVFile *file1 = [AVFile fileWithName:@"AppIcon.png" data:imageData];
//    [file1 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        NSLog(@"%@", file.url);//返回一个唯一的 Url 地址
//    }];
//}

//        NSString *nickName = data[@"nickName"];
//        NSLog(@"%@", nickName);
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:nickName forKey:@"user_nickName"];
//        NSString *hello = [defaults objectForKey:@"user_nickName"];
//        NSMutableString *hello1 = [NSMutableString stringWithString:hello];
//        [hello1 appendString:@"asa"];
//        NSLog(@"%@", hello1);
//        nickName = [hello1 copy];
//        [defaults setObject:nickName forKey:@"user_nickName"];
//        NSString *hello2 = [defaults objectForKey:@"user_nickName"];
//        NSLog(@"%@", hello2);
@end

