//
//  OptimizeTitleViewController.m
//  itop
//
//  Created by huangli on 2018/3/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "OptimizeTitleViewController.h"

@interface OptimizeTitleViewController ()
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTF1;
@property (weak, nonatomic) IBOutlet UITextField *titleTF2;
@property (weak, nonatomic) IBOutlet UITextField *titleTF3;

@end

@implementation OptimizeTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems {
    
    self.title = @"标题优化";
}

-(void)initView{
    
    [super initView];
    [_submitButton.layer addSublayer:[UIColor setGradualChangingColor:_submitButton fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
    _submitButton.layer.cornerRadius = _submitButton.frame.size.height/2;
    _submitButton.layer.masksToBounds = YES;
}

- (IBAction)selectProduct:(UIButton *)sender {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sunmit:(UIButton *)sender {
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
