//
//  NEUTopicScrollView.h
//  NEUGank
//
//  Created by Joy on 16/6/29.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NEUTopicItemViewDelegate <NSObject>
- (void)topicViewdDidSelectCategory:(NSString *)category;
@end

@class NEUTopicItemView;
@interface NEUTopicScrollView : UIView

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NEUTopicItemView *topicItemView;
@property (nonatomic, strong) UIView *ContainerView;
@property (nonatomic, weak) id<NEUTopicItemViewDelegate> delegate;

@end
