//
//  NEUMyPassageDataSource.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUMyPassageDataSource.h"
#import "NEUMyPassageCell.h"
#import "NEUMyPassageItem.h"
#import "NEUTableViewSectionObject.h"
#import "NEUTableViewBaseItem.h"
#import "NEUTableViewSectionObject.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UIImageView+WebCache.h"

@implementation NEUMyPassageDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"i am enumypassageDatasource inin method");
        AVQuery *query = [AVQuery queryWithClassName:@"Publication"];
        NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:10];
        NSMutableArray *objectIdArr = [NSMutableArray arrayWithCapacity:10];
//        NSMutableArray *imageUrl = [NSMutableArray arrayWithCapacity:10];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSArray<AVObject *> *todos = objects;
            for (AVObject *todo in todos) {
                id data = todo[@"localData"];
                if ([data isKindOfClass:[NSDictionary class]]) {
                    NSLog(@"%@", data[@"desc"]);
                    NSLog(@"%@", data[@"publishedTime"]);
                    UIImageView *myImage ;
                    [myImage sd_setImageWithURL:[NSURL URLWithString:data[@"imageUrl"]]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [objectIdArr addObject:todo.objectId];
                        //这里应该要处理imageUrl
                        NSLog(@"imageUrl imageUrl imageUrl == %@", data[@"imageUrl"]);
                        NSLog(@"myImage myImage myImage == %@", myImage);
                        NEUMyPassageItem *passageItem = [[NEUMyPassageItem alloc] initWithImage:myImage.image Title:data[@"desc"] SubTitle:data[@"publishedTime"] AccessoryImage:nil ArticleClass:data[@"articleCategory"] ImageUrl:data[@"imageUrl"] URL:data[@"url"]];
                        [itemArr addObject:passageItem];
                        NSLog(@" == %@", data[@"imageUrl"]);
                        NEUTableViewSectionObject *firstSectionObject = [[NEUTableViewSectionObject alloc] initWithItemArray:itemArr];
                        self.sections = [NSMutableArray arrayWithObjects:firstSectionObject, nil];
                        self.collectionBlock();
                    });
                }
                NSLog(@"todo = ===   %@", todo);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [defaults setObject:objectIdArr forKey:@"publicationId"];
                [defaults synchronize];
            });
        }];
        NSLog(@"publicationId ====  %@", [defaults objectForKey:@"publicationId"]);
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
    return [NEUMyPassageCell class];
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
    //    AVObject fet
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *publicationArr = [defaults objectForKey:@"publicationId"];
    NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:publicationArr];
    
    AVObject *deletedObj = [AVObject objectWithClassName:@"Publication" objectId:publicationArr[indexPath.row] ];
    [deletedObj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"delete the object successfully");
        }else {
            NSLog(@"the error information is  %@",[error description]);
        }
    }];
    [mutableArr removeObjectAtIndex:indexPath.row];
    publicationArr = [mutableArr copy];
    [defaults setObject:publicationArr forKey:@"publicationId"];
    NSLog(@"记得在数据源中删除数据!! %@", publicationArr);
    [tableView reloadData];
    //记得在数据源中删除数据!!
}

////设置进入编辑状态时，Cell不会缩进
//- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return NO;
//}


@end
