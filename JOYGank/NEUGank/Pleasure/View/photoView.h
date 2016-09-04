//
//  photoView.h
//  NEUGank
//
//  Created by 中软mac004 on 16/7/27.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface photoView : UIImageView
- (instancetype)initWithName:(NSString*)name;

@property (nonatomic, assign)float old_width;
@property (nonatomic, assign)float old_height;
@property (nonatomic, assign)float new_width;
@property (nonatomic, assign)float new_height;
@end
