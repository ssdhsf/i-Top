//
//  LoginViewController.m
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+CAGradientLayer.h"
#import "InterfaceBase.h"

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
    
    [_loginButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_loginButton)];
    _loginButton.layer.cornerRadius = _loginButton.frame.size.height/2;
    _loginButton.layer.masksToBounds = YES;
    _accountTF.tag = 1;
    _passwordTF.tag = 2;
    _seeIcon.selected = YES;
    [self seePassword];
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
    
    if ([Global stringIsNullWithString:_accountTF.text] ||[Global stringIsNullWithString:_passwordTF.text]) {
        
        [self showToastWithMessage:@"账号或密码不能为空"];
        return;
    }
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
    
    _seeIcon.selected = !sender.selected;
    [self seePassword];
}

-(void)seePassword{
    
    _passwordTF.secureTextEntry = _seeIcon.selected;
    if (_seeIcon.selected) {
        
        [_seeIcon setImage:[UIImage imageNamed:@"icon_see"] forState:UIControlStateNormal];
        
    } else {
        [_seeIcon setImage:[UIImage imageNamed:@"icon_unsee"] forState:UIControlStateNormal];
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

    if (response.errCode == 0) {

        [[Global sharedSingleton]
         setUserDefaultsWithKey:UD_KEY_LAST_WECHTLOGIN_CODE
         andValue:response.code];
        [[UserManager shareUserManager]wechatLoginWithCallBackCode:response.code];
        [UserManager shareUserManager].loginSuccess = ^ (id obj){
            
            if ([obj isKindOfClass:[NSString class]]) {
                
                NSString *cacheKey = [NSString stringWithFormat:@"%@",obj];
                [[Global sharedSingleton]
                 setUserDefaultsWithKey:WECHTLOGIN_CACHE_KEY
                 andValue:cacheKey];
                UIViewController *vc = [UIManager viewControllerWithName:@"BindPhoneViewController"];
                [self.navigationController pushViewController:vc animated:YES];
                [self hiddenNavigationController:NO];
            } else {
                
                NSDictionary *dic = (NSDictionary *)obj;
                UserModel *user = [[UserModel alloc]initWithDictionary:dic error:nil];
                [[Global sharedSingleton]
                 setUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERINFOMATION
                 andValue:[user toJSONString]];
                [UIManager goMianViewController];
            }
            NSLog(@"%@",obj);
        };
        
    } else {
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", response.code, response.state, response.errCode];
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
