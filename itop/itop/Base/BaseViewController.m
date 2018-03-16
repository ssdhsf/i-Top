//
//  BaseViewController.m
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    UIImage *img = [UIImage imageNamed:@"nav_bg"];
//    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.backgroundColor = XBlueColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:UIColorFromRGB(0x434a5c)}];
    [self setLeftCustomBarItem:@"icon_back" action:@selector(back)];
        [self hideNavigationBlackLine];
    [self addSwipeBack];
    [self initData];
    [self initView];
    [self initNavigationBarItems];
    
#ifdef iOS7_SDK
    if([[UIDevice currentDevice].systemVersion floatValue])
    {
        if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        {
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
            [self setExtendedLayoutIncludesOpaqueBars:NO];
            [self prefersStatusBarHidden];
            [self preferredStatusBarStyle];
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
#endif
    self.wantsFullScreenLayout = NO;
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 针对搜索列表点击进去后的情况
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    //友盟统计页面
    NSString *className= NSStringFromClass(self.class);
    [MobClick beginLogPageView:className];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //友盟统计页面
    NSString *className= NSStringFromClass(self.class);
    [MobClick endLogPageView:className];
     self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)registeredkeyBoardNSNotificationCenter{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark - 初始化数据,由子类重写改方法
- (void)initData {
}

#pragma mark - 初始化View,由子类重写改方法
- (void)initView {
}

#pragma mark - 初始化navigationBar,由子类重写改方法
- (void)initNavigationBarItems {
    
}

#pragma mark - 手势返回上级视图
- (void)addSwipeBack {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [self.view addGestureRecognizer:swipe];
}

#pragma mark - 隐藏导航栏下的黑线
- (void)hideNavigationBlackLine {
        
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
//                NSLog(@"%f",imageView.frame.size.height);
//                imageView.hidden = YES;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}

- (void)hiddenNavigafindHairlineImageView:(BOOL)animated{
    
    UIImageView *navigationImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navigationImageView.hidden = animated;

}

-(UIImageView *)findHairlineImageViewUnder:(UIView *)view {

    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark 键盘弹出
- (void)keyBoardDidShow:(NSNotification *)notification{
    
    //获取通知对象
}

#pragma mark 键盘将要收起
- (void)keyBoardWillHide:(NSNotification *)notification{
    
}

#pragma mark 键盘已经收起
- (void)keyBoardDidHide:(NSNotification *)notification{
    
}

#pragma mark - 返回
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)hiddenNavigationController:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:animated];
    //    [self.navigationController.tabBarController.tabBar setHidden:animated];
}


@end
