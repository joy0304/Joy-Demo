//
//  NEUTableViewDataSource.h
//  CustomTableView
//
//  Created by 周鑫城 on 7/14/16.
//  Copyright © 2016 ZXC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CollectionBlock)();

@class NEUTableViewBaseItem;

@protocol NEUTableViewDataSource <UITableViewDataSource>
@optional

- (NEUTableViewBaseItem *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;
- (Class)tableView:(UITableView*)tableView cellClassForObject:(NEUTableViewBaseItem *)object;

@end

@interface NEUTableViewDataSource : NSObject<NEUTableViewDataSource>

@property (copy,nonatomic)CollectionBlock collectionBlock;
//@property (nonatomic, strong) NSMutableArray *urlArr;
@property (nonatomic, strong) NSMutableArray *sections;  // 二维数组，每个元素都是一个 SectionObject

- (void)clearAllItems;
- (void)appendItem:(NEUTableViewBaseItem *)item;

@end
