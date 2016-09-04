//
//  NEUSettingDataSource.m
//  NEUGank
//
//  Created by 周鑫城 on 8/4/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUSettingDataSource.h"
#import "NEUTableViewSectionObject.h"
#import "NEUTableViewBaseItem.h"
#import "NEUSettingCell.h"

@interface NEUSettingDataSource ()

@property (nonatomic, strong) NSString *caches;

@end

@implementation NEUSettingDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        _caches = [self getCacheSize];
        NSUserDefaults *cacheDefault = [NSUserDefaults standardUserDefaults];
        [cacheDefault setObject:_caches forKey:@"cache"];
        NEUTableViewSectionObject *firstSectionObject = [[NEUTableViewSectionObject alloc] initWithItemArray:[NSMutableArray arrayWithObjects:
                                                                                                              [[NEUTableViewBaseItem alloc] initWithImage:nil Title:@"清除缓存" SubTitle:_caches AccessoryImage:nil],[[NEUTableViewBaseItem alloc] initWithImage:nil Title:@"给软件评分" SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]],
                                                                                                              [[NEUTableViewBaseItem alloc] initWithImage:nil Title:@"推荐给朋友" SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]],
                                                                                                              [[NEUTableViewBaseItem alloc] initWithImage:nil Title:@"关于我们" SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]],
                                                                                                              nil]];
        
        self.sections = [NSMutableArray arrayWithObjects:firstSectionObject, nil];
    }
    return self;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(NEUTableViewBaseItem *)object {
    return [NEUSettingCell class];
}

#pragma mark - 计算缓存大小
- (NSString *)getCacheSize
 {
          //定义变量存储总的缓存大小
        long long sumSize = 0;
    
          //01.获取当前图片缓存路径
         NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    
         //02.创建文件管理对象
         NSFileManager *filemanager = [NSFileManager defaultManager];
    
            //03.获取当前缓存路径下的所有子路径
         NSArray *subPaths = [filemanager subpathsOfDirectoryAtPath:cacheFilePath error:nil];
    
            //04.遍历所有子文件
         for (NSString *subPath in subPaths) {
            //1）.拼接完整路径
            NSString *filePath = [cacheFilePath stringByAppendingFormat:@"/%@",subPath];
            //2）.计算文件的大小
            long long fileSize = [[filemanager attributesOfItemAtPath:filePath error:nil]fileSize];
            //3）.加载到文件的大小
            sumSize += fileSize;
         }
         float size_m = sumSize/(1000*1000);
         return [NSString stringWithFormat:@"%.2fM",size_m];
 }

@end

