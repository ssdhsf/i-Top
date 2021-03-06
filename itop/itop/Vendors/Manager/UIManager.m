//
//  UIManager.m
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "UIManager.h"
#import "ThemeNavigationController.h"
#import "MyTabBarController.h"
#import "LoginViewController.h"
#import "DesignerInfoViewController.h"
#import "DesignerListViewController.h"
#import "LeaveViewController.h"
#import "SigningStateViewController.h"
#import "TemplateDetaulViewController.h"
#import "CustomerServiceViewController.h"
#import "SetupProductViewController.h"
#import "QrCodeViewController.h"
#import "MyWorksViewCotroller.h"
#import "OptimizeTitleViewController.h"
#import "LoadingViewController.h"
#import "RecommendedViewController.h"
#import "CustomRequirementsViewController.h"
#import "PopularizeItmeTableViewController.h"
#import "CustomRequirementsDetailViewController.h"
#import "DirectionalDemandReleaseViewController.h"
#import "SubmitDisputesViewController.h"
#import "DisputesViewController.h"
#import "CommentPopularizeViewController.h"
#import "EditCaseViewController.h"
#import "UploadProductLinkViewController.h"
#import "MycaseViewController.h"
#import "HostingBountyViewController.h"
#import "PaymentVerificationCodeViewController.h"
#import "BuyTemplateViewController.h"
#import "BindPhoneViewController.h"

@implementation UIManager

+ (instancetype)sharedUIManager{
    
    static UIManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc] init];
    });
    return manager;
}

+ (AppDelegate *)appDelegate{
    
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (UIWindow *)keyWindow{
    
    return [[UIApplication sharedApplication] keyWindow];
}

+ (UIWindow *)newWindow{
    
    UIWindow * window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor whiteColor];
    return window;
}

+(void)loadinglaunchImageView{
    
    [[self class] customNavAppearance];
    AppDelegate * appDelegate = [[self class] appDelegate];
    appDelegate.window = [[self class] newWindow];
    [appDelegate.window makeKeyAndVisible];
    LoadingViewController *loadingVc = [[LoadingViewController alloc]init];
    appDelegate.window.rootViewController = loadingVc;
    [UIManager sharedUIManager].loadingBackOffBolck = ^ ( id obj){
        
        UIViewController *vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [appDelegate.window addSubview:vc.view];
        [[self class]makeKeyAndVisible];
    };
}

+ (void)makeKeyAndVisible{
    
    [[self class] customNavAppearance];
    AppDelegate * appDelegate = [[self class] appDelegate];
    appDelegate.window = [[self class] newWindow];
    
    //    if([[UserManager shareUserManager] isLogin] || [[UserManager shareUserManager]isWechatLogin]) {
    MyTabBarController*tabBarController=[[MyTabBarController alloc]init];
    ThemeNavigationController *nav1 = [[ThemeNavigationController alloc]initWithRootViewController:[[self class] viewControllerWithName:@"HomeViewController"]];
    ThemeNavigationController *nav2 = [[ThemeNavigationController alloc]initWithRootViewController:[[self class] viewControllerWithName:@"HotViewController"]];
    
    UIViewController *vc ;
    if ([[UserManager shareUserManager] isLogin] && [[UserManager shareUserManager] crrentUserType] == 3 ) {
        vc = [[UIManager sharedUIManager]  popularizeManagementViewControllerWithHome:YES];
    } else {
        
        vc = [[UIManager sharedUIManager] homeProductViewControllerWithType:GetProductListTypeHome];
    }
    ThemeNavigationController *nav3 = [[ThemeNavigationController alloc]initWithRootViewController: vc];

    ThemeNavigationController *nav4 = [[ThemeNavigationController alloc]initWithRootViewController:[[self class] viewControllerWithName:@"MyInfomationViewController"]];
    
    [nav1 setTitle:@"首页" tabBarItemImageName:@"home_icon_home" tabBarItemSelectedImageName:@"icon_home_selected"];
    [nav2 setTitle:@"热点" tabBarItemImageName:@"home_icon_hot" tabBarItemSelectedImageName:@"home_icon_hot_selected"];
    
    if ([[UserManager shareUserManager] isLogin] && [[UserManager shareUserManager] crrentUserType] == 3 ) {
        [nav3 setTitle:@"我的推广" tabBarItemImageName:@"home_icon_product" tabBarItemSelectedImageName:@"home_icon_product_selested"];
    } else {
        [nav3 setTitle:@"我的作品" tabBarItemImageName:@"home_icon_product" tabBarItemSelectedImageName:@"home_icon_product_selested"];
    }
    [nav4 setTitle:@"我的" tabBarItemImageName:@"home_icon_me" tabBarItemSelectedImageName:@"home_icon_me_selected"];
    NSArray*array=@[nav1,nav2,nav3,nav4];
    tabBarController.viewControllers= array;
    
    appDelegate.tabBarController = tabBarController;
    [appDelegate.window makeKeyAndVisible];
    appDelegate.window.rootViewController = appDelegate.tabBarController;
    
//    } else {
//
//        ThemeNavigationController* loginNavigation = [[ThemeNavigationController alloc] initWithRootViewController:[[self class] viewControllerWithName:@"LoginViewController"]];
//        appDelegate.window.rootViewController = loginNavigation;
//        [appDelegate.window makeKeyAndVisible];
//    }
}

