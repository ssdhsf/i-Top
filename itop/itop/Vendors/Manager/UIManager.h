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
#import "SigningStateViewController.h"
#import "ProtocolViewController.h"


typedef void (^BackOffBolck)(id parameter);

@interface UIManager : NSObject

+ (instancetype)sharedUIManager;

@property (copy, nonatomic)BackOffBolck backOffBolck;

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

/**
 *  获取tabbar高度
 *
 */
+(CGFloat)getTabBarHeight;


//设计师信息
+ (void)designerDetailWithDesignerId:(NSString*)designer_id;

/**
 *  设计师列表
 *
 *  @param type 获取设计师list入口Type
 */
+ (void)designerListWithDesignerListType:(DesignerListType)type;

/**
 *  入驻状态
 *
 *  @param type 展示入驻状态类型
 */
+ (void)signingStateWithShowViewType:(ShowViewType)type;

/**
 *  入驻状态
 *
 *  @param leaveType //获取留资入口类型
 */
+(void)leaveWithProductId:(NSString *)product_id leaveType:(GetLeaveListType)leaveType;


/**
 *  入驻状态
 *
 *  @param product_id //分享作品的id
 */
+(void)shearProductWithProductId:(NSString *)product_id;

/**
 *  入驻状态
 *
 *  @param protocolType //协议类型类型
 */
+(void)protocolWithProtocolType:(ProtocolType)protocolType;

/**
 *  预览H5
 *
 *  @param template_ld H5  id
 */
+(void)pushTemplateDetailViewControllerWithTemplateId:(NSString *)template_ld;

/**
 *  联系客服／意见反馈公用
 *
 *  @param type //联系客服／意见反馈
 */
+(void)customerServiceAndFeedbackWithTitle:(NSString *)type;

/**
 *  生成二维码
 *
 *  @param link 链接
 */
+(void)qrCodeViewControllerWithCode:(NSString *)link;
/**
 *  获取当前导航栏
 *
 */
+ (UINavigationController *)getNavigationController;

@end
