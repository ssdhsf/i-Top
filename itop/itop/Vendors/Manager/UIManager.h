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
#import "HotDetailsViewController.h"
#import "PopularizeManagementViewController.h"

typedef NS_ENUM(NSInteger, StatisticalItmeType) { //加载数据统计Itme类型
    StatisticalItmeTypeH5 = 0, //H5
    StatisticalItmeTypeHot = 1, //热点
    StatisticalItmeTypeFuns , //粉丝
    StatisticalItmeTypePop , //推广管理
};

typedef NS_ENUM(NSInteger, EditType) { //首页Tag类型
    EditTypeNoel = 0, //不可编辑
    EditTypeTextFied = 1,//文本编辑
    EditTypeTextView,//文本编辑
    EditTypeSelectImage,//选择图片
    EditTypeSelectItem, //选择项
    EditTypeSelectTime //选择时间
};

typedef void (^BackOffBolck)(id parameter); //返回上一级回掉
typedef void (^CommentPopularizeBackOffBolck)(id parameter); //返回上一级回掉
typedef void (^UpdateHotBackOffBolck)(id parameter); //返回上一级回掉
typedef void (^RealesHotBackOffBolck)(id parameter); //发布热点返回上一级回掉
typedef void (^LoadingBackOffBolck)(id parameter); //加载完启动GIF返回上一级回掉
typedef void (^SubmitInfomationBackOffBolck)(id parameter); //提交用户信息返回上一级回掉
typedef void (^LoginOutBackOffBolck)(id parameter); //退出登录返回上一级回掉
typedef void (^SelectProductBolck)(id product); //选择作品回掉
typedef void (^SelectProvinceBackOffBolck)(id product); //选择城市回掉
typedef void (^SetupProductBackOffBolck)(id product); //选择城市回掉

typedef void (^CustomRequirementsBackOffBolck)(id product); //定制需求提交返回

@class H5List;

@interface UIManager : NSObject

+ (instancetype)sharedUIManager;

@property (copy, nonatomic)BackOffBolck backOffBolck;//
@property (copy, nonatomic)RealesHotBackOffBolck realesHotBackOffBolck;//
@property (copy, nonatomic)UpdateHotBackOffBolck updateHotBackOffBolck;//
@property (copy, nonatomic)LoadingBackOffBolck loadingBackOffBolck;//
@property (copy, nonatomic)SubmitInfomationBackOffBolck submitInfomationBackOffBolck;//
@property (copy, nonatomic)LoginOutBackOffBolck loginOutBackOffBolck;//
@property (copy, nonatomic)SelectProvinceBackOffBolck selectProvinceBackOffBolck;
@property (copy, nonatomic)SelectProductBolck selectProductBolck;
@property (copy, nonatomic)CommentPopularizeBackOffBolck commentPopularizeBackOffBolck;
@property (copy, nonatomic)SetupProductBackOffBolck setupProductBackOffBolck;
@property (copy, nonatomic)CustomRequirementsBackOffBolck customRequirementsBackOffBolck;

+ (AppDelegate *)appDelegate;
+ (UIWindow *)keyWindow;
+ (UIWindow *)newWindow;

/**
 *  加载启动页
 */
+(void)loadinglaunchImageView;


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

/**
 *  @param vcName 构建视图控制器的名称
 *  @retrun  视图控制器
 */
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
 *  通过视图控制器名称进入某个控制器
 *
 *  @param vc 视图控制器
 */
+ (void)pushVC:(UIViewController *)vc;

/**
 *  获取tabbar高度
 *  retuen tabbar高度
 */
+(CGFloat)getTabBarHeight;

/**
 *  登陆页
 *
 *  @param isLogin  是否已经登录
 */
- (void)LoginViewControllerWithLoginState:(BOOL)isLogin;

/**
*   设计师信息
*
*  @param designer_id 设计师id
*/
+ (void)designerDetailWithDesignerId:(NSString*)designer_id;

/**
 *  设计师列表
 *
 *  @param type 获取设计师list入口Type
 */
+ (void)designerListWithDesignerListType:(DesignerListType)type searchKey:(NSString *)searchKey;

/**
 *  入驻状态
 *
 *  @param type 展示入驻状态类型
 *  @param signingState 审核状态
 *  @param signingType 申请用户类型
 */
+ (void)signingStateWithShowViewType:(ShowSigningStateViewType)type signingState:(SigningState *)signingState signingType:(SigningType)signingType;

/**
 *  留资
 *
 *  @param product //获取留资的作品
 *  @param leaveType //获取留资入口类型
 */
+(void)leaveWithProduct:(H5List *)product leaveType:(GetLeaveListType)leaveType;


/**
 *  分享作品设置
 *
 *  @param product //分享的作品
 */
+(void)shearProductWithProduct:(H5List *)product;

/**
 *  协议预览
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

/**
 *  @param showProductType 获取作品入口
 *
 */
+(void)productViewControllerWithType:(GetProductListType )showProductType;

/**
 *  @param  product 优化作品标题
 *
 */
+(void)optimizeTitleViewControllerWithProduct:(H5List *)product;

/**
 *  文章详情
 *  @param article_id  文章id
 *  @param article_type  文章类型
 */
+(void)hotDetailsViewControllerWithArticleId:(NSString *)article_id articleType:(ItemDetailType)article_type;

/**
 *  搜索热点列表
 *  @param getArticleListType  文章id
 *  @param searchKey  搜索关键词
 */
+(void)recommendedViewControllerWithGetArticleListType:(GetArticleListType )getArticleListType searchKey:(NSString *)searchKey;

/**
 *  推广管理
 *  @param isHome  是否是首页推广
 */
-(PopularizeManagementViewController *)popularizeManagementViewControllerWithHome:(BOOL)isHome;

/**
 *  定制需求列表
 */
+(void)customRequirementsViewController;

/**
 *  定制需求详情
 */
+(void)customRequirementsDetailViewControllerWithCustomId:(NSNumber *)custom_id;

/**
 *  定制需求列表
 */
+(void)customRequirementsReleaseViewControllerWithIsEdit:(BOOL)isEdit
                                              demandType:(DemandType)demandType
                                               demand_id:(NSNumber *)demand_id;

@end
