//
//  CustomerServiceViewController.m
//  itop
//
//  Created by huangli on 2018/3/3.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomerServiceViewController.h"

@interface CustomerServiceViewController ()

@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation CustomerServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    self.title = @"联系客服";
}

-(void)initView{
    
    [super initView];
    _submitButton.layer.masksToBounds = YES;
    [_submitButton.layer addSublayer:[UIColor setGradualChangingColor: _submitButton fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
    _submitButton.layer.cornerRadius = _submitButton.height/2;
    _contentTV.placeholder = @"请输入反馈内容，200字以内";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(UIButton *)sender {
    
    NSLog(@"123");
}

@end
