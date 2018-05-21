//
//  ChangePhoneViewController.m
//  itop
//
//  Created by huangli on 2018/5/15.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ChangePhoneViewController.h"
#import "BindPhoneViewController.h"

@interface ChangePhoneViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;
@property (weak, nonatomic) IBOutlet UIImageView *accountImage;
@property (weak, nonatomic) IBOutlet UIImageView *verificationCodeImage;

@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    [super initView];
    [_verificationCodeButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_verificationCodeButton)];
    _verificationCodeButton.layer.cornerRadius = _verificationCodeButton.frame.size.height/2;
    _verificationCodeButton.layer.masksToBounds = YES;
    
    [_nextButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_nextButton)];
    _nextButton.layer.cornerRadius = _nextButton.frame.size.height/2;
    _nextButton.layer.masksToBounds = YES;
}

-(void)initData{
    
    [super initData];
    _accountTF.tag = 1;
    _verificationCodeTF.tag = 2;
    
    _accountTF.enabled = NO;
    _accountTF.text = _oldPhone;
}

-(void)initNavigationBarItems{
    
    self.title = @"修改绑定手机号码";
}

- (IBAction)verificationCode:(UIButton *)sender {
    
    [_verificationCodeTF  resignFirstResponder];
    [_accountTF  resignFirstResponder];
    if([Global stringIsNullWithString:_accountTF.text] || ![LCRegExpTool lc_checkingMobile:_accountTF.text]) {
        [self showToastWithMessage:@"请输入正确的手机号码"];
        return;
    }
    if([_verificationCodeButton.titleLabel.text isEqualToString:@"获取验证码"]){
        [[UserManager shareUserManager]getVerificationCodeWithPhone:_accountTF.text];
        [UserManager shareUserManager].verificationSuccess = ^(id obj){
            
            [[Global sharedSingleton]showToastInTop:self.view withMessage:@"验证码已发送至您手机"];
            NSLog(@"%@",obj);
            [_verificationCodeButton scheduledGCDTimer];
        };
        
    }else {
        
        [self showToastWithMessage:[NSString stringWithFormat:@"%ld后重发",[UserManager shareUserManager].timers]];
        return;
    }

}

- (IBAction)next:(UIButton *)sender {
    
    if ([Global stringIsNullWithString:_accountTF.text]) {
        [self showToastWithMessage:@"请输入手机号码"];
        return;
    }
    
    if ([Global stringIsNullWithString:_verificationCodeTF.text]) {
        [self showToastWithMessage:@"请输入验证码"];
        return;
    }
    
    [UIManager  bindPhoneViewControllerWithBindPhoneType:BindPhoneTypeChange oldPhoneCode:_verificationCodeTF.text];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self setupHighlightedWithTextFieldTag:textField.tag];
    NSLog(@"%ld",textField.tag);
    NSLog(@"end");
}

-(void)setupHighlightedWithTextFieldTag:(NSInteger)tag{
    
    _accountImage.image = tag == 1 ?  [UIImage imageNamed:@"icon_phone_selected"] :[UIImage imageNamed:@"icon_phone_normal"];
    _verificationCodeImage.image = tag == 2 ?  [UIImage imageNamed:@"icon_code拷贝"]:[UIImage imageNamed:@"icon_code"];
}

@end
