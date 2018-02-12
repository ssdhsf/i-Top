//
//  BaseCollectionViewController.h
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController.h"

@class ApplicationCollectionViewDataSource;

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *collectionView;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page_no; //加载页

@property (nonatomic) BOOL showRefreshHeader;//是否支持下拉刷新
@property (nonatomic) BOOL showRefreshFooter;//是否支持上拉加载
@property (nonatomic) BOOL showTableBlankView;//是否显示无数据时默认背景

- (void)collectionViewDidTriggerHeaderRefresh;//下拉刷新事件
- (void)collectionViewDidTriggerFooterRefresh;//上拉加载事件
- (void)showRefresh;//是否支持下拉上拉刷新数据

/**
 *  结束头视图和脚视图loading
 */
- (void)collectionEndRefreshing;

/**
 *  下拉刷新
 */
- (void)collectionBeginRefreshing;

/**
 *  结束头视图和脚视图loading
 */
- (void)collectionViewEndRefreshing;

/**
 *  下拉刷新
 */
- (void)collectionViewbeginRefreshing;


/**
 *  上拉／下拉刷新数据加载数据
 */
- (void)refreshData;


/**
 *  加载CollectionView视图
 *
 *  @param frame 初始化CollectionViewFrame大小
 *  @param flowLayout UICollectionViewFlowLayout
 */
- (void)initCollectionViewWithFrame:(CGRect )frame
                         flowLayout:(UICollectionViewFlowLayout *)flowLayout;

/**
 *  TableView指定代理
 */
- (void)steupCollectionViewWithDataSource:(ApplicationCollectionViewDataSource *)dataSource
                           cellIdentifier:(NSString *)identifier
                                  nibName:(NSString *)nibName;

@end