+ (void)customNavAppearance{
    
    [[self class] setNavigationTitleWhiteColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

+ (void)setNavigationTitleWhiteColor{
    
    [[self class] setNavigationTitleColor:[UIColor whiteColor]];
}

+ (void)setNavigationTitleColor:(UIColor *)clr{
    
    if(clr == nil){
        
        clr = [UIColor blackColor];
    }
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:clr}];
}

+ (UIViewController *)viewControllerWithName:(NSString *)vcName{
    
    Class cls = NSClassFromString(vcName);
    UIViewController * vc = [[cls alloc] initWithNibName:vcName bundle:[NSBundle mainBundle]];
    return vc;
}

+ (void)goMianViewController{
    
    AppDelegate * appDelegate = [[self class] appDelegate];
    if(appDelegate.tabBarController == nil ){
        
        [UIManager makeKeyAndVisible];
    }
    appDelegate.window.rootViewController = appDelegate.tabBarController;
    appDelegate.tabBarController.selectedIndex = 0;
}

+ (void)rootVCTabBarControllerShowVC:(NSString *)vcName{
    AppDelegate * appDelegate = [[self class] appDelegate];
    UIViewController * vc = [[self class] viewControllerWithName:vcName];
    vc.hidesBottomBarWhenPushed =  kDevice_Is_iPhoneX ? NO : YES;
    UINavigationController * nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    [nav pushViewController:vc animated:YES];
    vc = nil;
}

+ (void)rootVCNavigationControllerShowVC:(NSString *)vcName pushVC:(UIViewController*)pushVC animated:(BOOL)animated{

    UIViewController * vc = [[self class] viewControllerWithName:vcName];
//    vc.hidesBottomBarWhenPushed = YES;
    [vc.navigationController pushViewController:vc animated:animated];
}

+ (ThemeNavigationController *)themeNavigationController:(UIViewController *)vc {
    ThemeNavigationController * nav = [[ThemeNavigationController alloc] initWithRootViewController:vc];
    return nav;
}

