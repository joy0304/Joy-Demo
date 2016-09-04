//
//  NEUBaseTableView.h
//  CustomTableView
//
//  Created by 周鑫城 on 7/14/16.
//  Copyright © 2016 ZXC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NEUTableViewDataSource.h"

@class NEUTableViewSectionObject;
@protocol NEUTableViewDelegate<UITableViewDelegate>

@optional

/**
 * 选择一个cell的回调，并返回被选择cell的数据结构和indexPath
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

- (UIView *)headerViewForSectionObject:(NEUTableViewSectionObject *)sectionObject atSection:(NSInteger)section;
- (void)willDeleteRow;

//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
// 下拉刷新触发的方法

- (void)pullDownToRefreshAction;

// 上拉加载触发的方法

- (void)pullUpToRefreshAction;

// 将来可以有 cell 的编辑，交换，左滑等回调

// 这个协议继承了UITableViewDelegate ，所以自己做一层中转，VC 依然需要实现某些代理方法。

@end

@interface NEUBaseTableView : UITableView<UITableViewDelegate>

@property (nonatomic, assign) id<NEUTableViewDataSource> NEUDataSource;

@property (nonatomic, assign) id<NEUTableViewDelegate> NEUDelegate;

// 是否需要下拉刷新和上拉加载
@property (nonatomic, assign) BOOL isNeedPullDownToRefreshAction;
@property (nonatomic, assign) BOOL isNeedPullUpToRefreshAction;

- (void)stopRefreshingAnimation;
- (void)triggerRefreshing;

@end