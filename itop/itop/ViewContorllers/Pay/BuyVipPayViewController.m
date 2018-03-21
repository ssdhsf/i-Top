//
//  BuyVipPayViewController.m
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BuyVipPayViewController.h"

@interface BuyVipPayViewController ()

@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation BuyVipPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initView{
    
    [super initView];
    [_payButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_payButton)];
    _payButton.layer.masksToBounds = YES;
    _payButton.layer.cornerRadius = _payButton.height/2;
}

- (IBAction)selectBuyVipType:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:
            self.priceLabel.text = @"6000元";
            break;
        case 2:
            self.priceLabel.text = @"16000元";
            break;
        case 3:
            self.priceLabel.text = @"26000元";
            break;
        default:
            break;
    }
}

- (IBAction)pay:(UIButton *)sender {
    
    
}

@end
