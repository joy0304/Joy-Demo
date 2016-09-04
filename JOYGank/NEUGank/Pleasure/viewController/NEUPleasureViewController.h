//
//  NEUPleasureViewController.h
//  NEUGank
//
//  Created by Joy on 16/6/28.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScrollView.h"
#import "MBProgressHUD.h"

@interface NEUPleasureViewController : UIViewController //<myScrollViewDelgeate>

@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong)NSMutableArray *imagesArray;
@property (nonatomic, strong)MyScrollView *myScrollView;
@property (assign) int page;
@end
