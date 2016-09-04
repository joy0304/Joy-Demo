//
//  NEUPleasureViewController.m
//  NEUGank
//
//  Created by Joy on 16/6/28.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUPleasureViewController.h"
#import "MyScrollView.h"
#import "ImageLoader.h"
#import "PhotoViewController.h"
#import "NEUPleasureDataManager.h"
#import "FileUtil.h"
#import "ImageCacher.h"
#import "NEUHomeDataManager.h"
#import "MJRefresh.h"

@interface NEUPleasureViewController () <UIScrollViewDelegate>

@property (nonatomic, strong)ImageLoader* imageLoad;
@property (nonatomic, strong)NSMutableDictionary* loadedImageDic;
@property (nonatomic, strong)NSMutableArray* loadedImageArray;
@property (nonatomic, strong)NSMutableDictionary* imgTagDic;
@property (nonatomic, strong)NSMutableString* imageName;
@property (nonatomic, strong)FileUtil* fileUtil;
@property (strong, nonatomic) ImageCacher *imageCache;
@end
@implementation NEUPleasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[FileUtil shareInstance] createPathInDocumentDirectory];
    [self.view setFrame:CGRectMake(0, 0,NEUAPPWIDTH, NEUAPPHEIGHT)];
    [[FileUtil shareInstance] createPathInDocumentDirectory];
    self.fileUtil = [FileUtil shareInstance];
    self.imageCache = [ImageCacher shareInstance];
    self.imageLoad = [ImageLoader shareInstance];
    self.imagesArray = [NSMutableArray new];
    self.loadedImageDic = [[NSMutableDictionary alloc] init];
    self.loadedImageArray = [[NSMutableArray alloc] init];
    self.imgTagDic = [[NSMutableDictionary alloc] init];
    _myScrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 0, NEUAPPWIDTH, NEUAPPHEIGHT)];
//    _myScrollView.delegate = self;
//    _imageCache.myDelegate = self;
    
    __weak __typeof(self)weakSelf = self;
    self.myScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    [self.myScrollView.mj_header beginRefreshing];

    self.myScrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
         [self pullRefreshImages];
    }];
    
                                   
    self.view = _myScrollView;
}
- (void)loadData {
    _HUD = [MBProgressHUD showHUDAddedTo:self.myScrollView animated:YES];
    __weak __typeof(self)weakSelf = self;
    
    [NEUPleasureDataManager getWithURL:@"http://gank.io/api/random/data/%E7%A6%8F%E5%88%A9/20" parameters:nil modelClass:[HomeModel class] responseHandler:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        if (error) {
            _HUD.label.text = @"网络错误";
            [_HUD hideAnimated:YES afterDelay:2.0];
            [strongSelf.myScrollView.mj_header endRefreshing];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.myScrollView animated:YES];
                 [strongSelf.myScrollView.mj_header endRefreshing];
                [responseObject enumerateObjectsUsingBlock:^(PleasureModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                    [strongSelf.imagesArray addObject:model.imageURL];
                }];
                [strongSelf firstTimeLoadPic];
            });
        }
    }];
}
                                   
                                   
                                   
#pragma mark  loading

- (void)imageStartLoading:(NSString *)imageName{
    NSURL *url = [NSURL URLWithString:imageName];
    if([_fileUtil hasCachedImage:url]){
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *path = [_fileUtil pathForUrl:url];
        imageView = [ _imageLoad compressImage:NEUAPPWIDTH/2 imageView:nil imageName:path flag:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addImage:imageView name:path];
            [self.myScrollView adjustContentSize:NO];
        });
    }else{
        UIImageView *imageView = [[UIImageView alloc] init];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:url, @"URL",
                             imageView, @"imageView", nil, nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher shareInstance] withObject:dic];
    }
}

//第一次加载图片
- (void)firstTimeLoadPic {
   
    self.imageLoad = [ImageLoader shareInstance];
    for (int i = 0; i < PAGESIZE; i++) {
        NSString* imageName = [self.imagesArray objectAtIndex:i];
        [self imageStartLoading:imageName];
    }
    self.page = 1;
}

//下拉加载图片
- (void)pullRefreshImages{
    
    NSInteger __block currentIndex = self.imagesArray.count;
    NSLog(@"%ld",(long)currentIndex);
    __weak __typeof(self)weakSelf = self;
    [NEUPleasureDataManager getWithURL:@"http://gank.io/api/random/data/%E7%A6%8F%E5%88%A9/20" parameters:nil modelClass:[HomeModel class] responseHandler:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (error) {
            [strongSelf.myScrollView.mj_footer endRefreshing];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [responseObject enumerateObjectsUsingBlock:^(PleasureModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                    [strongSelf.imagesArray addObject:model.imageURL];
                }];
                while (self.imagesArray.count > currentIndex ) {
                    NSString *imageName = [self.imagesArray objectAtIndex:currentIndex];
                    [self imageStartLoading:imageName];
                    currentIndex = currentIndex + 1;
                }
                [strongSelf.myScrollView.mj_footer endRefreshing];
            });
        }
    }];
    

}
/*
 添加一张图片
 规则：根据每一列的高度来决定，优先加载到列高度短的那列
 重新设置图片的x,y坐标
 imageView:图片视图
 imageName:图片名
 */
