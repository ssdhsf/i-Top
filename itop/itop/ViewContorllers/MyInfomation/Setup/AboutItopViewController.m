//
//  aboutItopViewController.m
//  itop
//
//  Created by huangli on 2018/3/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "AboutItopViewController.h"

@interface AboutItopViewController ()

@property (strong, nonatomic) NSArray *views;

@end

@implementation AboutItopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    
    [super initView];
    _views = [[NSBundle mainBundle] loadNibNamed:@"AboutItopViewController" owner:self options:nil];
    self.view = [_views firstObject];
}

-(void)initNavigationBarItems{
    
    self.title = @"关于i-Top";
}

@end