- (UIViewController*)topViewController {
    
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* nav = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

- (UINib *)nibWithNibName:(NSString*)nibName{
    
    return [UINib nibWithNibName:nibName bundle:nil];
}

+ (void)showVC:(NSString *)vcName{
    AppDelegate * appDelegate = [[self class] appDelegate];
    UIViewController * vc = [[self class] viewControllerWithName:vcName];
    vc.hidesBottomBarWhenPushed = YES;
    UINavigationController * nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    [nav pushViewController:vc animated:YES];
    vc = nil;
}

+ (void)pushVC:(UIViewController *)vc{
  
    AppDelegate * appDelegate = [[self class] appDelegate];
    vc.hidesBottomBarWhenPushed =  YES;
    UINavigationController * nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    [nav pushViewController:vc animated:YES];
}

+(CGFloat)getTabBarHeight{
    // 获取tabBarHeight
    UITabBarController *tabBarController =[[UITabBarController alloc]init];
    
    NSLog(@"%f",CGRectGetHeight(tabBarController.tabBar.bounds));
    return CGRectGetHeight(tabBarController.tabBar.bounds);
}
//-(void)hiddenNavigationController:(BOOL)animated{
//    
//    [self.navigationController.navigationBar setHidden:animated];
//    //    [self.navigationController.tabBarController.tabBar setHidden:animated];
//}

+ (void)showViewController:(UIViewController *)vc Animated:(BOOL)animated{
    AppDelegate * appDelegate = [[self class] appDelegate];
    UINavigationController * nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc animated:YES];
}

#pragma mark 返回登陆页
- (void)LoginViewControllerWithLoginState:(BOOL)isLogin{
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    vc.isLogin = isLogin;
//    vc.hidesBottomBarWhenPushed = YES;
    if (isLogin) { //退出登录
    
        ThemeNavigationController* loginNavigation = [[ThemeNavigationController alloc] initWithRootViewController:vc];

        [[self class] appDelegate].window.rootViewController = loginNavigation;
        [[self class] appDelegate].tabBarController = nil;
    } else{
        
        [[self class] pushVC:vc];
    }
}

+ (void)designerDetailWithDesignerId:(NSNumber*)designer_id{
    
    DesignerInfoViewController *vc = [[DesignerInfoViewController alloc]init];
    vc.desginer_id = designer_id;
    vc.hidesBottomBarWhenPushed =  YES;
    [UIManager showViewController:vc Animated:YES];
}

+ (void)designerListWithDesignerListType:(DesignerListType)type searchKey:(NSString *)searchKey{
    
    DesignerListViewController *vc = [[DesignerListViewController alloc]init];
    vc.designerListType = type;
    vc.searchKey = searchKey;
    vc.hidesBottomBarWhenPushed =  YES;
    [UIManager showViewController:vc Animated:YES];
}

+ (void)signingStateWithShowViewType:(ShowSigningStateViewType)type signingState:(SigningState *)signingState signingType:(SigningType)signingType{
    
    SigningStateViewController *vc = [[SigningStateViewController alloc]init];
    vc.showView_type = type;
    vc.signingState = signingState;
    vc.signingType = signingType;
    vc.hidesBottomBarWhenPushed =  YES;
    [UIManager showViewController:vc Animated:YES];
}


+(void)leaveWithProduct:(H5List *)product leaveType:(GetLeaveListType)leaveType{
    
    LeaveViewController *vc = [[LeaveViewController alloc]init];
    vc.currentProduct = product;
    vc.getLeaveListType = leaveType;
    vc.hidesBottomBarWhenPushed =  YES;
    [UIManager showViewController:vc Animated:YES];
}

+(void)shearProductWithProduct:(H5List *)product{
    
    SetupProductViewController *vc = [[SetupProductViewController alloc]init];
    vc.product = product;
    vc.hidesBottomBarWhenPushed =  YES;
    [UIManager showViewController:vc Animated:YES];
}

+(void)protocolWithProtocolType:(ProtocolType)protocolType{
    
    ProtocolViewController *vc = [[ProtocolViewController alloc]init];
    vc.protocolType = protocolType;
    vc.hidesBottomBarWhenPushed =  YES;
    [UIManager showViewController:vc Animated:YES];
}

