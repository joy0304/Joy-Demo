//
//  FileUtil.h
//  NEUGank
//
//  Created by 中软mac004 on 16/8/3.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

- (void)createPathInDocumentDirectory;
- (NSString *)pathInDocumentDirectory:(NSString *)fileName;
- (NSString *)pathInCacheDirectory:(NSString *)fileName;
- (BOOL)hasCachedImage:(NSURL *)url;
- (NSString *)pathForUrl:(NSURL *)url;

+ (FileUtil *)shareInstance;

@end