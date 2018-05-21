//
//  PaymentVerificationCodeViewController.m
//  itop
//
//  Created by huangli on 2018/5/14.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "PaymentVerificationCodeViewController.h"
#import "CustomRequirementsStateListController.h"
#import "TemplateDetaulViewController.h"
#import "MycaseViewController.h"

static NSString *const UNKNOW = @"0";    //未知
static NSString *const ARTICLE = @"1";    //文章支付
static NSString *const PRODUCT = @"2"; //作品支付
static NSString *const RECHARGE = @"3"; //充值
static NSString *const ENTERPRISE = @"4"; //企业服务
static NSString *const ORDER = @"5"; //推广订单
static NSString *const DEMAND_SERVICE = @"6"; //开通定制服务
static NSString *const DEMAND = @"7"; //定制需求

@interface PaymentVerificationCodeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;

@end

@implementation PaymentVerificationCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    [super initView];
    [_codeButton.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_codeButton) atIndex:0];
    _codeButton.layer.masksToBounds = YES;
    _codeButton.layer.cornerRadius = _codeButton.height/2;
    
    [_payButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_payButton)];
    _payButton.layer.masksToBounds = YES;
    _payButton.layer.cornerRadius = _payButton.height/2;
    
    _verificationCodeTF.delegate = self;
}

-(void)initData{
    
    [super initData];
    
    [self sendVerificationCode];
}

-(NSString *)hiddenMobili{
    
    NSString *string = [[UserManager shareUserManager]crrentUserInfomation].phone;
    string = [string stringByReplacingOccurrencesOfString:[string substringWithRange:NSMakeRange(3,4)] withString:@"****"];
    return string;
}

- (IBAction)verificationCode:(UIButton *)sender {
    
    [self sendVerificationCode];
}

-(void)sendVerificationCode{
    
    if([_codeButton.titleLabel.text isEqualToString:@"获取验证码"]){
        [[UserManager shareUserManager]getVerificationCodeWithPhone:[[UserManager shareUserManager]crrentUserInfomation].phone ? [[UserManager shareUserManager]crrentUserInfomation].phone : @"" ];
        [UserManager shareUserManager].verificationSuccess = ^(id obj){
            
            _descriptionLabel.text = [NSString stringWithFormat:@"i-Top已经向您的%@的手机发送短信验证码，请输入验证码完成支付",[self hiddenMobili]];
            [_codeButton scheduledGCDTimer];
        };
        
    }else {
        
        [self showToastWithMessage:[NSString stringWithFormat:@"%ld后重发",[UserManager shareUserManager].timers]];
        return;
    }
}

- (IBAction)pay:(UIButton *)sender {
   
    [[UserManager shareUserManager]checkcodeWithCode:_verificationCodeTF.text];
    [UserManager shareUserManager].checkCodeSuccess = ^(id obj){
        
        NSString *payScenc = [self payScene];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:@"0" forKey:@"Pay_type"]; //支付类型  余额
        [parameters setObject:payScenc forKey:@"Pay_scene"]; //支付场景
        [parameters setObject:_money forKey:@"Price"]; //支付价格
        if (_demand_id != nil) {
             [parameters setObject:_demand_id forKey:@"Id"]; //产品 id   充值 ／企业服务免
        }
        [[UserManager shareUserManager]payWithParameters:parameters];
        [UserManager shareUserManager].paySuccess = ^(id obj){
            
            [self backOff];
            
        };
    };
}

-(NSString *)payScene{
    
    NSString *payScenc = [NSString string];
    switch (_payType ) {
        case PAYTYPE_UNKNOW:
            payScenc = UNKNOW;
            break;
        case PAYTYPE_ARTICLE:
            payScenc = ARTICLE;
            break;
        case PAYTYPE_PRODUCT:
            payScenc = PRODUCT;
            break;
        case PAYTYPE_ENTERPRISE:
            payScenc = ENTERPRISE;
            break;
        case PAYTYPE_ORDER:
            payScenc = ORDER;
            break;
        case PAYTYPE_DEMANDSERVICE:
            payScenc = DEMAND_SERVICE;
            break;
        case PAYTYPE_DEMAND:
            payScenc = DEMAND;
            break;
            
        default:
            break;
    }
    
    return payScenc;
}

-(void)backOff{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[CustomRequirementsStateListController class]] && _payType == PAYTYPE_DEMAND) {
            
            [self.navigationController popToViewController:vc animated:YES];
             [UIManager sharedUIManager].payBackOffBolck([NSNumber numberWithInteger:PAYTYPE_DEMAND]);
            
        }
        if ([vc isKindOfClass:[TemplateDetaulViewController class]] && _payType == PAYTYPE_PRODUCT) {
            
            [self.navigationController popToViewController:vc animated:YES];

        }
        if ([vc isKindOfClass:[MycaseViewController class]] && _payType == PAYTYPE_DEMANDSERVICE) {
            
            [self.navigationController popToViewController:vc animated:YES];
             [UIManager sharedUIManager].payBackOffBolck([NSNumber numberWithInteger:PAYTYPE_DEMANDSERVICE]);
            
        }
       
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
