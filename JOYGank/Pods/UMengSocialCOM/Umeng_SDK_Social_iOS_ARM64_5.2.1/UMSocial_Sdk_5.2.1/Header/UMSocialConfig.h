//
//  UMSConfigManager.h
//  SocialSDK
//
//  Created by Jiahuan Ye on 12-9-15.
//  Copyright (c) umeng.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocialDataService.h"


#ifndef __IPHONE_6_0
typedef enum {
    UIInterfaceOrientationMaskPortrait = (1 << UIInterfaceOrientationPortrait),
    UIInterfaceOrientationMaskLandscapeLeft = (1 << UIInterfaceOrientationLandscapeLeft),
    UIInterfaceOrientationMaskLandscapeRight = (1 << UIInterfaceOrientationLandscapeRight),
    UIInterfaceOrientationMaskPortraitUpsideDown = (1 << UIInterfaceOrientationPortraitUpsideDown),
    UIInterfaceOrientationMaskLandscape = (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
    UIInterfaceOrientationMaskAll = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortraitUpsideDown),
    UIInterfaceOrientationMaskAllButUpsideDown = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
} UIInterfaceOrientationMask;
#endif

typedef enum {
	UMSocialiToastPositionTop = 1000001,        //提示位置在屏幕上部
    UMSocialiToastPositionBottom,               //提示位置在屏幕下部
    UMSocialiToastPositionCenter                //提示位置在屏幕中间
} UMSocialiToastPosition;

/**
 SDK样式主题
 
 */
typedef enum {
    UMSocialThemeBlack,     //黑色主题
    UMSocialThemeWhite      //白色主题
} UMSocialTheme;


/**
 设置分享列表页面的Block类型
 
 @param ref             分享列表绘图所用的CGContext对象
 @param backgroundView  分享列表的背景图片
 @param label           平台文字
 */
typedef void (^UMGridViewConfig)(CGContextRef ref, UIImageView *backgroundView, UILabel *label) ;

/**
 设置导航栏的样式的Block类型
 
 @param bar             导航栏
 @param closeButton     关闭按钮
 @param backButton      返回按钮
 @param postButton      发送按钮
 @param refreshButton   刷新按钮
 @param navigationItem 所在UINavigationController的navigationItem，可以改变相应的标题
 
 */
typedef void (^UMNavigationBarConfig)(UINavigationBar *bar,
        UIButton *closeButton,
        UIButton *backButton,
        UIButton *postButton,
        UIButton *refreshButton,
        UINavigationItem * navigationItem);

/**
 设置TableViewCell的样式
 
 @param cell UITableViewCell
 @param viewControllerType 页面类型
 
 */
typedef void (^UMTableViewCellConfig)(UITableViewCell *cell,UMSViewControllerType viewControllerType);

/**
 SDK设置类，负责改变SDK功能配置
 
 */
@interface UMSocialConfig : NSObject
/**
 *是否显示loading状态图
 */
@property (nonatomic, assign) BOOL hiddenLoadingHUD;

/**
 *是否显示状态提示框
 */
@property (nonatomic, assign) BOOL hiddenStatusTip;

/**
 * 设置分享web url是否转换成回流的url, 默认为NO
 */
@property (nonatomic, assign) BOOL isGetInverseFlowUrl;

/**
 * 设定分享次数的统计在分享操作之前or之后
 * @default YES(分享成功跳转回app后进行统计)
 * @discuss 
 1、分享跳转app前进行统计，不会出现分享后‘留在app’时没统计上，但若在目标app分享之前取消了分享操作，计数会比实际多计一次。
 2、分享完成并跳转后统计（默认），这个是在‘返回我的app’后进行统计，可能因’留在app‘没返回而没统计上。
 */
@property (nonatomic, assign) BOOL statisticsAfterShareEventReturned;


+ (UMSocialConfig *)shareInstance;

/**
 设置显示的sns平台类型
 
 @param platformNames  在`UMSocialSnsPlatformManager.h`定义的UMShareToSina、UMShareToTencent、UMShareToQzone、UMShareToRenren、UMShareToDouban、UMShareToEmail、UMShareToSms组成的NSArray
 */
+ (void)setSnsPlatformNames:(NSArray *)platformNames;

