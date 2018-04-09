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
#import "PopularizeManagementViewController.h"

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
    [UIManager sharedUIManager].backOffBolck = ^ ( id obj){
        
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
    vc.hidesBottomBarWhenPushed = YES;
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
    vc.hidesBottomBarWhenPushed = YES;
    UINavigationController * nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    [nav pushViewController:vc animated:YES];
}

+(CGFloat)getTabBarHeight{
    // 获取tabBarHeight
    UITabBarController *tabBarController =[[UITabBarController alloc]init];
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
    //  vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc animated:YES];
}


#pragma mark 返回登陆页
- (void)LoginViewControllerWithLoginState:(BOOL)isLogin{
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    vc.isLogin = isLogin;
    if (isLogin) { //退出登录
    
        ThemeNavigationController* loginNavigation = [[ThemeNavigationController alloc] initWithRootViewController:vc];

        [[self class] appDelegate].window.rootViewController = loginNavigation;
        [[self class] appDelegate].tabBarController = nil;
    } else{
        
        [[self class] pushVC:vc];
    }
}

+ (void)designerDetailWithDesignerId:(NSString*)designer_id{
    
    DesignerInfoViewController *vc = [[DesignerInfoViewController alloc]init];
    vc.desginer_id = designer_id;
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
}

+ (void)designerListWithDesignerListType:(DesignerListType)type searchKey:(NSString *)searchKey{
    
    DesignerListViewController *vc = [[DesignerListViewController alloc]init];
    vc.designerListType = type;
    vc.searchKey = searchKey;
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
}

+ (void)signingStateWithShowViewType:(ShowSigningStateViewType)type signingState:(SigningState *)signingState signingType:(SigningType)signingType{
    
    SigningStateViewController *vc = [[SigningStateViewController alloc]init];
    vc.showView_type = type;
    vc.signingState = signingState;
    vc.signingType = signingType;
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
}


+(void)leaveWithProduct:(H5List *)product leaveType:(GetLeaveListType)leaveType{
    
    LeaveViewController *vc = [[LeaveViewController alloc]init];
    vc.currentProduct = product;
    vc.getLeaveListType = GetLeaveListTypeProduct;
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
}

+(void)shearProductWithProduct:(H5List *)product{
    
    SetupProductViewController *vc = [[SetupProductViewController alloc]init];
    vc.product = product;
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
}

+(void)protocolWithProtocolType:(ProtocolType)protocolType{
    
    ProtocolViewController *vc = [[ProtocolViewController alloc]init];
    vc.protocolType = protocolType;
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
}

+(void)pushTemplateDetailViewControllerWithTemplateId:(NSString *)template_ld{
    
    TemplateDetaulViewController *vc = [[TemplateDetaulViewController alloc] init];
    vc.template_id = template_ld;
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
//    [self.navigationController pushViewController:vc animated:YES];
}

+(void)customerServiceAndFeedbackWithTitle:(NSString *)type{
    
    CustomerServiceViewController *vc = [[CustomerServiceViewController alloc] init];
    vc.titel = type;
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
}

+(void)qrCodeViewControllerWithCode:(NSString *)link{
    
    QrCodeViewController *vc = [[QrCodeViewController alloc] init];
    vc.qrCode = link;
    vc.hidesBottomBarWhenPushed = YES;
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
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
}

+(void)hotDetailsViewControllerWithArticleId:(NSString *)article_id articleType:(ItemDetailType)article_type{
    
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
    vc.hidesBottomBarWhenPushed = YES;
    [UIManager showViewController:vc Animated:YES];
}

-(PopularizeManagementViewController *)popularizeManagementViewControllerWithHome:(BOOL)isHome{
    
    PopularizeManagementViewController *vc = [[PopularizeManagementViewController alloc]init];
    vc.isHome = isHome;
    if (isHome) {
        return vc;
    } else {
        vc.hidesBottomBarWhenPushed =  !isHome;
        [UIManager showViewController:vc Animated:YES];
    }
    
    return nil;
}

+ (UINavigationController *)getNavigationController{
    
    AppDelegate * appDelegate = [[self class] appDelegate];
    UINavigationController * nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    return nav;
}





@end
