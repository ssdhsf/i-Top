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
    [_submitButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitButton)];
    _submitButton.layer.cornerRadius = _submitButton.frame.size.height/2;
    _submitButton.layer.masksToBounds = YES;
}

-(void)initData{
    
    self.productTitleLabel.text = _product_h5.title;
}

- (IBAction)selectProduct:(UIButton *)sender {
   
    [UIManager productViewControllerWithType:GetProductListTypeSelect];
    [UIManager sharedUIManager].selectProductBolck = ^(H5List *h5){
        
        _product_h5 = h5;
        [self initData];
    };
}

- (IBAction)sunmit:(UIButton *)sender {
    
    NSInteger inputTitleCount = 0;
    
    if (![Global stringIsNullWithString:self.titleTF1.text]) {
        
        inputTitleCount ++;
    }
    if (![Global stringIsNullWithString:self.titleTF2.text]) {
        
        inputTitleCount ++;
    }
    if (![Global stringIsNullWithString:self.titleTF3.text]) {
        
        inputTitleCount ++;
    }
    
    if (inputTitleCount < 2) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"至少2个标题")];
        return;
    }
}

@end
