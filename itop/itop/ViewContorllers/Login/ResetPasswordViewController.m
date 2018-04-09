//
//  ResetPasswordViewController.m
//  itop
//
//  Created by huangli on 2018/1/20.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "UIColor+CAGradientLayer.h"

@interface ResetPasswordViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *resetFnishButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIImageView *accountImage;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImage;
@property (weak, nonatomic) IBOutlet UIImageView *verificationCodeImage;
@property (weak, nonatomic) IBOutlet UIButton *passwordVisibleButton;


@end

@implementation ResetPasswordViewController

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

-(void)initView{
    
    [super initView];
    [_verificationCodeButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_verificationCodeButton)];
    _verificationCodeButton.layer.cornerRadius = _verificationCodeButton.frame.size.height/2;
    _verificationCodeButton.layer.masksToBounds = YES;
    
    [_resetFnishButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_resetFnishButton)];
    _resetFnishButton.layer.cornerRadius = _resetFnishButton.frame.size.height/2;
    _resetFnishButton.layer.masksToBounds = YES;
    
    [self setupSeeIconWithAnimation:YES];
}

-(void)initData{
    
    [super initData];
    _accountTF.tag = 1;
    _verificationCodeTF.tag = 2;
    _passwordTF.tag = 3;
}

-(void)initNavigationBarItems{
    
    self.title = @"密码重置";
}

- (IBAction)resetFnish:(UIButton *)sender {
    
    if ([Global stringIsNullWithString:_accountTF.text]) {
        [self showToastWithMessage:@"请输入手机号码"];
        return;
    }
    
    if ([Global stringIsNullWithString:_verificationCodeTF.text]) {
        [self showToastWithMessage:@"请输入验证码"];
        return;
    }
    
    if ([Global stringIsNullWithString:_verificationCodeTF.text]) {
        [self showToastWithMessage:@"请输入密码"];
        return;
    }
    
    if (![LCRegExpTool lc_checkingPasswordWithShortest:6 longest:12 password:_passwordTF.text] || ![LCRegExpTool lc_checkingStrFormNumberAndLetter:_passwordTF.text]){
        
        [self showToastWithMessage:@"请输入6-12位大小英文字母和数字组成的密码"];
        return;
    }
    
    [[UserManager shareUserManager]resetPasswordWithUserName:_accountTF.text passWord:_passwordTF.text verificationCode:_verificationCodeTF.text];
    [UserManager shareUserManager].resetPasswordSuccess = ^(id obj){
        
        NSLog(@"%@",obj);
        [self back];
    };
}

- (IBAction)verificationCode:(UIButton *)sender {
    
    [_verificationCodeTF  resignFirstResponder];
    [_accountTF  resignFirstResponder];
    [_passwordTF resignFirstResponder];
    if([Global stringIsNullWithString:_accountTF.text]) {
        
        [self showToastWithMessage:@"请输入手机号码"];
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

- (IBAction)passwordVisible:(UIButton *)sender {
    
    [self setupSeeIconWithAnimation:!sender.selected];

}

-(void)setupSeeIconWithAnimation:(BOOL)animation{
    
    _passwordVisibleButton.selected = animation;
    _passwordTF.secureTextEntry = _passwordVisibleButton.selected;
    [_passwordVisibleButton seePassword];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self setupHighlightedWithTextFieldTag:textField.tag];
    NSLog(@"%ld",textField.tag);
    NSLog(@"end");
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSLog(@"%ld",textField.tag);
    NSLog(@"end");
}

-(void)setupHighlightedWithTextFieldTag:(NSInteger)tag{
    
    _accountImage.image = tag == 1 ?  [UIImage imageNamed:@"icon_phone_selected"] :[UIImage imageNamed:@"icon_phone_normal"];
    _verificationCodeImage.image = tag == 2 ?  [UIImage imageNamed:@"icon_code拷贝"]:[UIImage imageNamed:@"icon_code"];
    _passwordImage.image = tag == 3 ?  [UIImage imageNamed:@"icon_password_selected"] :[UIImage imageNamed:@"icon_password_normal"];
}

@end