+(void)pushTemplateDetailViewControllerWithTemplateId:(NSNumber *)template_ld productType:(H5ProductType)productType{
    
    TemplateDetaulViewController *vc = [[TemplateDetaulViewController alloc] init];
    vc.template_id = template_ld;
    vc.productType = productType;
    vc.hidesBottomBarWhenPushed =  YES;
    [UIManager showViewController:vc Animated:YES];
//    [self.navigationController pushViewController:vc animated:YES];
}

+(void)customerServiceAndFeedbackWithTitle:(NSString *)type{
    
    CustomerServiceViewController *vc = [[CustomerServiceViewController alloc] init];
    vc.titel = type;
    vc.hidesBottomBarWhenPushed =  YES;
    [UIManager showViewController:vc Animated:YES];
}

+(void)qrCodeViewControllerWithCode:(NSString *)link{
    
    QrCodeViewController *vc = [[QrCodeViewController alloc] init];
    vc.qrCode = link;
    vc.hidesBottomBarWhenPushed =  kDevice_Is_iPhoneX ? NO : YES;
    [UIManager showViewController:vc Animated:YES];
}


+(void)productViewControllerWithType:(GetProductListType )showProductType{
    
    MyWorksViewCotroller *vc = [[UIManager sharedUIManager] homeProductViewControllerWithType:showProductType];
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
}

-(MyWorksViewCotroller *)homeProductViewControllerWithType:(GetProductListType )showProductType{
    
    MyWorksViewCotroller *vc = [[MyWorksViewCotroller alloc] init];
    vc.showProductType = showProductType;
    return vc;
}

+(void)optimizeTitleViewControllerWithProduct:(H5List *)product{
    
    OptimizeTitleViewController *vc = [[OptimizeTitleViewController alloc]init];
    vc.product_h5 = product;
    vc.hidesBottomBarWhenPushed =  YES;
    [UIManager showViewController:vc Animated:YES];
}

+(void)hotDetailsViewControllerWithArticleId:(NSNumber *)article_id articleType:(ItemDetailType)article_type{
    
    HotDetailsViewController *vc = [[HotDetailsViewController alloc]init];
    vc.itemDetailType = article_type;
    vc.hotDetail_id = article_id;
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
}

+(void)recommendedViewControllerWithGetArticleListType:(GetArticleListType )getArticleListType searchKey:(NSString *)searchKey{
    
    RecommendedViewController *vc = [[RecommendedViewController alloc]init];
    vc.getArticleListType = getArticleListType;
    vc.searchKey = searchKey;
    vc.hidesBottomBarWhenPushed =  YES;
    [UIManager showViewController:vc Animated:YES];
}

-(PopularizeItmeTableViewController *)popularizeManagementViewControllerWithHome:(BOOL)isHome{
    
    PopularizeItmeTableViewController *vc = [[PopularizeItmeTableViewController alloc]init];
    vc.isHome = isHome;
    if (isHome) {
        return vc;
    } else {
        vc.hidesBottomBarWhenPushed =  YES;
        [UIManager showViewController:vc Animated:YES];
    }
    
    return nil;
}

