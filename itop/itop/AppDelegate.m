//
//  AppDelegate.m
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+WeChat.h"
#import "AppDelegate+UmenShear.h"
#import <Reachability.h>
#import "AppDelegate+BaiduMap.h"
#import "KeychainItemWrapper.h"
#import "AppDelegate+JPush.h"

@interface AppDelegate ()< JPUSHRegisterDelegate,UNUserNotificationCenterDelegate > {
    
@private
    Reachability *hostReach;
}

@property(nonatomic)BOOL isLaunchedByNotification; //用于标识用户是否通过点击通知消息进入本应用

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:0.1];
//    [UIManager loadinglaunchImageView];
    [UIManager makeKeyAndVisible];
    // 启动画面的显示时间为2秒
    [UMConfigure initWithAppkey:UMengAppKey channel:UMengChannel];
    [MobClick setScenarioType:E_UM_NORMAL];
    [self setupWeChat];
    [self configUSharePlatforms];
//#ifdef DEBUG

    NSLog(@"id:------>%@", [OSHelper bundleSeedIDTest]);
//    }
//#endif
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(reachabilityChanged:)
                                                name:kReachabilityChangedNotification
                                              object:nil];
    hostReach = [Reachability
                 reachabilityWithHostName:@"www.apple.com"]; //可以以多种形式初始化
    [hostReach startNotifier]; //开始监听,会启动一个run loop
    [IQKeyboardManager load];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [self setupBaiduMap];
    [self  setKeyChainValue];
#if TARGET_IPHONE_SIMULATOR
    
    //模拟器不接收推送信息和闪退统计
#else
    
    [self jpushApplication:application didFinishLaunchingWithOptions:launchOptions appDelegate:self];
    
#endif
    
    //当用户通过点击通知消息进入应用时，获得推送消息内容。如果remoteNotification不为空,则说明用户通过推送消息进入
    NSDictionary *remoteNotification = [launchOptions
                                        objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification) {
        _isLaunchedByNotification = YES;
    } else {
        _isLaunchedByNotification = NO;
    }

    return YES;
}

//注册apple成功获取token
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [self jpushApplication:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    // registrationID 只在注册成功能获取到
    NSString *registId = [JPUSHService registrationID];
    if (![Global stringIsNullWithString:registId]) {
        
        NSDictionary *dic = @{REGISTRATION_KEY : registId};
        [[NSNotificationCenter defaultCenter]postNotificationName:Notification_REGISTRATION_ID object:nil userInfo:dic];
        [[Global sharedSingleton] setUserDefaultsWithKey:JPUSH_REGISTRATION_ID
                                                andValue:registId];
    }
}

//注册apple失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificwationsWithError:(NSError *)error
{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

//iOS10前台处理收到的消息
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
    
}

//接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [JPUSHService handleRemoteNotification:userInfo];
}

//处理通知 iOS10以下版本
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    if (_isLaunchedByNotification ||
        application.applicationState == UIApplicationStateActive) {
        //推页面处理
        [[NSNotificationCenter defaultCenter] postNotificationName:JPUSH_Notification_PresentView
                                                            object:self
                                                          userInfo:userInfo];
        if (application.applicationState != UIApplicationStateActive) {
            //      self.masterVC.selectedIndex = 0;
        }
    } else {
        //程序前台中提示处理
        [[NSNotificationCenter defaultCenter] postNotificationName:JPUSH_Notification_ShowNotice
                                                            object:self
                                                          userInfo:userInfo];
    }
    // 接收到推送通知之后
//    [JPUSHService setBadge: [ChatViewController getUnreadNotificationCountAndChatCount]];
//    [[LZPushManager manager] syncBadge];
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
    // 接收通知时候触发
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSLog(@"非活动");
    if ([[UserManager shareUserManager] isLogin] && ![Global stringIsNullWithString:[[UserManager shareUserManager]crrentUserInfomation].token]) {
        [[LoginMannager sheardLoginMannager]stopTimer];
    }
