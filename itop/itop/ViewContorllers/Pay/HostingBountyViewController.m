//
//  HostingBountyViewController.m
//  itop
//
//  Created by huangli on 2018/5/12.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HostingBountyViewController.h"

@interface HostingBountyViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmPayButton;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic)  NSString *money;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *chargeButton;
@property (strong, nonatomic)Userwallet *userwallet;

@end

@implementation HostingBountyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initData{
    
    [super initData];
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
    
    _moneyTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _moneyTF.delegate = self;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.money = textField.text;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",textField.text];
}

- (IBAction)confirmPay:(UIButton *)sender {
    
    if([Global stringIsNullWithString:_moneyTF.text]){
       
        [self showToastWithMessage:@"请输入金额"];
        return;
    }
    
    if ([self compareInputPrice]) {
        
       [UIManager paymentVerificationCodeViewControllerWithDemandId:_demand_id money:_money payType:PAYTYPE_DEMAND];
    } else {

        [self showToastWithMessage:@"余额不足，请充值"];
    }
}

- (IBAction)charge:(UIButton *)sender {
    
    
}

-(BOOL)compareInputPrice{
    
     NSString*balancePrice = [NSString stringWithFormat:@"%@",_userwallet.price];
     NSString *payPrice = [NSString stringWithFormat:@"%@",_moneyTF.text];
     BOOL result = payPrice.floatValue <= balancePrice.floatValue ? YES:NO ;
     return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
