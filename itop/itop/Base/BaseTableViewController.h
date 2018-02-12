//
//  BaseTableViewController.h
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController.h"

@class ApplicationTableViewDataSource;

@interface BaseTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray; //数据
@property (nonatomic, assign) NSInteger page_no; //加载页

@property (nonatomic) BOOL showRefreshHeader;//是否支持下拉刷新
@property (nonatomic) BOOL showRefreshFooter;//是否支持上拉加载
@property (nonatomic) BOOL showTableBlankView;//是否显示无数据时默认背景

- (void)tableViewDidTriggerHeaderRefresh;//下拉刷新事件
- (void)tableViewDidTriggerFooterRefresh;//上拉加载事件
- (void)showRefresh;//是否支持下拉上拉刷新数据

/**
 *  加载tableView视图
 *
 *  @param frame 初始化tableViewFrame大小
 */
- (void)initTableViewWithFrame:(CGRect )frame;

/**
 *  TableView指定代理
 */
- (void)steupTableViewWithDataSource:(ApplicationTableViewDataSource *)dataSource
                      cellIdentifier:(NSString *)identifier
                             nibName:(NSString *)nibName;

/**
 *  结束头视图和脚视图loading
 */
- (void)tableViewEndRefreshing;

/**
 *  下拉刷新
 */
- (void)tableViewbeginRefreshing;


/**
 *  上拉／下拉刷新数据加载数据
 */
- (void)refreshData;

@end
