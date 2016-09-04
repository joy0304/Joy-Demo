//
//  NEUCollectionDataSource.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUCollectionDataSource.h"
#import "NEUCollectionTableViewCell.h"
#import "NEUTableViewSectionObject.h"
#import "NEUTableViewBaseItem.h"
#import "NEUCollectionItem.h"
#import "NEUTableViewSectionObject.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation NEUCollectionDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"i am init  neucollectiondatasource");
        AVQuery *query = [AVQuery queryWithClassName:@"Favourite"];
        query.cachePolicy = kAVCachePolicyNetworkElseCache;//缓存策略
        query.maxCacheAge = 24*3600;
        NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:10];
        NSMutableArray *objectIdArr = [NSMutableArray arrayWithCapacity:10];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSArray<AVObject *> *todos = objects;
            for (AVObject *todo in todos) {
                id data = todo[@"localData"];
                if ([data isKindOfClass:[NSDictionary class]]){
                    NSLog(@"%@", data[@"desc"]);
                    NSLog(@"publishedName publishedName publishedTime = %@", data[@"publishedTime"]);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [objectIdArr addObject:todo.objectId];
                        NSString *articlePhotoNumber = [data[@"publishedTime"] substringWithRange:NSMakeRange(9, 1)];
                        NSLog(@"articlePhotoNumber articlePhotoNumber articlePhotoNumber = %@",articlePhotoNumber);
                        NSString *randStr = [NSString stringWithFormat:@"collection_%@",articlePhotoNumber];
                        [itemArr addObject:[[NEUCollectionItem alloc] initWithImage:[UIImage imageNamed:randStr] Title:data[@"desc"] SubTitle:data[@"publishedName"] AccessoryImage:nil Article: data[@"articleCategory"] URL:data[@"url"]]];
                        NSLog(@"%@", data[@"url"]);
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
        
        NSLog(@"favouriteObjId ====  %@", [defaults objectForKey:@"favouriteObjId"]);
        NSLog(@"%@", itemArr);
    }
    return self;
}


#pragma  mark -- remove the certain row
- (void)removeObjectAtIndex:(NSInteger)section Rowindex:(NSInteger)rowIndex {
    NEUTableViewSectionObject *theSection = (NEUTableViewSectionObject *)self.sections[section];
    [theSection.items removeObjectAtIndex:rowIndex];
    
}


- (Class)tableView:(UITableView *)tableView cellClassForObject:(NEUTableViewBaseItem *)object {
    return [NEUCollectionTableViewCell class];
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
    NSArray *favouriteArr = [defaults objectForKey:@"favouriteObjId"];
    NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:favouriteArr];
    
    AVObject *deletedObj = [AVObject objectWithClassName:@"Favourite" objectId:favouriteArr[indexPath.row] ];
    [deletedObj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"delete the object successfully");
        }else {
            NSLog(@"the error information is  %@",[error description]);
        }
    }];
    [mutableArr removeObjectAtIndex:indexPath.row];
    favouriteArr = [mutableArr copy];
    [defaults setObject:favouriteArr forKey:@"favouriteObjId"];
    NSLog(@"记得在数据源中删除数据!! %@", favouriteArr);
    [tableView reloadData];
    //记得在数据源中删除数据!!
}


@end
