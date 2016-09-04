//
//  MyScrollView.h
//  NEUGank
//
//  Created by 中软mac004 on 16/7/18.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageLoader.h"
//@protocol myScrollViewDelgeate<NSObject>
//
//- (void)clickPushImageView:(NSString*)imageName;
//
//@end

@interface MyScrollView : UIScrollView
//@property (nonatomic, weak) id<myScrollViewDelgeate> delegate;
@property (nonatomic,assign)int page;
@property (nonatomic,assign)float leftColumHeight;
@property (nonatomic,assign)float rightColumHeight;
@property (nonatomic,assign)int imgTag;
- (void)adjustContentSize:(BOOL)isEnd;
+ (MyScrollView *)shareInstance;
- (void)initWithPhotoBox;

@end
