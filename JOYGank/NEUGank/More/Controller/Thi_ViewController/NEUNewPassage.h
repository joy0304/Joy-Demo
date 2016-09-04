//
//  NEUNewPassage.h
//  NEUGank
//
//  Created by 周鑫城 on 8/12/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NEUNewPassage;

@protocol NEUReleaseControllerDelegate <NSObject>

-(void)releaser:(NEUNewPassage *)release title:(NSString *)title text:(NSString *)text;

@end

@interface NEUNewPassage : UIViewController

@property (nonatomic, strong) id<NEUReleaseControllerDelegate>delegate;

@end
