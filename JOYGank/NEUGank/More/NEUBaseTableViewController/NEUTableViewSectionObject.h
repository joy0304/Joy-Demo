//
//  NEUTableViewSectionObject.h
//  CustomTableView
//
//  Created by 周鑫城 on 7/14/16.
//  Copyright © 2016 ZXC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEUTableViewSectionObject : NSObject

@property (nonatomic, copy) NSString *headerTitle; //UITableDataSource协议中的 titleForHeaderInSection 方法可能会用到
@property (nonatomic, copy) NSString *footerTitle; //UITableDataSource协议中的 titleForFooterInSection 方法可能会用到
@property (nonatomic, copy) UIView *headerView;
@property (nonatomic, copy) UIView *footerView;
@property (nonatomic, strong) NSMutableArray *items;

- (instancetype)initWithItemArray:(NSMutableArray *)items;

@end