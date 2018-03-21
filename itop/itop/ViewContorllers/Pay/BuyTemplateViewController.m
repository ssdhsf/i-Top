//
//  BuyTemplateViewController.m
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BuyTemplateViewController.h"

@interface BuyTemplateViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *templateImage;
@property (weak, nonatomic) IBOutlet UILabel *templateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *templatePriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UILabel *buyPriceLabel;

@end

@implementation BuyTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    [super initView];
    [_payButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_payButton)];
    _payButton.layer.masksToBounds = YES;
    _payButton.layer.cornerRadius = _payButton.height/2;
}
- (IBAction)pay:(UIButton *)sender {
}

@end
