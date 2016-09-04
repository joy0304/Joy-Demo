//
//  NEUSettingController.h
//  NEUGank
//
//  Created by 周鑫城 on 8/4/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUTableViewController.h"

typedef void(^sendValue)(NSString *value);

@interface NEUSettingController : NEUTableViewController

@property (nonatomic, copy)sendValue sendValueBlock;
@property (nonatomic, strong)UIButton *logButton;

@end
