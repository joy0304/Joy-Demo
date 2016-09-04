//
//  NEUBaseSwipeController.h
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NEUTableViewController;

@interface NEUBaseSwipeController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NEUTableViewController *leftTableViewController;
@property (nonatomic, strong) NEUTableViewController * rightTableViewController;

- (instancetype)initWithLeftController:(NEUTableViewController *)leftController rightController:(NEUTableViewController *)rightController;
- (void)swipeToView:(UISwipeGestureRecognizer *)sender;

@end
