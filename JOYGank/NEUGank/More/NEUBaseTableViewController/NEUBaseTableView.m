//
//  NEUBaseTableView.m
//  CustomTableView
//
//  Created by 周鑫城 on 7/14/16.
//  Copyright © 2016 ZXC. All rights reserved.
//

#import "NEUBaseTableView.h"
#import "NEUBaseTableViewCell.h"
#import "NEUTableViewSectionObject.h"
#import "NEUTableViewBaseItem.h"
#import "MJRefresh.h"

@implementation NEUBaseTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.separatorColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.sectionHeaderHeight = 0;
        self.sectionFooterHeight = 0;
        self.delegate = self;
        self.isNeedPullDownToRefreshAction = NO;
        self.isNeedPullUpToRefreshAction = NO;
    }
    return self;
}

- (void)setNEUDataSource:(id<NEUTableViewDataSource>)NEUDataSource {
    if (_NEUDataSource != NEUDataSource) {
        _NEUDataSource = NEUDataSource;
        self.dataSource = NEUDataSource;
    }
}

#pragma mark - 上拉加载和下拉刷新
- (void)setIsNeedPullDownToRefreshAction:(BOOL)isEnable {
    if (_isNeedPullDownToRefreshAction == isEnable) {
        return;
    }
    _isNeedPullDownToRefreshAction = isEnable;
    __block typeof(self) weakSelf = self;
    if (_isNeedPullDownToRefreshAction) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if ([weakSelf.NEUDelegate respondsToSelector:@selector(pullDownToRefreshAction)]) {
                [weakSelf.NEUDelegate pullDownToRefreshAction];
            }
        }];
        
    }
}

- (void)setIsNeedPullUpToRefreshAction:(BOOL)isEnable
{
    if (_isNeedPullUpToRefreshAction == isEnable) {
        return;
    }
    _isNeedPullUpToRefreshAction = isEnable;
    __block typeof(self) weakSelf = self;
    if (_isNeedPullUpToRefreshAction) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if ([weakSelf.NEUDelegate respondsToSelector:@selector(pullUpToRefreshAction)]) {
                [weakSelf.NEUDelegate pullUpToRefreshAction];
            }
        }];
    }
}

- (void)stopRefreshingAnimation {
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

- (void)triggerRefreshing {
    [self.mj_header beginRefreshing];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    id<NEUTableViewDataSource> dataSource = (id<NEUTableViewDataSource>)tableView.dataSource;
    
    NEUTableViewBaseItem *object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cls = [dataSource tableView:tableView cellClassForObject:object];
    
    if (object.cellHeight == CellInvalidHeight) { // 没有高度缓存
        object.cellHeight = [cls tableView:tableView rowHeightForObject:object];
    }
    return object.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.NEUDelegate respondsToSelector:@selector(didSelectObject:atIndexPath:)]) {
        id<NEUTableViewDataSource> dataSource = (id<NEUTableViewDataSource>)tableView.dataSource;
        id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
        [self.NEUDelegate didSelectObject:object atIndexPath:indexPath];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else if ([self.NEUDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.NEUDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.NEUDelegate respondsToSelector:@selector(headerViewForSectionObject:atSection:)]) {
        id<NEUTableViewDataSource> dataSource = (id<NEUTableViewDataSource>)tableView.dataSource;
        NEUTableViewSectionObject *sectionObject = [((NEUTableViewDataSource *)dataSource).sections objectAtIndex:section];
        
        return [self.NEUDelegate headerViewForSectionObject:sectionObject atSection:section];
    }
    else if ([self.NEUDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.NEUDelegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

#pragma mark - 传递原生协议

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.NEUDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.NEUDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

@end
