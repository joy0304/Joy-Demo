//
//  MyScrollView.m
//  NEUGank
//
//  Created by 中软mac004 on 16/7/18.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "MyScrollView.h"
#import "ImageLoader.h"
#import "PhotoViewController.h"
@interface MyScrollView () //<UIScrollViewDelegate>

@property (nonatomic,copy)NSString* imagesName;
@property (nonatomic,assign)BOOL isOnce;




@end

@implementation MyScrollView

+ (MyScrollView *)shareInstance{
    static MyScrollView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithFrame:CGRectMake(0, 0, NEUAPPWIDTH, NEUAPPHEIGHT)];
    });
    
    return instance;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.isOnce = YES;
        
        //初始化列的高度
        self.leftColumHeight = 3.0f;
        self.rightColumHeight = 3.0f;
        self.imgTag = 10086;
        self.page = 1;
        
        [self initWithPhotoBox];
    }
    
    return self;
}

- (void)initWithPhotoBox {
    
    
    //将界面分为左右两个部分
    UIView* leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, NEUAPPWIDTH/2, self.frame.size.height)];
    UIView* rightview = [[UIView alloc]initWithFrame:CGRectMake(NEUAPPWIDTH/2, 0, NEUAPPWIDTH/2, self.frame.size.height)];
    
    leftview.tag = 101;
    rightview.tag = 102;
    
    leftview.backgroundColor = [UIColor whiteColor];
    rightview.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:leftview];
    [self addSubview:rightview];
    
}

//调整scrool的contentsize大小
- (void)adjustContentSize:(BOOL)isEnd{
    UIView *leftView = [self viewWithTag:101];
    UIView *rightView = [self viewWithTag:102];
    
    if(_leftColumHeight >= _rightColumHeight){
        self.contentSize = leftView.frame.size;
    }
    else{
        self.contentSize = rightView.frame.size;
    }
    
}







@end
