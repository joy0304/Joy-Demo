//
//  LDSubclass.m
//  JYHookInstanceMethod
//
//  Created by wangjiale on 2017/3/20.
//  Copyright © 2017年 wangjiale. All rights reserved.
//

#import "LDSubclass.h"
#import <objc/message.h>
#import "LDSubclass.h"

@implementation LDSubclass

- (void)eat {
    NSLog(@"newSubClass eat");
    
    struct objc_super superClazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    // 调用原方法
    
    void (*objc_msgSendSuperCasted)(void *, SEL) = (void *)objc_msgSendSuper;
    
    objc_msgSendSuperCasted(&superClazz, _cmd);
}
@end
