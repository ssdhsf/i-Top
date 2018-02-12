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
 *  @param hasData 是否显示无数据背景图片
 *  @param frame  无数据背景图片的大小及位置
 */
- (void)setHasData:(BOOL)hasData andFrame:(CGRect)frame;

/**
 *  添加背景视图
 *
 *  移除无数据背景图片
 */
- (void)removeHiderView;

@end
