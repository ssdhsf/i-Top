//
//  BaseCollectionViewController+DisposeSubView.h
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController (DisposeSubView)

/**
 *  处理列表数据
 *
 *  @param arr  获取的列表数据
 *  @param page 根据页码判断视图加载
 */
- (void)listDataWithListArray:(NSArray *)arr page:(NSInteger)page;


@end
