//
//  LoginViewController.m
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+CAGradientLayer.h"

@interface LoginViewController ()<UITextFieldDelegate,WXApiManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIImageView *accountImage;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImage;
@property (weak, nonatomic) IBOutlet UIButton *seeIcon;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initView{
    
    [_loginButton.layer addSublayer:[UIColor setGradualChangingColor:_loginButton fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
    _loginButton.layer.cornerRadius = _loginButton.frame.size.height/2;
    _loginButton.layer.masksToBounds = YES;
    _accountTF.tag = 1;
    _passwordTF.tag = 2;

}

-(void)initData{
    
    [WXApiManager sharedManager].delegate = self;
    
    _accountTF.text = [[Global sharedSingleton]getUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERNAME];
    _passwordTF.text = [[Global sharedSingleton]getUserDefaultsWithKey:UD_KEY_LAST_LOGIN_PASSWORD];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

//登录
- (IBAction)login:(UIButton *)sender {
    
        [[UserManager shareUserManager]loginWithUserName:_accountTF.text passWord:_passwordTF.text];
        [UserManager shareUserManager].loginSuccess = ^(id obj){
    
            [UIManager goMianViewController];
            
            [[Global sharedSingleton]
             setUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERNAME
             andValue:_accountTF.text];
            [[Global sharedSingleton]
             setUserDefaultsWithKey:UD_KEY_LAST_LOGIN_PASSWORD
             andValue:_passwordTF.text];

        } ;
}

//微信登陆
- (IBAction)weChatLogin:(UIButton *)sender {
    
        [WXApiRequestHandler sendAuthRequestScope:@"snsapi_userinfo"
                                            State:@"itop"
                                           OpenID:WECHAT_APP_ID
                                 InViewController:self];
}

//注册
- (IBAction)registeredButton:(UIButton *)sender {
    
    UIViewController *vc = [UIManager viewControllerWithName:@"registeredViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    [self hiddenNavigationController:NO];
}

//忘记密码
- (IBAction)forgotPassword:(UIButton *)sender {
    
    UIViewController *vc = [UIManager viewControllerWithName:@"ResetPasswordViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    [self hiddenNavigationController:NO];

}

//密码可见
- (IBAction)visible:(UIButton *)sender {
    
//    BOOL b = sender.selected;
    _seeIcon.selected = !sender.selected;
    _passwordTF.secureTextEntry = _seeIcon.selected;
    if (_seeIcon.selected) {
        
        [_seeIcon setImage:[UIImage imageNamed:@"icon_unsee"] forState:UIControlStateNormal];
        
    } else {
        [_seeIcon setImage:[UIImage imageNamed:@"icon_see"] forState:UIControlStateNormal];
    }
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
    _passwordImage.image = tag == 2 ?  [UIImage imageNamed:@"icon_password_selected"] :[UIImage imageNamed:@"icon_password_normal"];
}

-(void)hiddenNavigationController:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:animated];
    [self.navigationController.tabBarController.tabBar setHidden:animated];
}

//微信登陆回调
- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
    NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", response.code, response.state, response.errCode];
    
    NSLog(@"strTitle-%@:strMsg-%@",strTitle,strMsg);
    
    if (response.errCode == 0) {
        
        [UIManager goMianViewController];
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                        message:strMsg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
//        [alert release];

    }
    //    [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
}


@end
