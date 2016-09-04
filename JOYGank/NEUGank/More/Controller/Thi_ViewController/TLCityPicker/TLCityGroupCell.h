//
//  AppDelegate.m
//  TLCityPicker
//
//  Created by yuchen on 15/12/15.
//  Copyright © 2015年 yuchen. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TLCity.h"
#import "TLCityPickerDelegate.h"

@interface TLCityGroupCell : UITableViewCell

@property (nonatomic, assign) id<TLCityGroupCellDelegate>delegate;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSArray *cityArray;

+ (CGFloat) getCellHeightOfCityArray:(NSArray *)cityArray;

@end
