//
//  NSObject+Hook.h
//  JYHookInstanceMethod
//
//  Created by wangjiale on 2017/3/20.
//  Copyright © 2017年 wangjiale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Hook)

+ (void)hookWithInstance:(NSObject *)instance method:(SEL)selector ;

@end
