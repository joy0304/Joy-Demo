//
//  photoView.m
//  NEUGank
//
//  Created by 中软mac004 on 16/7/27.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "photoView.h"

@implementation photoView

- (instancetype)initWithName:(NSString*)name
{
    self = [super init];
    if (self) {
         self.image = [UIImage imageNamed:name];
        _old_width  = self.image.size.width;
        _old_height = self.image.size.height;
        
        //按照每列的宽度，以及图片的宽高来按比例压缩
        _new_width = NEUAPPWIDTH-10;
        _new_height = (_new_width/_old_width) * _old_height;
        
        self.frame = CGRectMake(0, 0, _new_width, _new_height);
        
    }
    return self;
}

@end
