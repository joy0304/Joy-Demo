//
//  NEUMoreViewController.m
//  NEUGank
//
//  Created by Joy on 16/6/28.
//  Copyright © 2016年 Joy. All rights reserved.
//
#import <AVOSCloud/AVOSCloud.h>
#import "NEUMoreViewController.h"
#import "NEUMoreTableViewCell.h"
#import "NEUMoreTableViewDataSource.h"
#import "NEUEditController.h"
#import "NEUCollectionViewController.h"
#import "NEUMyPassageViewController.h"
#import "NEUTopicManagement.h"
#import "NEUAllTopicViewController.h"
#import "NEUConcernedTopicVC.h"
#import "NEUSubjectViewController.h"
#import "NEUSettingController.h"
#import "UIView+NEUExtension.h"
#import <QuartzCore/QuartzCore.h>
#import "NEUPublicViewController.h"
#import "NEUTableViewBaseItem.h"
#import "NEULoginInViewController.h"
#import "CloudAPI.h"
#import "UIImageView+WebCache.h"

//设置放大后图片的宽高，为了省时间，偷了下懒，建议最好结合实际做下运算
#define BIG_IMG_WIDTH  375
#define BIG_IMG_HEIGHT 325

@interface NEUMoreViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong)UIImageView *extendImageView;
@property (nonatomic, strong)UIView *background;
@property (nonatomic, strong)NSString *defaultCache;

@end

@implementation NEUMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self.navigationItem setHidesBackButton:YES];
    NSLog(@"%ld", (long)[self.tableView numberOfSections]);
        // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - initwithstyle

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        NSLog(@"more viewcontroller fuck fuck fuck ");
        NSString *isLogin = @"0";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:isLogin forKey:@"isLogin"];
        NSString *login = [defaults objectForKey:@"isLogin"];
        NSLog(@"%@", login);
    }
    return  self;
}

#pragma mark - set UI with headview and footview
- (void)setUI{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height/3)];
    self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width-self.view.width/2.2)/2, (self.view.height/3-self.view.width/2.2)/2, self.view.width/2.2, self.view.width/2.2)];
    self.avatarView.backgroundColor = [UIColor whiteColor];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *isLog = [defaults objectForKey:@"isLogin"];
    if (isLog.intValue == 0) {
        self.avatarView.image = [UIImage imageNamed:@"default"];
    }else{
        NSString *avaterUrlString = [defaults objectForKey:@"avaterUrl"];
        [self.avatarView sd_setImageWithURL:[NSURL URLWithString:avaterUrlString] placeholderImage:[UIImage imageNamed:@"default"]];
    }
    self.avatarView.layer.cornerRadius = self.avatarView.frame.size.width/2;//裁成圆角
    self.avatarView.layer.masksToBounds = YES;//隐藏裁剪掉的部分 给图片加一个圆形边框
    self.avatarView.layer.borderWidth = 1.5f;//边框宽度
    self.avatarView.layer.borderColor = [UIColor whiteColor].CGColor;//边框颜色
    UITapGestureRecognizer *tapGesture;
    if (isLog.intValue == 0) {
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)];
    }else {
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    }
    [self.avatarView addGestureRecognizer:tapGesture];
    self.avatarView.userInteractionEnabled = YES;
    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(self.avatarView.width+60, self.avatarView.height-45, 35, 35)];
    editButton.backgroundColor = [UIColor clearColor];
    [editButton setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editProfile) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_avatarView];
    [headView addSubview:editButton];
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height/3-5, self.view.width, 1)];
    spaceView.backgroundColor = [UIColor grayColor];
    headView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:spaceView];
    self.tableView.tableHeaderView = headView;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self setUI];
}

#pragma mark - 点击头像进行登陆操作

- (void)login {
    NSLog(@"tap the avarter to login ");
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"NEULoginIn" bundle:nil];
    NEULoginInViewController *loginInViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginInController"];
    [self.navigationController pushViewControllerWithTabbarHidden:loginInViewController animated:YES];
}

#pragma mark - 点击头像放大图片
/**
 *  @brief create the extend picture
 */
- (void)tapAction {
    //初始化一个用来当做背景的View
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _background = bgView;
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgView];
    //创建显示图像的视图
    _extendImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, BIG_IMG_WIDTH, BIG_IMG_HEIGHT)];
    //要显示的图片，即要放大的图片
    [_extendImageView setImage:self.avatarView.image];
    [bgView addSubview:_extendImageView];
    _extendImageView.userInteractionEnabled = YES;
    //添加点击手势（即点击图片后退出全屏）
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    [_extendImageView addGestureRecognizer:tapGesture];
    [self shakeToShow:bgView];//放大过程中的动画
    
}

