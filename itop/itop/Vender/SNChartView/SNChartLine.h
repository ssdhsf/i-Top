//
//  WChartLine.h
//  WChartView
//
//  Created by wangsen on 15/12/13.
//  Copyright © 2015年 wangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat chartLineStartX = 40.f;
#define chartLineTheXAxisSpan (ScreenWidth - 80)/6.0
//static const CGFloat chartLineTheXAxisSpan = (ScreenWidth - 72)/6;
static const CGFloat chartLineTheYAxisSpan = 32.f;

@interface SNChartLine : UIView

@property (nonatomic, strong) NSArray * xValues;
@property (nonatomic, strong) NSArray * yValues;

@property (nonatomic, assign) CGFloat yMax;

@property (nonatomic, assign) BOOL curve;//是否曲线

/**
 *  @author sen, 15-12-24 10:12:59
 *
 *  开始绘制图表
 */
- (void)startDrawLines;

@end
