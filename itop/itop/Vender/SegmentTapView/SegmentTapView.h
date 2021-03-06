//
//  SegmentTapView.h
//  xixun
//
//  Created by huangli on 2017/9/11.
//  Copyright © 2017年 Vanber. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol SegmentTapViewDelegate <NSObject>
@optional
/**
 选择index回调
 
 @param index
 */
-(void)selectedIndex:(NSInteger)index;
@end

@interface SegmentTapView : UIView

/**
 选择回调
 */
@property (nonatomic, assign)id<SegmentTapViewDelegate> delegate;
/**
 数据源
 */
@property (nonatomic, strong)NSArray *dataArray;
/**
 字体非选中时颜色
 */
@property (nonatomic, strong)UIColor *textNomalColor;
/**
 字体选中时颜色
 */
@property (nonatomic, strong)UIColor *textSelectedColor;
/**
 横线颜色
 */
@property (nonatomic, strong)UIColor *lineColor;
/**
 字体大小
 */
@property (nonatomic, assign)CGFloat titleFont;

@property (nonatomic, strong)NSMutableArray *buttonsArray;

@property (nonatomic, strong)UIImageView *lineImageView;//下滑线

/**
 *  初始背景颜色
 */
@property (nonatomic, strong) UIColor *beginBackgroundColor;

/**
 *  选中背景颜色
 */
@property (nonatomic, strong) UIColor *selectorBackgroundColor;


/**
 *  标签圆角半径,默认为0
 */
@property (nonatomic, assign) CGFloat tagCornerRadius;

/**
 *  边框宽度
 */
@property (nonatomic, assign) CGFloat borderWidth;


/**
Initialization
 
 @param frame     fram
 @param dataArray 标题数组
 @param font      标题字体大小
 
 @return instance
 */
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray withFont:(CGFloat)font;
/**
 手动选择
 
 @param index inde（从1开始）
 */
-(void)selectIndex:(NSInteger)index;

/**
 加载控件
 */
-(void)addSubSegmentView;

@end
