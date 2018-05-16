//
//  OpenDemandServiceViewController.m
//  itop
//
//  Created by huangli on 2018/5/16.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "OpenDemandServiceViewController.h"

static NSString *const OpenDemandServicePrice = @"2000";

@interface OpenDemandServiceViewController ()
    //开通定制价格

@property (weak, nonatomic) IBOutlet UIButton *confirmPayButton;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (strong, nonatomic)  NSString *money;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *chargeButton;
@property (strong, nonatomic)Userwallet *userwallet;

@end

@implementation OpenDemandServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initData{
    
    [super initData];
    _money = OpenDemandServicePrice;
    [[UserManager shareUserManager] getuserwallet];
    [UserManager shareUserManager].balanceSuccess = ^(NSDictionary  *obj) {
        
        _userwallet = [[Userwallet alloc]initWithDictionary:obj error:nil];
        _balanceLabel.text = [NSString stringWithFormat:@"(可用余额%@元)",_userwallet.price];

    };
}

-(void)initView{
    
    [super initView];
    [_confirmPayButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_confirmPayButton)];
    _confirmPayButton.layer.masksToBounds = YES;
    _confirmPayButton.layer.cornerRadius = _confirmPayButton.height/2;
}

- (IBAction)confirmPay:(UIButton *)sender {
    
//    if ([self compareInputPrice]) {
    
        [UIManager paymentVerificationCodeViewControllerWithDemandId:nil money:_money payType:PAYTYPE_DEMANDSERVICE];
//    } else {
//
//        [self showToastWithMessage:@"余额不足，请充值"];
//    }
}

- (IBAction)charge:(UIButton *)sender {
    
    
}

-(BOOL)compareInputPrice{
    
    NSString*balancePrice = [NSString stringWithFormat:@"%@",_userwallet.price];
    NSString *payPrice = _money;
    BOOL result = payPrice.floatValue <= balancePrice.floatValue ? YES:NO ;
    return result;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
