//
//  UIView+DYExtension.h
//  DYVander
//
//  Created by 卢达洋 on 16/3/17.
//  Copyright © 2016年 ludayang. All rights reserved.
//

#import <UIKit/UIKit.h>



#define SHOWINTOP       = @"CSToastPositionTop"
#define SHOWINCENTER    = @"CSToastPositionCenter"
#define PSHOWINBOTTOM   = @"CSToastPositionBottom"

@interface UIView (DYExtension)

typedef NS_ENUM(NSInteger, ToasPositions) {
  ToastPositionTop,
  ToastPositionCenter,
  ToastPositionBottom
};

/**
 *  设置圆角
 *
 *  @param cornerRadius 圆角半径
 */
-(void)makeRoundedCorner:(CGFloat)cornerRadius;

/**
 *  绘圆
 */
-(void)drawCircle;

-(void)drawBorder;

-(void)drawBorderWithColor:(UIColor *)color BorderWidth:(CGFloat)width;

-(void)drawShadow;

/**
 *  高斯模糊
 */
-(void)blurEffect;


/**
 *  带参数的高斯模糊效果
 *
 *  @param style 风格
 *  @param alpha 透明度
 */
-(void)blurEffectWithStyle:(UIBlurEffectStyle)style Alpha:(CGFloat)alpha;

//通过颜色来生成一个纯色图片
- (UIImage *)buttonImageFromColor:(UIColor *)color;

- (UIImage *)getImageWithColor:(UIColor *)color frame:(CGRect)rect;

@end
