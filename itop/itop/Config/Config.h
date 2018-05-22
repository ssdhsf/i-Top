//
//  Config.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//


#ifndef Config_h
#define Config_h

#define CONFIG_PLIST    [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"]
#define CONFIG_DICTIONARY   [[NSDictionary alloc] initWithContentsOfFile:CONFIG_PLIST]

#define PUSHCONFIG_PLIST       [[NSBundle mainBundle] pathForResource:@"PushConfig" ofType:@"plist"]
#define PUSHCONFIG_DICTIONARY  [[NSDictionary alloc] initWithContentsOfFile:PUSHCONFIG_PLIST]
#define PUSHCONFIG_APP_KEY      PUSHCONFIG_DICTIONARY[@"APP_KEY"]
#define PUSHCONFIG_CHANNEL      PUSHCONFIG_DICTIONARY[@"CHANNEL"]

/**
 *    服务器环境设置
 *      1）开发环境：Develop
 *      2）测试环境：Testing
 *      3）正式环境：Product
 */
#ifdef DEBUG
#define SERVER_ENVIRONMENT @"Testing"
#else

#warning 记得修改环境
#define SERVER_ENVIRONMENT @"Product"
#endif

// 友盟 (UMeng)
#define UMengAppKey       CONFIG_DICTIONARY[@"UMeng"][@"UMengAppKey"]
#define UMengChannel      CONFIG_DICTIONARY[@"UMeng"][@"UMengChannel"]

// 百度地图 (baidu)
#define BAIDU_MAP_AKAPKEY           CONFIG_DICTIONARY[@"BaiduMap"][@"AKAPKEY"]

// WeChat
#define WECHAT_APP_ID     CONFIG_DICTIONARY[@"WeChat"][SERVER_ENVIRONMENT][@"appId"]
#define WECHAT_APP_SECRET     CONFIG_DICTIONARY[@"WeChat"][SERVER_ENVIRONMENT][@"appSecret"]

// Tencent
#define TENCENT_APP_ID    CONFIG_DICTIONARY[@"Tencent"][@"appId"]
#define TENCENT_APP_KEY    CONFIG_DICTIONARY[@"Tencent"][@"appkey"]

// Sina
#define SINA_APP_ID         CONFIG_DICTIONARY[@"Sina"][@"appId"]
#define SINA_APP_SECRET     CONFIG_DICTIONARY[@"Sina"][@"appkey"]

//searchList
#define SEARCH_LIST     @"Search_list"


// 触发token自动更新的剩余有效时长，默认2小时
#define kTokenValidTime 7200

#define COMMON_EASEMOB_PASSWORD @"12345678"

#define PYBarTintColor RGB(15, 16, 19)


// 解压后文件路径
#define UN_ZIP_FILE_FULL_PATH(fileName) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/%@", fileName]]

// 测试开发使用
#ifdef DEBUG

// 是否开启免输入帐号登录
#define FAST_LOGIN 1

#endif


#endif /* Config_h */