- (void)addImage:(UIImageView *)imageView name:(NSString *)imageName{
    [self.loadedImageDic setObject:imageView forKey:imageName];
    [self.loadedImageArray addObject:imageView];
    
    [self imageTagWithAction:imageView name:imageName];
    
    float width = imageView.frame.size.width;
    float height = imageView.frame.size.height;
    
    //判断哪一列高度更低
    if(self.myScrollView.leftColumHeight <= self.myScrollView.rightColumHeight){
        UIView *leftView = [self.myScrollView viewWithTag:101];
        [leftView addSubview:imageView];
        //重新设置坐标
        [imageView setFrame:CGRectMake(2, self.myScrollView.leftColumHeight, width, height)];
        self.myScrollView.leftColumHeight = self.myScrollView.leftColumHeight + height + 10;
        
        [leftView setFrame:CGRectMake(0, 0, NEUAPPWIDTH/2, self.myScrollView.leftColumHeight)];
    }else{
        UIView *rightView = [self.myScrollView viewWithTag:102];
        
        [rightView addSubview:imageView];
        [imageView setFrame:CGRectMake(2, self.myScrollView.rightColumHeight, width, height)];
        self.myScrollView.rightColumHeight = self.myScrollView.rightColumHeight + height + 10;
        [rightView setFrame:CGRectMake(NEUAPPWIDTH/2, 0,NEUAPPWIDTH/2, self.myScrollView.rightColumHeight)];
       
    }
}
/*
 得到最短列的高度
 */
- (float)getTheShortColum{
    if(self.myScrollView.leftColumHeight <= self.myScrollView.rightColumHeight){
        return self.myScrollView.leftColumHeight;
    }
    else{
        return self.myScrollView.rightColumHeight;
    }
}

#pragma mark remove & reload
- (void)checkImageIsVisible{
    for (int i = 0; i < [_loadedImageArray count]; i++) {
        UIImageView *imgView = [_loadedImageArray objectAtIndex:i];
        
        if((self.myScrollView.contentOffset.y - imgView.frame.origin.y) > imgView.frame.size.height ||
           imgView.frame.origin.y > (self.myScrollView.frame.size.height + self.myScrollView.contentOffset.y)){
            //不显示图片
            imgView.image = nil;
        }else{
            //重新根据tag值显示图片
            NSString *imageName = [self.imgTagDic objectForKey:[NSString stringWithFormat:@"%ld", (long)imgView.tag]];
            if((NSNull *)imageName == [NSNull null]){
                return;
            }
            
            UIImageView *view = [_imageLoad compressImage:NEUAPPWIDTH/2 imageView:nil imageName:imageName flag:NO];
            imgView.image = view.image;
        }
    }
}
//调整scrool的contentsize大小
- (void)adjustContentSize:(BOOL)isEnd{
    UIView *leftView = [self.myScrollView viewWithTag:101];
    UIView *rightView = [self.myScrollView viewWithTag:102];
    
    if(self.myScrollView.leftColumHeight >= self.myScrollView.rightColumHeight){
        self.myScrollView.contentSize = leftView.frame.size;
    }
    else{
        self.myScrollView.contentSize = rightView.frame.size;
    }
    
}
#pragma mark add click for every photo
//将图片的tag和名字按对存起来
///////////////////////////////
- (void)imageTagWithAction:(UIImageView *)imageView name:(NSString *)imageName{
    imageView.tag = self.myScrollView.imgTag;
    [self.imgTagDic setObject:imageName forKey:[NSString stringWithFormat:@"%ld",(long)imageView.tag]];
    self.myScrollView.imgTag++;
    
    //为图片添加响应
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getNameWithTag:)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapRecognizer];
}

//点击图片事件响应
- (void)getNameWithTag:(UITapGestureRecognizer *)sender{
    UIImageView *view = (UIImageView *)sender.view;
    NSString *imageName = [self.imgTagDic objectForKey:[NSString stringWithFormat:@"%ld", (long)view.tag]];
    NSLog(@"%@,%ld", imageName,(long)view.tag);
    
    [self clickPushImageView:imageName];
}

#pragma mark clicked
- (void)clickPushImageView:(NSString*)imageName {
    PhotoViewController *vc = [[PhotoViewController alloc] init];
    vc.imageName = imageName;
    if (vc.imageName) {
        [self.navigationController pushViewControllerWithTabbarHidden:vc animated:true];
    }
}
@end
