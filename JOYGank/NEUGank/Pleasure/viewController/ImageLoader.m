//
//  ImageLoader.m
//  PleasureDemo
//
//  Created by 中软mac004 on 16/7/13.
//  Copyright (c) 2016年 何天一. All rights reserved.
//

#import "ImageLoader.h"


@implementation ImageLoader

/**
 *  单例
 *
 *  @return 返回一个对象
 */
+ (ImageLoader *)shareInstance {
    static ImageLoader *loader = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[ImageLoader alloc] init];
    });
    return loader;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}


//加载图片    加载图片的数组
//- (void)loadImage:(NSMutableArray *)array {
//    self.imagesArray = array;
    
//    __weak __typeof(self)weakSelf = self;
//    
//    [NEUPleasureDataManager getWithURL:@"http://gank.io/api/random/data/%E7%A6%8F%E5%88%A9/20" parameters:nil modelClass:[HomeModel class] responseHandler:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
//        __strong __typeof(weakSelf)strongSelf = weakSelf;
//        if (error) {
//            //[strongSelf.listTableView.mj_footer endRefreshing];
//        }
//        else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [responseObject enumerateObjectsUsingBlock:^(HomeModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
//                    [strongSelf.imagesArray addObject:model.detailURL];
//                }];
//                
//            });
//        }
//    }];
    
    //http://gank.io/api/random/data/福利/20
    
//    self.imagesArray = [[NSMutableArray alloc] initWithObjects:
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037235_3453.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037235_9280.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037234_3539.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037234_6318.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037194_2965.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037193_1687.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037193_1286.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037192_8379.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037178_9374.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037177_1254.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037177_6203.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037152_6352.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037151_9565.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037151_7904.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037148_7104.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037129_8825.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037128_5291.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037128_3531.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037127_1085.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037095_7515.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037094_8001.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037093_7168.jpg",
//                        @"http://img.my.csdn.net/uploads/201309/01/1378037091_4950.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949643_6410.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949642_6939.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949630_4505.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949630_4593.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949629_7309.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949629_8247.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949615_1986.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949614_8482.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949614_3743.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949614_4199.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949599_3416.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949599_5269.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949598_7858.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949598_9982.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949578_2770.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949578_8744.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949577_5210.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949577_1998.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949482_8813.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949481_6577.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949480_4490.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949455_6792.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949455_6345.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949442_4553.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949441_8987.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949441_5454.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949454_6367.jpg",
//                        @"http://img.my.csdn.net/uploads/201308/31/1377949442_4562.jpg",
//                        nil];
//
//}


- (UIImageView *)compressImage:(float)width imageView:(UIImageView *)imgV imageName:(NSString *)name flag:(BOOL) isView{
    if(isView){
        float orgi_width = [imgV image].size.width;
        float orgi_height = [imgV image].size.height;
        
        //按照每列的宽度，以及图片的宽高来按比例压缩
        float new_width = width - 5;
        float new_height = (width * orgi_height)/orgi_width;
        
        //重置imageView的尺寸
        [imgV setFrame:CGRectMake(0, 0, new_width, new_height)];
        
        return imgV;
    }else{
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageWithContentsOfFile:name];
        
        float orgi_width = [imageV image].size.width;
        float orgi_height = [imageV image].size.height;
        
        //按照每列的宽度，以及图片的宽高来按比例压缩
        float new_width = width - 5;
        float new_height = (width * orgi_height)/orgi_width;
        
        //重置imageView的尺寸
        [imageV setFrame:CGRectMake(0, 0, new_width, new_height)];
        
        return imageV;
    }
}










@end
