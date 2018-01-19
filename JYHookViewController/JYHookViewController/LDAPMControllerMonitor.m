//
//  LDAPMControllerMonitor.m
//  JYHookViewController
//
//  Created by wangjiale on 2017/9/26.
//  Copyright © 2017年 Joy. All rights reserved.
//

#import "LDAPMControllerMonitor.h"
#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/ldsyms.h>
#include <limits.h>
#include <mach-o/dyld.h>
#include <mach-o/nlist.h>
#include <string.h>
#import <objc/message.h>

unsigned int ldCount;
const char **ldClasses;

@implementation LDAPMControllerMonitor

+ (void)load {
    
    int imageCount = (int)_dyld_image_count();
    
    for(int iImg = 0; iImg < imageCount; iImg++) {
        
        const char* path = _dyld_get_image_name((unsigned)iImg);
        NSString *imagePath = [NSString stringWithUTF8String:path];
        
        NSBundle* mainBundle = [NSBundle mainBundle];
        NSString* bundlePath = [mainBundle bundlePath];
        
        if ([imagePath containsString:bundlePath] && ![imagePath containsString:@".dylib"]) {
            ldClasses = objc_copyClassNamesForImage(path, &ldCount);
            for (int i = 0; i < ldCount; i++) {
                NSString *className = [NSString stringWithCString:ldClasses[i] encoding:NSUTF8StringEncoding];
                
                if (![className hasPrefix:@"LDAssets"] && ![className hasPrefix:@"UI"]) {
                    Class cls = NSClassFromString(className);
                    if ([cls isSubclassOfClass:[UIViewController class]]) {
                        NSLog(@"class:%@",cls);
                        
                        [self toHookAllMethod:cls];
                    }
                }
            }
        }
    }
}
+ (void)toHookAllMethod:(Class)cls {
    [self toHookLoadView:cls];
    [self toHookViewDidLoad:cls];
    [self toHookViewWillAppear:cls];
    [self toHookViewDidAppear:cls];
    [self toHookViewWillDisappear:cls];
    [self toHookViewDidDisappear:cls];
}

+ (void)toHookLoadView:(Class)class {
    SEL selector = @selector(loadView);
    
    SEL swizzledSelector = [self swizzledSelectorForSelector:selector];
    
    void (^swizzledBlock)(UIViewController *) = ^(UIViewController *viewController) {
        NSTimeInterval start = [self currentTime];
        ((void(*)(id, SEL))objc_msgSend)(viewController, swizzledSelector);
        NSTimeInterval end = [self currentTime];
        NSTimeInterval cast = end - start;
        NSLog(@"swizzled loadView %@ %f %@",viewController.class,cast,[[NSString alloc]initWithUTF8String:class_getName(class)]);
    };
    [self replaceImplementationOfKnownSelector:selector onClass:class withBlock:swizzledBlock swizzledSelector:swizzledSelector];
}
+ (void)toHookViewDidLoad:(Class)class {
    SEL selector = @selector(viewDidLoad);
    
    SEL swizzledSelector = [self swizzledSelectorForSelector:selector];
    
    void (^swizzledBlock)(UIViewController *) = ^(UIViewController *viewController) {
        NSTimeInterval start = [self currentTime];
        ((void(*)(id, SEL))objc_msgSend)(viewController, swizzledSelector);
        NSTimeInterval end = [self currentTime];
        NSTimeInterval cast = end - start;
        NSLog(@"swizzled viewDidLoad %@ %f %@",viewController.class,cast,[[NSString alloc]initWithUTF8String:class_getName(class)]);
    };
    [self replaceImplementationOfKnownSelector:selector onClass:class withBlock:swizzledBlock swizzledSelector:swizzledSelector];
}

