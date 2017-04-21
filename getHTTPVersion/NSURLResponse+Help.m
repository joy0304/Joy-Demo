//
//  NSURLResponse+Help.m
//  Pods
//
//  Created by wangjiale on 2017/4/17.
//
//

#import "NSURLResponse+Help.h"
#import <dlfcn.h>
@implementation NSURLResponse (Help)
typedef CFHTTPMessageRef (*MYURLResponseGetHTTPResponse)(CFURLRef response);

- (NSString *)getHTTPVersion {
    NSURLResponse *response = self;
    NSString *version;

    NSString *funName = @"CFURLResponseGetHTTPResponse";
    MYURLResponseGetHTTPResponse originURLResponseGetHTTPResponse =
    dlsym(RTLD_DEFAULT, [funName UTF8String]);
    SEL theSelector = NSSelectorFromString(@"_CFURLResponse");
    if ([response respondsToSelector:theSelector] &&
        NULL != originURLResponseGetHTTPResponse) {

        CFTypeRef cfResponse = CFBridgingRetain([response performSelector:theSelector]);
        if (NULL != cfResponse) {

            CFHTTPMessageRef message = originURLResponseGetHTTPResponse(cfResponse);

            CFStringRef cfVersion = CFHTTPMessageCopyVersion(message);
            if (NULL != cfVersion) {
                version = (__bridge NSString *)cfVersion;
                CFRelease(cfVersion);
            }
            CFRelease(cfResponse);
        }
    }

    if (nil == version || 0 == version.length) {
        version = @"获取失败";
    }

    return version;
}
@end