-(void)closeView{
    [_background removeFromSuperview];
}

//放大过程中出现的缓慢动画
- (void)shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
    UIButton *choosePicture = [[UIButton alloc] initWithFrame:CGRectMake(5, (self.view.height-55), 50, 50)];
    UIButton *takePicture = [[UIButton alloc] initWithFrame:CGRectMake((self.view.width-65), (self.view.height-55), 50, 50)];
    [choosePicture setBackgroundImage:[UIImage imageNamed:@"album"] forState:UIControlStateNormal];
    [takePicture setBackgroundImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [choosePicture addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    [takePicture addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:choosePicture];
    [aView addSubview:takePicture];
}

#pragma mark - 选择头像
/**
 *  @brief 相册中选择头像
 */
- (void)choose {
    NSLog(@"choose photo from library");
    UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
    PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //允许编辑，即放大裁剪
    PickerImage.allowsEditing = YES;
    //自代理
    PickerImage.delegate = self;
    //页面跳转
    [self presentViewController:PickerImage animated:YES completion:nil];
}

- (void)takePhoto {
    UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
    //获取方式:通过相机
    PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
    PickerImage.allowsEditing = YES;
    PickerImage.delegate = self;
    [self presentViewController:PickerImage animated:YES completion:nil];
    NSLog(@"take photo with camera");
}

//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.extendImageView.image = newPhoto;
    self.avatarView.image = newPhoto;
    [[CloudAPI giveMeApi] updataAvaterWithImg:newPhoto andSuccess:^(id response) {
        NSLog(@" successfully update the avaterImage");
    } andFailure:^(NSError *error) {
        NSLog(@"failed to udpate thte avaterImage");
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 修改资料

- (void)editProfile {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *login = [defaults objectForKey:@"isLogin"];
    if (login.intValue == 0) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"NEULoginIn" bundle:nil];
        NEULoginInViewController *loginInViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginInController"];
        [self.navigationController pushViewControllerWithTabbarHidden:loginInViewController animated:YES];
    }else {
        NEUEditController *editController = [[NEUEditController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:editController animated:YES];
        NSLog(@"pushed view contorller");
    }
}

#pragma mark - 创建数据源以及实现基类协议的一些方法

- (void)createDataSource {
    self.dataSource = [[NEUMoreTableViewDataSource alloc] init]; // 这一步创建了数据源
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *isLog = [defaults objectForKey:@"isLogin"];
    if (isLog.intValue == 0 && indexPath.row < 5) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请登陆" message:@"点击头像编辑登陆！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"去登录！" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定登录");
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"NEULoginIn" bundle:nil];
            NEULoginInViewController *loginInViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginInController"];
            [self.navigationController pushViewControllerWithTabbarHidden:loginInViewController animated:YES];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancel];
        [alertController addAction:confirmAction];
        [self presentViewController:alertController animated:YES completion:^{
            NSLog(@"successfully present the alertcontroller");
        }];

    }else{
        switch (indexPath.row) {
            case 0:{
                NEUCollectionViewController *collectionVC = [[NEUCollectionViewController alloc] initWithStyle:UITableViewStylePlain];
                [self.navigationController pushViewControllerWithTabbarHidden:collectionVC animated:YES];
                break;
            };
            case 1:{
//                NEUPublicViewController *mypassageVC = [[NEUPublicViewController alloc] init];
                NEUMyPassageViewController *mypassageVC = [[NEUMyPassageViewController alloc] initWithStyle:UITableViewStylePlain];
                [self.navigationController pushViewControllerWithTabbarHidden:mypassageVC animated:YES];
                break;
            };
            case 3:{
                NEUTopicManagement *topicVC = [[NEUTopicManagement alloc] initWithStyle:UITableViewStylePlain];
                [self.navigationController pushViewControllerWithTabbarHidden:topicVC animated:YES];
                break;
            };
            case 5:{
                NEUSettingController *setterController = [[NEUSettingController alloc] initWithStyle:UITableViewStylePlain];
                __weak NEUMoreViewController *settingController = self;
                setterController.sendValueBlock = ^(NSString *str) {
                    settingController.avatarView.image = [UIImage imageNamed:str];
                    NSLog(@"change the avarterview");
                };
                [self.navigationController pushViewControllerWithTabbarHidden:setterController animated:YES];
                break;
            };
            default:
                NSLog(@" switch the default");
                break;
        }

    }
    NSLog(@"section = %ld, row = %ld ", indexPath.section, indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSLog(@"%ld", section);
    return 50;
}


@end
