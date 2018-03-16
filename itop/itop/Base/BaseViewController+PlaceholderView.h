//
//  BaseViewController+PlaceholderView.h
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (PlaceholderView)

/**
 *  添加背景视图
 *
 *  @param isHasData 是否显示无数据背景图片
 *  @param noDataType 无具体数据类型
 *  @param originY  无数据背景图片的大小及位置
 */
//- (void)setisHasData:(BOOL)isHasData
//          noDataType:(NoDataType)noDataType
//              origin:(NSInteger)originY;

/**
 *
 *  移除无数据背景图片
 */
- (void)removeHiderView;

@end
