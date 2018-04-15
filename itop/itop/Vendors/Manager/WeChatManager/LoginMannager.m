//
//  LoginMannager.m
//  itop
//
//  Created by huangli on 2018/2/1.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "LoginMannager.h"
#import "LoginViewController.h"

@implementation LoginMannager

+(instancetype)sheardLoginMannager{
    
    static LoginMannager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken ,^{
        
        manager = [[LoginMannager alloc]init];
    });
    
    return manager;
}

#pragma - mark 清除登录缓存
- (void)clearLoginUserMassage {
    
    [[Global sharedSingleton] delUserDefaultsWithKey:INFOMATION_EDIT_MODEL([[UserManager shareUserManager]crrentUserId])];//获取的用户的可编辑信息  //必须先清理用户的可编辑信息再清理用户的登陆信息  因为可编辑信息依赖登陆信息返回的用户id 
    [[Global sharedSingleton] delUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERINFOMATION];//登陆获取的用户信息
    [[Global sharedSingleton] delUserDefaultsWithKey:UD_CACHE_COOKIE];
    [[Global sharedSingleton] delUserDefaultsWithKey:UD_KEY_LAST_WECHTLOGIN_CODE];
    [[Global sharedSingleton] delUserDefaultsWithKey:WECHTLOGIN_CACHE_KEY];
}

#pragma mark 返回登陆页
//- (void)presentViewLoginViewController{
//    
//    AppDelegate *appdelegat = [UIManager appDelegate];
//    LoginViewController *vc = [[LoginViewController alloc] init];
//    ThemeNavigationController* loginNavigation = [[ThemeNavigationController alloc] initWithRootViewController:vc];
//    appdelegat.window.rootViewController = loginNavigation;
//    appdelegat.tabBarController = nil;
//}

@end
