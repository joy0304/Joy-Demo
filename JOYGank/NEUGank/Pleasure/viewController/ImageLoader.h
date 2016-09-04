//
//  ImageLoader.h
//  PleasureDemo
//
//  Created by 中软mac004 on 16/7/13.
//  Copyright (c) 2016年 何天一. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageLoader : UIViewController

//- (void)loadImage:(NSMutableArray *)array;
+ (ImageLoader *)shareInstance;

- (UIImageView *)compressImage:(float)width imageView:(UIImageView *)imgV imageName:(NSString *)name flag:(BOOL) isView;
@end
