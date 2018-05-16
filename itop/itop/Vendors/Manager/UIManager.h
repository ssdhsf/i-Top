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

typedef NS_ENUM(NSInteger, EditType) { //
    EditTypeNoel = 0, //不可编辑
    EditTypeTextFied = 1,//文本编辑
    EditTypeTextView,//文本编辑
    EditTypeSelectImage,//选择图片
    EditTypeSelectItem, //选择项
    EditTypeSelectTime //选择时间
};

typedef NS_ENUM(NSInteger, ShearType) { //首页Tag类型
    ShearTypeProduct = 0, //不可编辑
    ShearTypeMyhome = 1,//文本编辑
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
typedef void (^CustomRequirementsBackOffBolck)(id product); //定制需求提交回掉
typedef void (^CustomRequirementsRequestDataBackOffBolck)(id product); //定制需求提交回掉
typedef void (^EditCaseBackOffBolck)(id product); //案例提交回掉
typedef void (^UploadProductBackOffBolck)(id product); //定制需求提交回掉
typedef void (^PayBackOffBolck)(id product); //支付回掉
//typedef void (^FocusDesginerBackOffBolck)(id product); //定制需求提交回掉

@class H5List;
@class EditCase;
@class ProductDetail;

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
@property (copy, nonatomic)CustomRequirementsRequestDataBackOffBolck customRequirementsRequestDataBackOffBolck;
@property (copy, nonatomic)EditCaseBackOffBolck editCaseBackOffBolck;
@property (copy, nonatomic)UploadProductBackOffBolck uploadProductBackOffBolck;
@property (copy, nonatomic)PayBackOffBolck payBackOffBolck;
//@property (copy, nonatomic)FocusDesginerBackOffBolck focusDesginerBackOffBolck;

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
+ (void)designerDetailWithDesignerId:(NSNumber*)designer_id;

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
+(void)pushTemplateDetailViewControllerWithTemplateId:(NSNumber *)template_ld productType:(H5ProductType)productType;

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
+(void)hotDetailsViewControllerWithArticleId:(NSNumber *)article_id articleType:(ItemDetailType)article_type;

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
 *  定制需求添加
 *  @param demandAddType  添加定制需求类型 新增／编辑／作品入口
 *  @param demandType     定制需求类型 定制／竞标
 *  @param demand_id      重新编辑的 定制ID
 *  @param desginer_id     作品入口 设计师id
 *  @param product_id      作品入口 作品ID
 */
+(void)customRequirementsReleaseViewControllerWithDemandAddType:(DemandAddType)demandAddType
                                                     demandType:(DemandType)demandType
                                                      demand_id:(NSNumber *)demand_id
                                                     desginerId:(NSNumber *)desginer_id
                                                      productId:(NSNumber *)product_id;
/**
 *  添加平台介入（纠纷）
 */
+(void)submitDisputesViewControllerWithCustomId:(NSNumber *)custom_id;

/**
 *  平台介入List（纠纷）
 */
+(void)disputesViewControllerWithCustomId:(NSNumber *)custom_id;

/**
 *  评论
 *  custom_id   需要评论id
 *  commentType 评论类型
 */
+(void)commentPopularizeViewControllerWithCustomId:(NSNumber *)custom_id
                                       commentType:(CommentType)commentType;

/**
 *  添加／编辑案例
 *  isEdite 是否编辑
 *  editCase 编辑的模型
 */
+(void)editCaseViewControllerIsEdit:(BOOL)isEdite editCase:(EditCase *)editCase;

/**
 *  上传作品
 *  demand_id  定制id
 *  user_id user_id
 */
+(void)uploadProductLinkViewControllerWithDemandId:(NSNumber *)demand_id
                                            userId:(NSNumber *)user_id;
/**  案例List
 *
 *  getCaseType  首页获取／我的案例
 */
+(void)getCaseViewControllerWithGetCaseType:(GetCaseType)getCaseType;

/**
 *  托管赏金
 *  demand_id  定制id
 */
+(void)hostingBountyViewControllerWithDemandId:(NSNumber *)demand_id;

/**
 *  作品支付
 *  productDetail  作品
 */
+(void)payProductViewControllerWithProductDetail:(ProductDetail *)productDetail;

/**
 *  确认支付
 *  demand_id  定制id
 *  money  价格
 *  payType 支付类型
 */
+(void)paymentVerificationCodeViewControllerWithDemandId:(NSNumber *)demand_id
                                                   money:(NSString *)money
                                                 payType:(PayType)payType;
/**
 *  绑定手机号码
 *  bindPhoneType  初次登陆绑定／修改
 *  oldPhoneCode  需要修改的手机号码验证码
 */
+(void)bindPhoneViewControllerWithBindPhoneType:(BindPhoneType )bindPhoneType oldPhoneCode:(NSString *)oldPhoneCode;

@end
