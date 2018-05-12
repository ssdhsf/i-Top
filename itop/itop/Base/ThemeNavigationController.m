//
//  ThemeNavigationController.m
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ThemeNavigationController.h"
#import "ThemeManager.h"

@interface ThemeNavigationController ()

@end

@implementation ThemeNavigationController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //监听主题切换的通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self loadThemeImage];
    self.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationBar.tintColor = UIColorFromRGB(0x434a5c);
}

- (void)loadThemeImage{
    
    [self.navigationBar setBackgroundImage:[[ThemeManager shareInstance]getThemeImage:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:[[ThemeManager shareInstance]getThemeImage:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController isKindOfClass:[UIImagePickerController class]]) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

-(void)setTitle:(NSString *)title tabBarItemImageName:(NSString *)imageName tabBarItemSelectedImageName:(NSString *)selectedImageName{
    
    self.tabBarItem.title = title ;
    self.tabBarItem.image=[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], UITextAttributeFont, nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], UITextAttributeFont, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0xf9a5ee), UITextAttributeTextColor, nil] forState:UIControlStateSelected];
}

@end
