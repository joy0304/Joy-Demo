//
//  ImageCacher.h
//  NEUGank
//
//  Created by 中软mac004 on 16/8/3.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileUtil.h"
#import "ImageLoader.h"

@protocol ImageAddDelegate<NSObject>

- (void)addImage:(UIImageView *)imageView name:(NSString *)imageName;

- (void)adjustContentSize:(BOOL)isEnd;

@end

@interface ImageCacher : NSObject{
    id<ImageAddDelegate> myDelegate;
}

@property (strong, nonatomic) FileUtil *fileUtil;

@property (strong, nonatomic) ImageLoader *imageLoader;

@property (weak, atomic) id<ImageAddDelegate > myDelegate;

- (void)cacheImage:(NSDictionary*)dic;

+ (ImageCacher *)shareInstance;

@end