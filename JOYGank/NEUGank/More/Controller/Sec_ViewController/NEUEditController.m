//
//  NEUEditController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/2/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUEditController.h"
#import "NEUEditTableViewDataSource.h"
#import "NEUEditTableViewCell.h"
#import "NEUNickNameController.h"
#import "NEURegionViewController.h"
#import "NEUSignalViewController.h"
#import "NEUTableViewSectionObject.h"
#import "NEUTableViewBaseItem.h"
#import "TLCityPickerController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "UIView+NEUExtension.h"
#import "NEUTableViewSectionObject.h"
#import "NEUTableViewBaseItem.h"
#import "NEUSigntureController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CloudAPI.h"

@interface NEUEditController() <TLCityPickerDelegate,CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong)  NSString * cityName;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *attributeArr;
@end

@implementation NEUEditController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"编辑个人中心";
}

- (void)setUI{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height/3)];
    _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/4, (self.view.height/3-self.view.width/2)/2, self.view.width/2, self.view.width/2)];
    _avatarView.backgroundColor = [UIColor whiteColor];
    _avatarView.image = [UIImage imageNamed:@"image_05"];
    _avatarView.layer.cornerRadius = _avatarView.frame.size.width/2;//裁成圆角
    _avatarView.layer.masksToBounds = YES;//隐藏裁剪掉的部分
    //  给图片加一个圆形边框
    _avatarView.layer.borderWidth = 1.5f;//边框宽度
    _avatarView.layer.borderColor = [UIColor whiteColor].CGColor;//边框颜色
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alterHeadPortrait:)];
    [_avatarView addGestureRecognizer:tapGesture];
    _avatarView.userInteractionEnabled = YES;
    [headView addSubview:_avatarView];
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height/3-5, self.view.width, 1)];
    spaceView.backgroundColor = [UIColor grayColor];
    headView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:spaceView];
    self.tableView.tableHeaderView = headView;
    
}

#pragma mark - 点击头像编辑图像
/**
 *  弹出提示框
 */
-(void)alterHeadPortrait:(UITapGestureRecognizer *)gesture{
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
        //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    _avatarView.image = newPhoto;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createDataSource {
    self.dataSource = [[NEUEditTableViewDataSource alloc] init];// 这一步创建了数据源
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TO DO

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            NEUNickNameController *nickNameController = [[NEUNickNameController alloc] init];
            nickNameController.title = @"昵称";
            __weak NEUEditController *editController = self;
            nickNameController.sendValueBlock = ^(NSString *str){
                NEUTableViewSectionObject *sectionObject = editController.dataSource.sections[indexPath.section];
                sectionObject.items[indexPath.row] = [[NEUTableViewBaseItem alloc] initWithImage:nil Title:str SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]];
                [self.tableView reloadData];
                NSLog(@"change the qiefude qiezi ");
            };
            [self.navigationController pushViewController:nickNameController animated:YES];
            break;
        };
        case 1:{
            NEUSigntureController *nickNameController = [[NEUSigntureController alloc] init];
            nickNameController.title = @"签名";
            __weak NEUEditController *editController = self;
            nickNameController.sendValueBlock = ^(NSString *str){
                NEUTableViewSectionObject *sectionObject = editController.dataSource.sections[indexPath.section];
                sectionObject.items[indexPath.row] = [[NEUTableViewBaseItem alloc] initWithImage:nil Title:str SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]];
                [self.tableView reloadData];
                NSLog(@"change the qiefude qiezi ");
            };
            [self.navigationController pushViewController:nickNameController animated:YES];
            break;
        };
        case 2:{
            [self selectCity];
            
            break;
        };
        case 3:{
            [self selectGender];
        };
        default:
            break;
    }
    NSLog(@"push nickNameController");
}

#pragma mark - select the gender

#pragma mark - about the city selector

- (void)selectCity {
    self.locationManager = [[CLLocationManager alloc] init];
    //设置代理为自己
    self.locationManager.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
    }
    
    [self.locationManager startUpdatingLocation];
    
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    [cityPickerVC setDelegate:self];
    cityPickerVC.loactionCityName = self.cityName;
    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"longitude = %f", ((CLLocation *)[locations
                                             lastObject]).coordinate.longitude);
    NSLog(@"latitude = %f", ((CLLocation *)[locations lastObject]).coordinate.latitude);
    
    NSLog(@"我在定位");
    
    //    CGFloat longitude = ((CLLocation *)[locations
    //                                        lastObject]).coordinate.longitude;
    //    CGFloat latitude = ((CLLocation *)[locations lastObject]).coordinate.latitude;
    //
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:[locations
                                      lastObject] completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             
             
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             NSLog(@"city = %@", city);
             
             self.cityName = city;
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}
//定位失败，回调从方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}


#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
    NSLog(@"%@",city.cityName);
    NEUTableViewSectionObject *section = self.dataSource.sections[0];
    NEUTableViewBaseItem *regionItem = section.items[2];
    regionItem.itemTitle = city.cityName;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:city.cityName forKey:@"region"];
    NSLog(@"%@",city.cityName);
    [self updateRegionWithRegion:city.cityName andSuccess:^(id success) {
        
    } andFailure:^(NSError *error) {
        
    }];
    [self.tableView reloadData];
    //    [self.navigationController popViewControllerAnimated:YES];
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
//        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
//        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark -- update the gender
- (void)updataSexWithIsMan:(NSString *)isMan andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock {
    [[CloudAPI giveMeApi] updataSexWithIsMan:isMan andSuccess:^(id response) {
        
    } andFailure:^(NSError *error) {
        
    }];
}

- (void)selectGender {
    UIAlertController *pickGenderController = [UIAlertController alertControllerWithTitle:@"选择性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NEUTableViewSectionObject *section = self.dataSource.sections[0];
    NEUTableViewBaseItem *regionItem = section.items[3];
    UIAlertAction *maleSheet = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"pick male");
        regionItem.itemTitle = @"男";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *gender = [defaults objectForKey:@"gender"];
        gender = [regionItem.itemTitle copy];
        [defaults setObject:gender forKey:@"gender"];
//        AVObject *userData = [AVObject objectWithClassName:@"NEUUser" objectId:[defaults objectForKey:@"objectId"]];
//        [userData setObject:gender forKey:@"gender"];
//        [userData saveInBackground];
        [self updataSexWithIsMan:gender andSuccess:^(id success) {
            
        } andFailure:^(NSError * error) {
            
        }];
        NSLog(@"gender,gender,gender = %@", [defaults objectForKey:@"gender"]);
        [self.tableView reloadData];
    }];
    UIAlertAction *femaleSheet = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"pick female");
        regionItem.itemTitle = @"女";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *gender = [defaults objectForKey:@"gender"];
        gender = [regionItem.itemTitle copy];
        [defaults setObject:gender forKey:@"gender"];
        NSLog(@"gender,gender,gender = %@", [defaults objectForKey:@"gender"]);
        [self updataSexWithIsMan:gender andSuccess:^(id success) {
            
        } andFailure:^(NSError * error) {
            
        }];
        [self.tableView reloadData];
    }];
    [pickGenderController addAction:maleSheet];
    [pickGenderController addAction:femaleSheet];
    [self presentViewController:pickGenderController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)updateRegionWithRegion:(NSString *)region andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock {
    [[CloudAPI giveMeApi] updateRegionWithRegion:region andSuccess:^(id response) {
        
    } andFailure:^(NSError *error) {
        
    }];
}

@end
