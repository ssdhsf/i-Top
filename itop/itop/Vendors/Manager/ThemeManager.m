//
//  ThemeManager.m
//  xixun
//
//  Created by huangli on 16/9/1.
//  Copyright © 2016年 3N. All rights reserved.
//

#import "ThemeManager.h"

static ThemeManager *sigleton = nil;

@implementation ThemeManager

- (id)init {
    self = [super init];
    if (self != nil) {
        
        self.themeName = @"blue";
        self.lan = @"china";
        //初始化字体配置文件
        NSString *lanConfigPath = [[NSBundle mainBundle] pathForResource:@"china" ofType:@"plist"];
        _lanConfig = [NSDictionary dictionaryWithContentsOfFile:lanConfigPath];
        
    }
    return self;
}

#pragma mark Class Method
+ (ThemeManager *)shareInstance
{
    static ThemeManager * this = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        this = [[self alloc] init];
    });
    return this;
}

- (void)setThemeName:(NSString *)themeName {
    if (_themeName != themeName) {
        
        _themeName = [themeName copy];
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@fontColor",_themeName] ofType:@"plist"];
    self.fontConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
}

-(void)setLan:(NSString *)lan
{
    if (_lan !=lan) {
        _lan = [lan copy];
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",_lan] ofType:@"plist"];
    self.lanConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
}

//获取当前主题下的图片
- (UIImage *)getThemeImage:(NSString *)imageName {
    
    
    if (imageName.length == 0) {
        return nil;
    }
    
    NSString *imagename = [NSString stringWithFormat:@"%@%@",_themeName,imageName];
    UIImage *image = [UIImage imageNamed:imagename];
    return image;
}

//返回当前主题下的颜色
- (UIColor *)getColorWithName:(NSString *)name {
    if (name.length == 0) {
        return nil;
    }
    
    
    NSString *rgb = [self.fontConfig objectForKey:name];
    NSArray *rgbs = [rgb componentsSeparatedByString:@","];
    if (rgbs.count == 3) {
        float r = [rgbs[0] floatValue];
        float g = [rgbs[1] floatValue];
        float b = [rgbs[2] floatValue];
        UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
        return color;
    }
    
    return nil;
}
- (NSString *)getlanWithName:(NSString *)name
{
    if (name.length == 0) {
        return nil;
    }
    
    
    NSString *lan = [self.lanConfig objectForKey:name];
    return lan;
    
}


@end
