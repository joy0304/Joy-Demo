//
//  NEUSettingController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/4/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUSettingController.h"
#import "NEUSettingDataSource.h"
#import "UIView+NEUExtension.h"
#import "NEUTableViewSectionObject.h"
#import "NEUTableViewBaseItem.h"
#import "NEUAboutUs.h"
#import "UMSocialSnsService.h"
#import "UMSocialControllerService.h"
#import "NEULoginInViewController.h"
#import "UMSocialSnsPlatformManager.h"

@interface NEUSettingController ()

@property (nonatomic, strong) NSString *defaultCache;

@end

@implementation NEUSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的设置";
    self.tableView.tableFooterView = self.logButton;
}

- (UIButton *)logButton {
    if (!_logButton) {
        _logButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 70)];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *isLogin = [defaults objectForKey:@"isLogin"];
        if (isLogin.intValue == 0) {
            [_logButton setTitle:@"点击登录" forState:UIControlStateNormal];
            [_logButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }else{
            [_logButton setTitle:@"取消登录" forState:UIControlStateNormal];
            [_logButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
        [_logButton addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
        _logButton.enabled = YES;

    }
    return _logButton;
}

- (void)createDataSource {
    self.dataSource = [[NEUSettingDataSource alloc] init];
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"this is my passage view controller selcted :%ld", indexPath.row);
//    if (indexPath.row == 0) {
//        NEUTableViewSectionObject *theSection = (NEUTableViewSectionObject *)self.dataSource.sections[indexPath.section];
//        NEUTableViewBaseItem *theItem = (NEUTableViewBaseItem *)theSection.items[indexPath.row];
//        theItem.itemSubtitle = @"";
//        [self.tableView reloadData];
//    }
    switch (indexPath.row) {
        case 0:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"缓存清除" message:@"确定清除缓存" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消！" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"取消清除缓存");
            }];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定！" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"确定清除缓存！");
                [self clearCaches];
                NEUTableViewSectionObject *theSection = (NEUTableViewSectionObject *)self.dataSource.sections[indexPath.section];
                NEUTableViewBaseItem *theItem = (NEUTableViewBaseItem *)theSection.items[indexPath.row];
                theItem.itemSubtitle = @"";
                [self.tableView reloadData];//刷新表视图
            }];
            [alertController addAction:confirm];
            [alertController addAction:cancel];
            [self presentViewController:alertController animated:YES completion:^{
                NSLog(@"successfully present the alertcontroller");
            }];
            break;
        };
        case 1:{
            NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id1067269736"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            NSLog(@"模拟器不能评价  使用真机！！！");
            break;
        };
        case 2:{
            NSLog(@"推荐给朋友");
            [UMSocialSnsService presentSnsIconSheetView:self appKey:nil
                                              shareText:@"快快加入干货集中营，技术者的栖息地！" shareImage:[UIImage imageNamed:@"sharePicture.jpg"]
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToQQ,nil]
                                               delegate:nil];
            break;
        };
        case 3:{
            NEUAboutUs *aboutUsVC = [[NEUAboutUs alloc] initWithAboutUSString:@"http://www.martinwjl.cn/"];
            [self.navigationController pushViewControllerWithTabbarHidden:aboutUsVC animated:YES];
            break;
        };
        default:
            break;
    }
    
}


- (void)logOut:(UIButton *)sender {
    if (sender) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        __block NSString *islogin = [defaults objectForKey:@"isLogin"];
        if (islogin.intValue == 0) {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"NEULoginIn" bundle:nil];
            NEULoginInViewController *loginInViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginInController"];
            __weak NEUSettingController *setter = self;
            loginInViewController.sendValueBlock = ^(NSString* str) {
                [setter.logButton setTitle:str forState:UIControlStateNormal];
                [setter.logButton setTintColor:[UIColor redColor]];
            };
            [self.navigationController pushViewControllerWithTabbarHidden:loginInViewController animated:YES];
        }else{
        
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"取消退出登录");
            }];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"确定退出登录");
                islogin = [@"0" copy];
                [defaults setObject:islogin forKey:@"isLogin"];
                
                self.sendValueBlock(@"default");
                [self.logButton setTitle:@"点击登入" forState:UIControlStateNormal];
                [_logButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:confirmAction];
            [self presentViewController:alertController animated:YES completion:^{
            NSLog(@"successfully present the alertcontroller");
        }];
            NSLog(@" log out the app");
        }
    }
}

 #pragma mark - 清除缓存

- (void)clearCaches {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    [fileManager removeItemAtPath:cacheFilePath error:nil];
    NSUserDefaults *cacheDefault = [NSUserDefaults standardUserDefaults];
    NSString *cacheStr = [(NEUSettingDataSource *)self.dataSource getCacheSize];
    NSLog(@"cacheStr cacheStr cacheStr == %@", cacheStr);
    [cacheDefault setObject:cacheStr forKey:@"cache"];

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    05 ：04和05使用其一即可
}

#pragma -mark -放置于.m文件首段较为合适,实时监测缓存大小，从其他界面跳转到本页面，也需要刷新下表视图
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

@end
