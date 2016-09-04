//
//  AppDelegate.m
//  TLCityPicker
//
//  Created by yuchen on 15/12/15.
//  Copyright © 2015年 yuchen. All rights reserved.
//


#import <Foundation/Foundation.h>

@class TLCity;
@class TLCityPickerController;

@protocol TLCityPickerDelegate <NSObject>

- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController
                    didSelectCity:(TLCity *)city;

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController;

@end

@protocol TLCityGroupCellDelegate <NSObject>

- (void) cityGroupCellDidSelectCity:(TLCity *)city;

@end

@protocol TLSearchResultControllerDelegate <NSObject>

- (void) searchResultControllerDidSelectCity:(TLCity *)city;

@end
