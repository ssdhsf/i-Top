//
//  AppDelegate+UmenShear.m
//  itop
//
//  Created by huangli on 2018/3/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "AppDelegate+UmenShear.h"

@implementation AppDelegate (UmenShear)


- (void)configUSharePlatforms{
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WECHAT_APP_ID appSecret:WECHAT_APP_SECRET redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:TENCENT_APP_ID/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SINA_APP_ID  appSecret:SINA_APP_SECRET redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

@end
