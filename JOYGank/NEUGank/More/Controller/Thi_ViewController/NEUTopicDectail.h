//
//  NEUTopicDectail.h
//  NEUGank
//
//  Created by 周鑫城 on 8/7/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NEUTopicDectail : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSString *topicURL;

- (instancetype)initWithTopicURL:(NSString *)topicURL;

@end
