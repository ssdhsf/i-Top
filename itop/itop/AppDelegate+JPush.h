//
//  AppDelegate+JPush.h
//  itop
//
//  Created by huangli on 2018/4/2.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (JPush)

- (void)jpushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
             appDelegate:(AppDelegate*)appdelegate;

- (void)jpushApplication:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

@end
