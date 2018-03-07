//
//  ShearViewController.m
//  itop
//
//  Created by huangli on 2018/3/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ShearViewController.h"
#import "ShearViewManager.h"

@interface ShearViewController ()

@property(nonatomic,strong)WebViewController *webVc;

@end

@implementation ShearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [[ShearViewManager sharedShearViewManager]setupShearView];
    
}
-(void)initView{
    
    [super initView];

}

-(void)initNavigationBarItems{
    
    self.title = @"分享";
}

- (IBAction)shear:(UIButton *)sender {
    
    [[ShearViewManager sharedShearViewManager]addTimeViewToView:self.view ];
    
}

-(void)setupWebViewVc{
    
    _webVc = [[WebViewController alloc]init];
    _webVc.h5Url = @"http://voice.i-top.cn/www/h5/weiwang/04.christmas/index.html?ActivityCategory=1&id=126&medium_id=126&from=groupmessage";
    _webVc.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeigh);
    [self.view addSubview:_webVc.view];
}

@end
