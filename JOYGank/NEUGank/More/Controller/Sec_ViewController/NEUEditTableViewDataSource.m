//
//  NEUEditTableViewDataSource.m
//  NEUGank
//
//  Created by 周鑫城 on 8/2/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUEditTableViewDataSource.h"
#import "NEUTableViewSectionObject.h"
#import "NEUTableViewBaseItem.h"
#import "NEUEditTableViewCell.h"

@implementation NEUEditTableViewDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NEUTableViewSectionObject *firstSectionObject = [[NEUTableViewSectionObject alloc] initWithItemArray:[NSMutableArray arrayWithObjects:
                                                                                                              [[NEUTableViewBaseItem alloc] initWithImage:nil Title:[defaults objectForKey:@"nickName"]?[defaults objectForKey:@"nickName"]:@"请输入你的昵称" SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]],
                                                                                                              [[NEUTableViewBaseItem alloc] initWithImage:nil Title:[defaults objectForKey:@"signature"]?[defaults objectForKey:@"signature"]:@"跪求签名" SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]],
                                                                                                              [[NEUTableViewBaseItem alloc] initWithImage:nil Title:[defaults objectForKey:@"region"]?[defaults objectForKey:@"region"]:@"请输入你的所在地" SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]],
                                                                                                              [[NEUTableViewBaseItem alloc] initWithImage:nil Title:[defaults objectForKey:@"gender"]?[defaults objectForKey:@"gender"]:@"选择性别" SubTitle:nil AccessoryImage:[UIImage imageNamed:@"arrow"]],
                                                                                                              
                                                                                                        nil]];
        
        self.sections = [NSMutableArray arrayWithObjects:firstSectionObject, nil];
    }
    return self;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(NEUTableViewBaseItem *)object {
    return [NEUEditTableViewCell class];
}

@end
