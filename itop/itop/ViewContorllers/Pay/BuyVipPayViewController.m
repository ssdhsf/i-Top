//
//  BuyVipPayViewController.m
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BuyVipPayViewController.h"

static NSString *const PINK_DIMAOND = @"6000";   // 粉钻
static NSString *const BLUE_DIMAOND = @"16000";   // 蓝钻
static NSString *const BLACK_DIMAOND = @"26000";   // 黑钻
@interface BuyVipPayViewController ()

@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UILabel  *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *chargeButton;
@property (strong, nonatomic)Userwallet *userwallet;

@property (strong, nonatomic)  NSString *money;

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

-(void)initData{
    
    [super initData];
    [[UserManager shareUserManager] getuserwallet];
    [UserManager shareUserManager].balanceSuccess = ^(NSDictionary  *obj) {
        
        _userwallet = [[Userwallet alloc]initWithDictionary:obj error:nil];
        _balanceLabel.text = [NSString stringWithFormat:@"(可用余额%@元)",_userwallet.price];
        
    };
}

- (IBAction)selectBuyVipType:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:
            _money = PINK_DIMAOND;
            break;
        case 2:
            _money = BLUE_DIMAOND;
            break;
        case 3:
            _money = BLACK_DIMAOND;
            break;
        default:
            break;
    }
    
    self.priceLabel.text = _money;
}

- (IBAction)pay:(UIButton *)sender {
    
    if ([self.priceLabel.text isEqualToString:@"0"]) {
        
        [self showToastWithMessage:@"请选择一个会员版本"];
    } else  {
        
        if ([self compareInputPrice]) {
            
             [UIManager paymentVerificationCodeViewControllerWithDemandId:nil money:_money payType:PAYTYPE_ENTERPRISE];
        } else {
            
             [self showToastWithMessage:@"余额不足，请充值"];
        }
    }
}

-(BOOL)compareInputPrice{
    
    NSString*balancePrice = [NSString stringWithFormat:@"%@",_userwallet.price];
    NSString *payPrice = [NSString stringWithFormat:@"%@", self.priceLabel.text];
    BOOL result = payPrice.floatValue <= balancePrice.floatValue ? YES:NO ;
    return result;
}

@end
