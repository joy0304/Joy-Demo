//
//  NEUTopicDataSource.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUTopicDataSource.h"
#import "NEUTableViewSectionObject.h"
#import "NEUTableViewBaseItem.h"
#import "NEUTopicCell.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation NEUTopicDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        AVQuery *query = [AVQuery queryWithClassName:@"Topic"];
        query.cachePolicy = kAVCachePolicyNetworkElseCache;//缓存策略
        query.maxCacheAge = 24*3600;
        NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:10];
        NSMutableArray *objectIdArr = [NSMutableArray arrayWithCapacity:10];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSArray<AVObject *> *todos = objects;
            for (AVObject *todo in todos) {
                id data = todo[@"localData"];
                if ([data isKindOfClass:[NSDictionary class]]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [objectIdArr addObject:todo.objectId];
                        NSString *topicName = data[@"topicName"];
                        NSLog(@"topicname === %@", topicName);
                        [itemArr addObject:[[NEUTableViewBaseItem alloc] initWithImage:[UIImage imageNamed:topicName] Title:topicName SubTitle:data[@"topicUrl"] AccessoryImage:nil]];
                        NSLog(@"topicurl url url=== %@", data[@"topicUrl"] );
                        NEUTableViewSectionObject *firstSectionObject = [[NEUTableViewSectionObject alloc] initWithItemArray:itemArr];
                        self.sections = [NSMutableArray arrayWithObjects:firstSectionObject, nil];
                        self.collectionBlock();
                    });
                }
                NSLog(@"todo = ===   %@", todo);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [defaults setObject:objectIdArr forKey:@"favouriteObjId"];
                [defaults synchronize];
            });
            
        }];
        
        NSLog(@"favouriteObjId ====  %@", [defaults objectForKey:@"topicObjId"]);
        NSLog(@"%@", itemArr);
    }
    return self;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(NEUTableViewBaseItem *)object {
    return [NEUTopicCell class];
}

#pragma  mark -- remove the certain row
- (void)removeObjectAtIndex:(NSInteger)section Rowindex:(NSInteger)rowIndex {
    NEUTableViewSectionObject *theSection = (NEUTableViewSectionObject *)self.sections[section];
    [theSection.items removeObjectAtIndex:rowIndex];
    
}

#pragma mark -- 实现cell的删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setEditing:YES animated:YES];
    return  UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle  forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setEditing:NO animated:YES];
    [self removeObjectAtIndex:indexPath.section Rowindex:indexPath.row];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *favouriteArr = [defaults objectForKey:@"topicObjId"];
    NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:favouriteArr];
    
    AVObject *deletedObj = [AVObject objectWithClassName:@"Topic" objectId:favouriteArr[indexPath.row] ];
    [deletedObj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"delete the object successfully");
        }else {
            NSLog(@"the error information is  %@",[error description]);
        }
    }];
    [mutableArr removeObjectAtIndex:indexPath.row];
    favouriteArr = [mutableArr copy];
    [defaults setObject:favouriteArr forKey:@"topicObjId"];
    NSLog(@"记得在数据源中删除数据!! %@", favouriteArr);
    [tableView reloadData];
    //记得在数据源中删除数据!!
}


@end
