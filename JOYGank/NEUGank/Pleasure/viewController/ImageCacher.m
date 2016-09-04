//
//  ImageCacher.m
//  NEUGank
//
//  Created by 中软mac004 on 16/8/3.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "ImageCacher.h"

@implementation ImageCacher


+ (ImageCacher *)shareInstance{
    static ImageCacher *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id)init{
    self = [super init];
    if(self){
        self.fileUtil = [FileUtil shareInstance];
        self.imageLoader = [ImageLoader shareInstance];
    }
    return self;
}

- (void)cacheImage:(NSDictionary*)dic{
    NSURL *url = [dic objectForKey:@"URL"];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSString *fileName = [_fileUtil pathForUrl:url];
    if(data){
        [fileManage createFileAtPath:fileName contents:data attributes:nil];
    }
    
    UIImageView *imageView = [dic objectForKey:@"imageView"];
    imageView.image = [UIImage imageWithData:data];
    imageView = [_imageLoader compressImage:NEUAPPWIDTH/2 imageView:imageView imageName:nil flag:YES];
    [self.myDelegate addImage:imageView name:fileName];
    [self.myDelegate adjustContentSize:NO];
}


@end