/**
设置sdk所有页面需要支持屏幕方向.

@param interfaceOrientations 一个bit map（位掩码），ios 6定义的`UIInterfaceOrientationMask`
*/
+ (void)setSupportedInterfaceOrientations:(UIInterfaceOrientationMask)interfaceOrientations;

/**
 设置社会化组件UI主题，现在有黑色和白色两种
 
 @param theme UI主题
 
 */
+ (void) setTheme:(UMSocialTheme)theme;


/**
 设置分享列表页面，Block对象的形参包括有绘制当前线条的CGContex指针，icon背景视图
 例如下面写法
 ```
 [UMSocialConfig setShareGridViewTheme:^(CGContextRef ref, UIImageView *backgroundView,UILabel *label){
 //改变线颜色和线宽
    CGContextSetRGBStrokeColor(ref, 0, 0, 0, 1.0);
    CGContextSetLineWidth(ref, 1.0);
 //改变背景颜色
    backgroundView.backgroundColor = [UIColor blackColor];

 //添加背景图片
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:backgroundView.frame];
 imageView.image = [UIImage imageNamed:@"share_bg.png"];
 [backgroundView addSubview:imageView];
 backgroundView.backgroundColor = [UIColor clearColor];

//改变文字标题的文字颜色
    label.textColor = [UIColor blueColor];
 //隐藏文字
    label.hidden = YES;
 }];
 ```
 
 @param gridViewConfig 设置分享列表样式的block对象
 
 */
+(void)setShareGridViewTheme:(UMGridViewConfig)gridViewConfig;

/**
 设置导航栏,包括导航栏的UINavigationBar,返回按钮，关闭按钮，发送按钮，刷新按钮和中间的UINavigationItem的样式
 例如下面写法：
 
 ```
 [UMSocialConfig setNavigationBarConfig:^(UINavigationBar *bar,
     UIButton *closeButton,
     UIButton *backButton,
     UIButton *postButton,
     UIButton *refreshButton,
     UINavigationItem * navigationItem){
     UIImage * backgroundImage = [UIImage imageNamed:@"UMSocialSDKResourcesNew.bundle/OtherTheme/UMS_nav_bar_bg"];
 
     if ([bar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
         [bar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
     }
     bar.titleTextAttributes = nil;
 }];
 ```
 
 @param navigationConfig 设置导航栏样式的block对象
   navigationConfig 是一个Block对象，传入的参数包括：
     @param bar 导航栏
     @param closeButton 关闭按钮
     @param backButton 返回按钮
     @param postButton 发送按钮
     @param refreshButton 刷新按钮
     @param navigationItem 所在UINavigationController的navigationItem，可以改变相应的标题 
 */
+(void)setNavigationBarConfig:(UMNavigationBarConfig)navigationConfig;

/**
 设置分享列表页，个人中心页面等的UITableViewCell的样式
 
 @param tableViewCellConfig UITableViewCell的样式配置Block
     @param cell UITableViewCell
     @param viewControllerType 页面类型

 */
+(void)setTableViewCellConfig:(UMTableViewCellConfig)tableViewCellConfig;

/**
 设置分享完成时“发送完成”或者分享错误等提示
 
 @param isHidden 是否隐藏该提示
 @param toastPosition 提示的位置，可以设置成在屏幕上部、中间、下部
 */
+(void)setFinishToastIsHidden:(BOOL)isHidden position:(UMSocialiToastPosition)toastPosition;

/**
 设置官方微博账号,设置之后可以在授权页面有关注微博的选项，默认勾选，授权之后用户即关注官方微博，仅支持腾讯微博
 
 @param weiboUids  腾讯微博的key是`UMShareToTenc`,值是官方微博的uid,例如`[UMSocialConfig setFollowWeiboUids:[NSDictionary dictionaryWithObjectsAndKeys:@"yourSinaUid",UMShareToTenc,nil]];`
 */
+ (void)setFollowWeiboUids:(NSDictionary *)weiboUids;

/**
 设置新增加`UMSocialSnsPlatform`对象 
 @param snsPlatformArray `UMSocialSnsPlatform`组成的数组对象
 
 */
+ (void)addSocialSnsPlatform:(NSArray *)snsPlatformArray;

/**
 设置页面的背景颜色
 @param defaultColor 设置页面背景颜色
 
 */
+ (void)setDefaultColor:(UIColor *)defaultColor;

