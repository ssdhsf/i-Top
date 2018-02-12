//
//  UIManager.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserManager.h"
#import "LeaveViewController.h"

@interface UIManager : NSObject

+ (instancetype)sharedUIManager;

+ (AppDelegate *)appDelegate;
+ (UIWindow *)keyWindow;
+ (UIWindow *)newWindow;

/**
 *  显示主窗口
 */
+ (void)makeKeyAndVisible;

/**
 *  是否隐藏tebbar
 */
//+ (void)hideTabBar:(BOOL)animated;

/**
 *  进入主界面
 */
+ (void)goMianViewController;

+ (UIViewController *)viewControllerWithName:(NSString *)vcName;
/**
 *  通过视图控制器名称进入某个控制器(rootVC为TabBarController)
 *
 *  @param vcName 视图控制器名称
 */
+ (void)rootVCTabBarControllerShowVC:(NSString *)vcName;

/**
 *  通过视图控制器名称进入某个控制器(rootVC为NavigationController)
 *
 *  @param vcName 视图控制器名称
 *  @param pushVC 通过某一个视图控制器获得改视图控制器的导航视图
 *  @param animated 动画
 */
+ (void)rootVCNavigationControllerShowVC:(NSString *)vcName
                                  pushVC:(UIViewController*)pushVC
                                animated:(BOOL)animated;

/**
 *  获取当前视图控制器
 *
 *  @return 当前视图控制器
 */
- (UIViewController*)topViewController;

/**
 *  注册Nib
 *
 *  @nibName nib name
 */
- (UINib *)nibWithNibName:(NSString*)nibName;

/**
 *  通过视图控制器名称进入某个控制器
 *
 *  @param vcName 视图控制器名称
 */
+ (void)showVC:(NSString *)vcName;

+(CGFloat)getTabBarHeight;


//设计师信息
+ (void)designerDetailWithDesignerId:(NSString*)designer_id;

//设计师list
+ (void)designerListWithDesignerListType:(DesignerListType)type;

//留资list
+(void)leaveWithProductId:(NSString *)product_id leaveType:(GetLeaveListType)leaveType;


@end
