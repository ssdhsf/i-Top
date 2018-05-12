//
//  NSString+AttributedString.h
//  itop
//
//  Created by huangli on 2018/3/20.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AttributedString)

/********************************************************************
 *  返回包含关键字的富文本编辑
 *
 *  @param lineSpacing 行高
 *  @param textcolor   字体颜色
 *  @param font        字体
 *  @param KeyColor    关键字字体颜色
 *  @param KeyFont     关键字字体
 *  @param KeyWords    关键字数组
 *
 *  @return
 ********************************************************************/
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font
                                    withKeyTextColor:(UIColor *)KeyColor
                                             keyFont:(UIFont *)KeyFont
                                            keyWords:(NSArray *)KeyWords;


-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font;


-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace
                               withFont:(UIFont*)font
                              withWidth:(CGFloat)width ;

-(NSMutableAttributedString*)setupAttributedString:(CGFloat)stringNumber color:(UIColor*)color string:(NSString *)string;

@end
