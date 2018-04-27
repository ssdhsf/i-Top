//
//  MyTabBarControllerViewController.m
//  xixun
//
//  Created by huangli on 2017/10/12.
//  Copyright © 2017年 Vanber. All rights reserved.
//

#import "MyTabBarController.h"
#import "MyTabBar.h"
//#import "ApplicationStore.h"
//#import "MCSigninController.h"
@interface MyTabBarController ()<MyTabBarDelegate>

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyTabBar *myTabBar = [[MyTabBar alloc] init];
    myTabBar.myTabBarDelegate = self;
    [self setValue:myTabBar forKey:@"tabBar"];
    self.tabBar.backgroundColor = [UIColor whiteColor];
//    [self.tabBar setSelectedImageTintColor:[UIColor clearColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    //设置TabBar的TintColor
    self.tabBar.tintColor =  XBlueColor;
}

@end