/**
 设置iPad页面的大小
 @param size 页面大小
 
 */
+ (void)setBoundsSizeForiPad:(CGSize)size;

/**
 设置分享编辑页面是否等待完成之后再关闭页面还是立即关闭，如果设置成YES，就是等待分享完成之后再关闭，否则立即关闭。
 2.2版本前默认等待分享完成之后再关闭。
 2.2版本之后默认设置成立即关闭页面

 @param shouldShareSynchronous 是否同步分享
 
 */
+ (void)setShouldShareSynchronous:(BOOL)shouldShareSynchronous;

/**
 设置评论页面是否出现分享按钮，默认出现

 */
+ (void)setShouldCommentWithShare:(BOOL)shouldCommentWithShare;

/**
 设置评论页面是否出现分享地理位置信息的按钮，默认出现
 
 */
+ (void)setShouldCommentWithLocation:(BOOL)shouldCommentWithLocation;

/** Deprecated API, Use [UMSocialConfig showPlatformWhenNotInstall:nil];
 显示所有平台，某些平台例如微信和QQ，需要安装客户端才能分享，若没有安装客户端情况下不显示这些平台
 
 */
//+ (void)showAllPlatform:(BOOL)showAllPlatform;

/** Deprecated API, Use [UMSocialConfig hiddenNotInstallPlatforms:nil];
 指定显示没有安装客户端的平台，默认需要客户端的分享平台不显示。
 传nil则显示所有平台。
 
 @param showPlatforms 指定要显示的平台
 
 */
+ (void)showNotInstallPlatforms:(NSArray *)showPlatforms;

/**
 隐藏指定没有安装客户端的平台。
 
 @param hiddenPlatforms 指定要隐藏的平台,传nil则隐藏所有没有安装客户端的平台

 */
+ (void)hiddenNotInstallPlatforms:(NSArray *)hiddenPlatforms;


@property (nonatomic, assign) BOOL forCocos2dx;

/** deprecated API, Use ''[UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];''

 设置是否支持新浪微博SSO，默认不支持
 @param supportSinaSSO 设置是否支持新浪微博SSO
 @param appRedirectUrl 设置授权回调地址，此授权回调地址必须和你在新浪应用后台填写的回调地址一致，否则不能授权
        如果在新浪微博后台绑定我们的回调地址“http://sns.whalecloud.com/sina2/callback”，这里可以传nil

 */
//+ (void)setSupportSinaSSO:(BOOL)supportSinaSSO appRedirectUrl:(NSString *)appRedirectUrl;


/** deprecated API, Use ''[UMSocialQQHandler shareToQQWithAppId:@"100424468" url:@"http://www.umeng.com/social"];''

 设置手机QQ的app_Id和微信图文分享用到的url地址
 
 @param app_Id 手机QQ的AppId
 @param url   手机QQ图文分享web类型，用到的url地址，如果传nil，默认使用http://www.umeng.com/social
 @param classes 载入QQ互联 SDK，用到的两个类
 */

//+ (void)setQQAppId:(NSString *)app_Id url:(NSString *)url importClasses:(NSArray *)classes;


/**deprecated API, Use ''[UMSocialQQHandler setSupportQzoneSSO:YES];''
 设置支持Qzone的SSO授权
 
 @param supportQzoneSSO Qzone支持SSO
 @param classes 载入QQ互联 SDK，用到的两个类
 */

//+ (void)setSupportQzoneSSO:(BOOL)supportQzoneSSO importClasses:(NSArray *)classes;


/**deprecated API
 设置是否使用QQ互联的SDK来分享
 
 @param useQQSDK 是否使用QQ互联的SDK来分享
 @param classes 载入QQ互联 SDK，用到的两个类
 */

//+ (void)setShareQzoneWithQQSDK:(BOOL)useQQSDK url:(NSString *)urlString importClasses:(NSArray *)classes;

/**
 *隐藏loading状态框
 */
+ (void)hiddenLoadingHUD:(BOOL)isHiden;

/**
 *隐藏状态提示框
 */
+ (void)hiddenStatusTip:(BOOL)isHiden;;

/**
 * 设置分享web url是否转换成回流的url, 默认为NO
 */
+ (void)webUrlShareGetInverseFlowUrl:(BOOL)isGetInverseFlowUrl;

@end
