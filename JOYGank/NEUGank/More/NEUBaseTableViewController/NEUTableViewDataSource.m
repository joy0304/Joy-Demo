//
//  NEUTableViewDataSource.m
//  CustomTableView
//
//  Created by 周鑫城 on 7/14/16.
//  Copyright © 2016 ZXC. All rights reserved.
//

#import "NEUTableViewDataSource.h"
#import "NEUTableViewSectionObject.h"
#import "NEUBaseTableViewCell.h"
#import "NEUTableViewBaseItem.h"
#import <objc/runtime.h>

@implementation NEUTableViewDataSource

#pragma mark - NEUTableViewDataSource
- (NEUTableViewBaseItem *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sections.count > indexPath.section) {
        NEUTableViewSectionObject *sectionObject = [self.sections objectAtIndex:indexPath.section];
        if ([sectionObject.items count] > indexPath.row) {
            return [sectionObject.items objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

- (Class)tableView:(UITableView*)tableView cellClassForObject:(NEUTableViewBaseItem *)object {  // 这个方法会子类有机会重写，默认的 Cell 类型是 NEUBaseTableViewCell
    return [NEUBaseTableViewCell class];
}

- (void)clearAllItems {
    self.sections = [NSMutableArray arrayWithObject:[[NEUTableViewSectionObject alloc] init]];
}

- (void)appendItem:(NEUTableViewBaseItem *)item {
    NEUTableViewSectionObject *firstSectionObject = [self.sections objectAtIndex:0];
    [firstSectionObject.items addObject:item];
}

#pragma mark - UITableViewDataSource Required
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sections.count > section) {
        NEUTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        return sectionObject.items.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NEUTableViewBaseItem *object = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = [self tableView:tableView cellClassForObject:object];
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    
    NEUBaseTableViewCell* cell = (NEUBaseTableViewCell*)[tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:className];
    }
    [cell setObject:object];
    
    return cell;
}

#pragma mark - UITableViewDataSource Optional
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections ? self.sections.count : 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.sections.count > section) {
        NEUTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        return sectionObject.headerTitle;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (self.sections.count > section) {
        NEUTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        if (sectionObject != nil && sectionObject.footerTitle != nil && ![sectionObject.footerTitle isEqualToString:@""]) {
            return sectionObject.footerTitle;
        }
    }
    return nil;
}

#pragma mark - 回调函数
-(void)setCollectionBlock:(CollectionBlock)collectionBlock{
    if (_collectionBlock != collectionBlock) {
        _collectionBlock = collectionBlock;
    }
}


@end
