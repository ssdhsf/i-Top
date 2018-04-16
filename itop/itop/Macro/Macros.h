//
//  Macros.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ApiMacros.h"

#ifndef Macros_h
#define Macros_h

// 缓存最后登录帐户信息
#define UD_KEY_LAST_LOGIN_USERINFOMATION      @"UserInfomation"   // 登陆返回信息
#define INFOMATION_EDIT_MODEL(__USER_ID)      [NSString stringWithFormat:@"InfomationModel_%@",__USER_ID]         // 登陆返回信息

#define UD_KEY_LAST_WECHTLOGIN_CODE      @"Wechat_code"   // 微信登陆返回信息
#define WECHTLOGIN_CACHE_KEY      @"Cache_key"   // 微信登陆返回信息
#define UD_KEY_LAST_LOGIN_USERNAME            @"LastLoginUsername"//账户名
#define UD_KEY_LAST_LOGIN_PASSWORD            @"LastLoginPassword"//密码
#define UD_CACHE_COOKIE      @"cookie"   // 登陆返回信息

// 当前设备的屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeigh [UIScreen mainScreen].bounds.size.height
//适配
#define  KadapterW   ScreenWidth/375
#define  KadapterH   ScreenHeigh/667

//当前视图控制器View的宽度高度
#define ViewWidth self.view.frame.size.width
#define ViewHeigh self.view.frame.size.height

/** 初始化ControllerView  Frame */
#define ControllerViewFrame(__X, __Y, __Width, __Heigh) CGRectMake(__X, __Y, __Width, __Heigh)

/** 初始化TableView Frame */
#define TableViewFrame(__X, __Y, __Width, __Heigh) CGRectMake(__X, __Y, __Width, __Heigh)


#define REGISTRATION_KEY @"regist_key"
#define Notification_REGISTRATION_ID @"registration_id"
#define JPUSH_REGISTRATION_ID @"RegistrationID"
#define JPUSH_Notification_PresentView       @"PresentView"
#define JPUSH_Notification_ShowNotice        @"ShowNotice"

//颜色配置
#define RGB(__R, __G, __B)\
    [UIColor colorWithRed:(__R) / 255.0f\
                    green:(__G) / 255.0f\
                     blue:(__B) / 255.0f\
                    alpha:1.0]


/**
 *  输入16进制值获取颜色
 *
 *  @param rgbValue 16进制值
 *
 *  @return UIColor
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define XGBVColor UIColorFromRGB(0xf5f9fb)

#define DEFULT_BUTTON_CAGRADIENTLAYER(__BUTTON) [UIColor setGradualChangingColor: __BUTTON fromColor:@"FFA5EC" toColor:@"B499F8"]

//背景浅灰
#define XBackGrayColor                                                         \
[UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.0f]


// 默认导航栏  状态
#define XBlueColor  UIColorFromRGB(0x1790ed)

#define HEXCOLOR(__A) [UIColor colorWithHexString:[NSString stringWithFormat:@"#%@",__A]]

#define TABBER_CHAT_OFF RGB(249, 111, 48)
#define TABBER_CHAT_NO RGB(150, 150, 150)

#define RandomColor [UIColor colorWithRed:arc4random_uniform(255.0)/255.0 green:arc4random_uniform(255.0)/255.0 blue:arc4random_uniform(255.0)/255.0 alpha:1]

// 字体灰99
#define XFontGrayColor                                                         \
[UIColor colorWithRed:0.600f green:0.600f blue:0.600f alpha:1.0f]

// 时间格式
#define TIME_PATTERN_day    @"yyyy-MM-dd"
#define TIME_PATTERN_minute @"yyyy-MM-dd HH:mm"
#define TIME_PATTERN_second @"yyyy-MM-dd HH:mm:ss"
#define TIME_PATTERN_day_stye    @"yyyy/MM/dd"
#define TIME_PATTERN_minute_stye @"yyyy/MM/dd HH:mm"

#define TIME_PATTERN_month_day    @"MM-dd"


// 获取ApplicationDelegate
#define ApplicationDelegate  (AppDelegate *)[UIApplication sharedApplication].delegate

// 倒计时时间
#define kTimeout 60

// 字母数字
#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

//背景图
#define PlaceholderImage [UIImage imageNamed:@"home_icon_portrait_default"]
#define H5PlaceholderImage [UIImage imageNamed:@"img_default"]
#define ArticlePlaceholderImage [UIImage imageNamed:@"hotimg_bg_default"]

#define FOCUSSTATETITLE_NOFOCUS @"关 注"
#define FOCUSSTATETITLE_FOCUS @"已关注"
#define FOCUSSTATETITLE_SUCCESSFOCUS @"关注成功"
#define FOCUSSTATETITLE_CANCELFOCUS @"已取消关注"

#define WX_ACCESS_TOKEN @"WX_access_token"
#define WXOPENID @"WX_open_id"
#define WX_REFRESH_TOKEN @"WX_refresh_token"
#define WX_BASE_URL @"https://api.weixin.qq.com"


#define TIPSMESSEGE(__CONTENT) [NSString stringWithFormat:@"请输入%@",__CONTENT]
#define TIPSMESSEGESELECT(__CONTENT) [NSString stringWithFormat:@"请选择%@",__CONTENT]
#define TIPSMESSEGEADD(__CONTENT) [NSString stringWithFormat:@"请添加%@",__CONTENT]


//#define  WeakSelf() __weak typeof(self) weakSelf = self;

#endif /* Macros_h */
