//
//  NEUPleasureDataManager.h
//  NEUGank
//
//  Created by Joy on 16/7/27.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUHTTPService.h"

@interface NEUPleasureDataManager : NEUHTTPService

@end

@interface PleasureModel : NSObject

@property (nonatomic, copy) NSString *imageID;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *publishTime;
@property (nonatomic, copy) NSString *imageURL;

@end