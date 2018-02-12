//
//  ThemeManager.h
//  xixun
//
//  Created by huangli on 16/9/1.
//  Copyright © 2016年 3N. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kThemeDidChangeNotification @"kThemeDidChangeNotification"
//更主题的通知

#define kThemeDidChangeLanNotification @"kThemeDidChangeLanNotification"

@interface ThemeManager : NSObject{

@private
//主题配置信息
NSDictionary *_themesConfig;
}
//当前使用的主题名称
@property(nonatomic,copy)NSString *themeName;

@property(nonatomic,copy)NSString *lan;

@property(nonatomic,retain)NSDictionary *lanConfig;


//主题的配置信息
@property(nonatomic,retain)NSDictionary *themesConfig;
//字体的配置信息
@property(nonatomic,retain)NSDictionary *fontConfig;

+ (ThemeManager *)shareInstance;

//获取当前主题下的图片
- (UIImage *)getThemeImage:(NSString *)imageName;

//返回当前主题下的颜色
- (UIColor *)getColorWithName:(NSString *)name;

- (NSString *)getlanWithName:(NSString *)name;
@end