+(void)customRequirementsViewController{
    
    CustomRequirementsViewController *vc = [[CustomRequirementsViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
}

+(void)customRequirementsDetailViewControllerWithCustomId:(NSNumber *)custom_id{
    
    CustomRequirementsDetailViewController *vc = [[CustomRequirementsDetailViewController alloc]init];
    vc.custom_id = custom_id;
    [UIManager pushVC:vc];
}

+ (UINavigationController *)getNavigationController{
    
    AppDelegate * appDelegate = [[self class] appDelegate];
    UINavigationController * nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    return nav;
}

+(void)customRequirementsReleaseViewControllerWithDemandAddType:(DemandAddType)demandAddType
                                                     demandType:(DemandType)demandType
                                                      demand_id:(NSNumber *)demand_id
                                                     desginerId:(NSNumber *)desginer_id
                                                      productId:(NSNumber *)product_id{
    
    DirectionalDemandReleaseViewController *biddingVc = [[DirectionalDemandReleaseViewController alloc]init];
    biddingVc.demandAddType = demandAddType ;
    biddingVc.demandType = demandType;
    if (demandAddType == DemandAddTypeOnEdit) {
        
        biddingVc.demand_id = demand_id ;
    }
    
    if (demandAddType == DemandAddTypeOnProduct) {
        
        biddingVc.desginer_id = desginer_id ;
        biddingVc.desginer_product_id = product_id ;
    }
    [UIManager pushVC:biddingVc];
}

+(void)submitDisputesViewControllerWithCustomId:(NSNumber *)custom_id
                                        {
    
    SubmitDisputesViewController *submitDisputesVc = [[SubmitDisputesViewController alloc]init];
    submitDisputesVc.demant_id = custom_id;
    [UIManager pushVC:submitDisputesVc];
}

+(void)disputesViewControllerWithCustomId:(NSNumber *)custom_id
                                  message:(NSString *)message{
    
    DisputesViewController *disputes = [[DisputesViewController alloc]init];
    disputes.demant_id = custom_id;
    disputes.message = message;
    [UIManager pushVC:disputes];
}

+(void)commentPopularizeViewControllerWithCustomId:(NSNumber *)custom_id
                                       commentType:(CommentType)commentType{
    
    CommentPopularizeViewController *vc = [[CommentPopularizeViewController alloc]init];
    if (commentType == CommentTypePopularize) {
        vc.popularize_id = custom_id;
    } else {
        vc.demand_id = custom_id;
    }
    vc.commentType = commentType;
    [UIManager pushVC:vc];
}

+(void)editCaseViewControllerIsEdit:(BOOL)isEdite editCase:(EditCase *)editCase{
    
    EditCaseViewController *vc = [[EditCaseViewController alloc]init];
    vc.isEdit = isEdite;
    vc.editCase = editCase;
    [UIManager pushVC:vc];
}

+(void)uploadProductLinkViewControllerWithDemandId:(NSNumber *)demand_id
                                            userId:(NSNumber *)user_id{
    
    UploadProductLinkViewController *vc = [[UploadProductLinkViewController alloc]init];
    vc.demand_id = demand_id;
    vc.user_id = user_id;
    [UIManager pushVC:vc];
}

+(void)getCaseViewControllerWithGetCaseType:(GetCaseType)getCaseType{
    
    
    MycaseViewController *vc = [[MycaseViewController alloc]init];
    vc.getCaseType = getCaseType;
    [UIManager pushVC:vc];
}

+(void)hostingBountyViewControllerWithDemandId:(NSNumber *)demand_id{
    
    HostingBountyViewController *vc = [[HostingBountyViewController alloc]init];
    vc.demand_id = demand_id;
    [UIManager pushVC:vc];
}

+(void)paymentVerificationCodeViewControllerWithDemandId:(NSNumber *)demand_id
                                                   money:(NSString *)money
                                                 payType:(PayType)payType{
    
    PaymentVerificationCodeViewController *vc = [[PaymentVerificationCodeViewController alloc]init];
    vc.demand_id = demand_id;
    vc.money = money;
    vc.payType = payType;
    [UIManager pushVC:vc];
}

+(void)payProductViewControllerWithProductDetail:(ProductDetail *)productDetail{
    
    BuyTemplateViewController *vc = [[BuyTemplateViewController alloc]init];
    vc.productDetail = productDetail ;
    [UIManager pushVC:vc];
}

+(void)bindPhoneViewControllerWithBindPhoneType:(BindPhoneType )bindPhoneType oldPhoneCode:(NSString *)oldPhoneCode{
    
    BindPhoneViewController *vc = [[BindPhoneViewController alloc]init];
    vc.bindPhoneType = bindPhoneType ;
    vc.oldPhoneCode = oldPhoneCode;
    [UIManager pushVC:vc];
}



@end
