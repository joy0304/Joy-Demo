//
//  NEURegionViewController.m
//  NEUGank
//
//  Created by 周鑫城 on 8/2/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEURegionViewController.h"
#import "TLCityPickerController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CloudAPI.h"

@interface NEURegionViewController ()<TLCityPickerDelegate,CLLocationManagerDelegate>

@property (nonatomic,strong)  NSString * cityName;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation NEURegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建CLLocationManager对象
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

    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
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

//- (void)viewWillDisappear:(BOOL)animated {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *region = [defaults objectForKey:@"region"];
//    region = [self.cityName  copy];
//    [defaults setObject:region forKey:@"region"];
//    NSLog(@"我是region， 我是region， 我是region");
//    NSLog(@"regionregion  ==== %@", [defaults objectForKey:@"region"]);
//    [defaults synchronize];
//}

#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@",city.cityName);
        cityPickerViewController.sendValueBlock(city.cityName);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
