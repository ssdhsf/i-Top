//
//  UIColor+CAGradientLayer.h
//  itop
//
//  Created by huangli on 2018/1/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CAGradientLayer)

+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view
                                   fromColor:(NSString *)fromHexColorStr
                                     toColor:(NSString *)toHexColorStr;

+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr alpha:(CGFloat)alpha;

+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr alpha:(CGFloat)alpha gradientLayer:(CAGradientLayer*)gradientLayer;

@end
