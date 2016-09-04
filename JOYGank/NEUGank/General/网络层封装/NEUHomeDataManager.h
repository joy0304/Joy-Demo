//
//  NEUHomeDataManager.h
//  NEUGank
//
//  Created by Joy on 16/7/12.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "NEUHTTPService.h"

@interface NEUHomeDataManager : NEUHTTPService

@end

@interface HomeModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *publishTime;
@property (nonatomic, copy) NSString *detailURL;

@end

