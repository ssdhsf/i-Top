//
//  BindPhoneViewController.m
//  itop
//
//  Created by huangli on 2018/3/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BindPhoneViewController.h"

@interface BindPhoneViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *resetFnishButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;
@property (weak, nonatomic) IBOutlet UIImageView *accountImage;
@property (weak, nonatomic) IBOutlet UIImageView *verificationCodeImage;

@end

@implementation BindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
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
}

-(void)initData{
    
    [super initData];
    _accountTF.tag = 1;
    _verificationCodeTF.tag = 2;
}

-(void)initNavigationBarItems{
    
    if (_bindPhoneType == BindPhoneTypeBind) {
        self.title = @"绑定手机";
    }  else {
        
         self.title = @"修改绑定手机号码";
    }
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

- (IBAction)resetFnish:(UIButton *)sender {
    
    if ([Global stringIsNullWithString:_accountTF.text]) {
        [self showToastWithMessage:@"请输入手机号码"];
        return;
    }
    
    if ([Global stringIsNullWithString:_verificationCodeTF.text]) {
        [self showToastWithMessage:@"请输入验证码"];
        return;
    }
    
    if (_bindPhoneType == BindPhoneTypeBind) {
        [[UserManager shareUserManager]bindPhoneWithMobili:_accountTF.text verificationCode:_verificationCodeTF.text];
        [UserManager shareUserManager].bindPhoneSuccess = ^(id obj){
            
            [UIManager goMianViewController];
        };
    } else {
        
        [[UserManager shareUserManager]changePhoneWithMobili:_accountTF.text newPhoneCode:_verificationCodeTF.text oldPhoneCode:_oldPhoneCode];
        [UserManager shareUserManager].bindPhoneSuccess = ^(id obj){
            
            [self alertOperation];
        };
    }
}

-(void)alertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改手机号码成功，需要重新登陆" preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续提交" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UIManager sharedUIManager]LoginViewControllerWithLoginState:YES];
        [[LoginMannager sheardLoginMannager] clearLoginUserMassage];
        [[LoginMannager sheardLoginMannager] stopTimer];
        
        AppDelegate *app = ApplicationDelegate;
        app.tabBarController = nil;
//        [[UserManager shareUserManager]loginOut];
//        [UserManager shareUserManager].loginSuccess = ^ (id obj){
//
//            [[LoginMannager sheardLoginMannager]clearLoginUserMassage];
//
////            [self.navigationController popToRootViewControllerAnimated:YES];
//            [UIManager sharedUIManager].loginOutBackOffBolck (nil);
//
//        };

        //        [UIManager sharedUIManager].realesHotBackOffBolck( @(_itmeIndex));
    }];
    //    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
}



@end