//    [UIApplication sharedApplication].applicationIconBadgeNumber = [ChatViewController getUnreadNotificationCountAndChatCount];
//    [JPUSHService setBadge: [ChatViewController getUnreadNotificationCountAndChatCount]];
//    [[LZPushManager manager] syncBadge];
    // Sent when the application is about to move from active to inactive state.
    // This can occur for certain types of temporary interruptions (such as an
    // incoming phone call or SMS message) or when the user quits the application
    // and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down
    // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSLog(@"进入后台");
    
    if ([[UserManager shareUserManager] isLogin] && ![Global stringIsNullWithString:[[UserManager shareUserManager]crrentUserInfomation].token]) {
       [[LoginMannager sheardLoginMannager]stopTimer];
    }
    
//    [UIApplication sharedApplication].applicationIconBadgeNumber = [ChatViewController getUnreadNotificationCountAndChatCount];
//    [JPUSHService setBadge: [ChatViewController getUnreadNotificationCountAndChatCount]];
//    [[LZPushManager manager] syncBadge];
    
    // Use this method to release shared resources, save user data, invalidate
    // timers, and store enough application state information to restore your
    // application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called
    // instead of applicationWillTerminate: when the user quits.
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(nonnull NSURL *)url{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    
    if (!result) {
        
    }else{
       
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    
    return NO;
}

-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (result == FALSE){
        //调用其他SDK，例如支付宝SDK等
        NSLog(@"添加了系统回调，在appdelegate类里");
        //        result = [Pingpp handleOpenURL:url withCompletion:nil];
        
    }

    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    
    [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    if (result == NO){
        //调用其他SDK，例如支付宝SDK等
        NSLog(@"添加了系统回调，在appdelegate类里");
//        result = [Pingpp handleOpenURL:url withCompletion:nil];
        
    }
    return result;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
     NSLog(@"进入前台");
    
    if ([[UserManager shareUserManager] isLogin] && ![Global stringIsNullWithString:[[UserManager shareUserManager]crrentUserInfomation].token]) {
        
        [[LoginMannager sheardLoginMannager]automaticContinueToken];
        [[LoginMannager sheardLoginMannager]initTimer];
    }
    
    
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"活动");
//    if ([[UserManager shareUserManager] isLogin]) {
//
//        [[LoginMannager sheardLoginMannager]automaticContinueToken];
//        [[LoginMannager sheardLoginMannager]initTimer];
//
//    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  设置uuid
 */
- (void)setKeyChainValue {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Entitlements" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *array = [data valueForKey:@"keychain-access-groups"];
    NSString *accessGroup = array[0];
    KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc]
                                         initWithIdentifier:@"TestUUID"
                                         accessGroup:accessGroup];
    NSString *strUUID = [keyChainItem objectForKey:(__bridge id)kSecValueData];
    if (![Global stringIsNullWithString:strUUID]) {
        NSString *uuid = [OSHelper gen_uuid];
        [keyChainItem setObject:uuid forKey:(__bridge id)kSecValueData];
    }
    
        NSLog(@"uuid in keyChain---------:%@", [OSHelper getKeyChainValue]);
        NSLog(@"uuid ---------:%@", [OSHelper gen_uuid]);
}

//监听到网络状态改变
- (void)reachabilityChanged:(NSNotification *)note{
    
    Reachability *curReach = [note object];
    
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    
    [self updateInterfaceWithReachability:curReach];
}

//处理连接改变后的情况
- (void)updateInterfaceWithReachability:(Reachability *)curReach{
    
    //对连接改变做出响应的处理动作。
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == 1) {
        NSLog(@"\n网络--3g/2G\n");
    } else if (status == 2) {
        NSLog(@"\n网络--wifi\n");
    } else if (status == 0) {
        NSLog(@"\n网络--无网络\n");
    }
}

-(void)AlertOperation{
    
//    _isUpdataInfo = YES;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改个人信息成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续修改" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
//        [self back];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self.tabBarController presentViewController:alertController animated:YES completion:nil];
}



@end
