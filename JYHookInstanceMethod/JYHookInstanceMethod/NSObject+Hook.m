//
//  NSObject+Hook.m
//  JYHookInstanceMethod
//
//  Created by wangjiale on 2017/3/20.
//  Copyright © 2017年 wangjiale. All rights reserved.
//

#import "NSObject+Hook.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "LDSubclass.h"

@implementation NSObject (Hook)

+ (void)hookWithInstance:(id)instance method:(SEL)selector {
 
    Method originMethod = class_getInstanceMethod([instance class], selector);
    if (!originMethod) {
        // exception ..
    }
    
    Class newClass = [LDSubclass class];
    
    // 修改 isa 指针的指向
    object_setClass(instance, newClass);

}

@end
