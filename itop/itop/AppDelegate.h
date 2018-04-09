//
//  AppDelegate.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTabBarController.h"
#import <AdSupport/ASIdentifierManager.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
// 这里是iOS10需要用到的框架
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MyTabBarController * tabBarController;


@end

