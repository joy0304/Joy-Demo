//
//  AppDelegate.m
//  TLCityPicker
//
//  Created by yuchen on 15/12/15.
//  Copyright © 2015年 yuchen. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TLCityPickerDelegate.h"

@interface TLCityPickerSearchResultController : UITableViewController <UISearchResultsUpdating>

@property (nonatomic, assign) id<TLSearchResultControllerDelegate>searchResultDelegate;

@property (nonatomic, strong) NSArray *cityData;

@end