+ (void)toHookViewWillAppear:(Class)class {
    SEL originalSelector = @selector(viewWillAppear:);
    SEL swizzledSelector = [self swizzledSelectorForSelector:originalSelector];
    
    void (^swizzleBlock)(UIViewController *vc,BOOL animated) = ^(UIViewController *vc, BOOL animated) {
        NSTimeInterval start = [self currentTime];
        ((void(*)(id, SEL, BOOL))objc_msgSend)(vc, swizzledSelector, animated);
        NSTimeInterval end = [self currentTime];
        NSTimeInterval cast = end - start;
        NSLog(@"swizzled viewWillAppear %@ %f %@",vc.class,cast,[[NSString alloc]initWithUTF8String:class_getName(class)]);
        
    };
    [self replaceImplementationOfKnownSelector:originalSelector onClass:class withBlock:swizzleBlock swizzledSelector:swizzledSelector];
}

+ (void)toHookViewDidAppear:(Class)class {
    SEL originalSelector = @selector(viewDidAppear:);
    SEL swizzledSelector = [self swizzledSelectorForSelector:originalSelector];
    
    void (^swizzleBlock)(UIViewController *vc,BOOL animated) = ^(UIViewController *vc, BOOL animated) {
        NSTimeInterval start = [self currentTime];
        ((void(*)(id, SEL, BOOL))objc_msgSend)(vc, swizzledSelector, animated);
        NSTimeInterval end = [self currentTime];
        NSTimeInterval cast = end - start;
        NSLog(@"swizzled viewDidAppear %@ %f %@",vc.class,cast,[[NSString alloc]initWithUTF8String:class_getName(class)]);
    };
    [self replaceImplementationOfKnownSelector:originalSelector onClass:class withBlock:swizzleBlock swizzledSelector:swizzledSelector];
}

+ (void)toHookViewWillDisappear:(Class)class {
    SEL originalSelector = @selector(viewWillDisappear:);
    SEL swizzledSelector = [self swizzledSelectorForSelector:originalSelector];
    void (^swizzleBlock)(UIViewController *vc,BOOL animated) = ^(UIViewController *vc, BOOL animated) {
        NSTimeInterval start = [self currentTime];
        ((void(*)(id, SEL, BOOL))objc_msgSend)(vc, swizzledSelector, animated);
        NSTimeInterval end = [self currentTime];
        NSTimeInterval cast = end - start;
        NSLog(@"swizzled viewWillDisappear %@ %f %@",vc.class,cast,[[NSString alloc]initWithUTF8String:class_getName(class)]);
    };
    [self replaceImplementationOfKnownSelector:originalSelector onClass:class withBlock:swizzleBlock swizzledSelector:swizzledSelector];
}

+ (void)toHookViewDidDisappear:(Class)class {
    SEL originalSelector = @selector(viewDidDisappear:);
    SEL swizzledSelector = [self swizzledSelectorForSelector:originalSelector];
    
    void (^swizzleBlock)(UIViewController *vc,BOOL animated) = ^(UIViewController *vc, BOOL animated) {
        NSTimeInterval start = [self currentTime];
        ((void(*)(id, SEL, BOOL))objc_msgSend)(vc, swizzledSelector, animated);
        NSTimeInterval end = [self currentTime];
        NSTimeInterval cast = end - start;
        NSLog(@"swizzled viewDidDisappear %@ %f %@",vc.class,cast,[[NSString alloc]initWithUTF8String:class_getName(class)]);
    };
    [self replaceImplementationOfKnownSelector:originalSelector onClass:class withBlock:swizzleBlock swizzledSelector:swizzledSelector];
}


+ (BOOL)replaceImplementationOfKnownSelector:(SEL)originalSelector onClass:(Class)class withBlock:(id)block swizzledSelector:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    if (!originalMethod) {
        return NO;
    }
#ifdef __IPHONE_6_0
    IMP implementation = imp_implementationWithBlock((id)block);
#else
    IMP implementation = imp_implementationWithBlock((__bridge void *)block);
#endif
    
    class_addMethod(class, swizzledSelector, implementation, method_getTypeEncoding(originalMethod));
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}

+ (NSTimeInterval)currentTime {
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

+ (SEL)swizzledSelectorForSelector:(SEL)selector {
    // 保证 selector 为唯一的，不然会死循环
    return NSSelectorFromString([NSString stringWithFormat:@"MA_Swizzle_%x_%f_%@", arc4random(), [self currentTime], NSStringFromSelector(selector)]);
}
@end

