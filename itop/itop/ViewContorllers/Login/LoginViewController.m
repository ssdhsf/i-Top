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
//@property (weak, nonatomic) IBOutlet UIButton *backIcon;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initView{
    
//    _backIcon.hidden = _isLogin;
    
    [_loginButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_loginButton)];
    _loginButton.layer.cornerRadius = _loginButton.frame.size.height/2;
    _loginButton.layer.masksToBounds = YES;
    _accountTF.tag = 1;
    _passwordTF.tag = 2;
    
    [self setupSeeIconWithAnimation:YES];
}

-(void)initData{
    
    [WXApiManager sharedManager].delegate = self;
    _accountTF.text = [[Global sharedSingleton]getUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERNAME];
    _passwordTF.text = [[Global sharedSingleton]getUserDefaultsWithKey:UD_KEY_LAST_LOGIN_PASSWORD];
}

-(void)initNavigationBarItems{
    
    [super initNavigationBarItems];
    [self setLeftCustomBarItem :@"zuo_icon_close" action:@selector(back)];
    self.title = @"登录";
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:_isLogin];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    if (@available(iOS 11, *)) {
//        [self setAdditionalSafeAreaInsets:self.view.safeAreaInsets];
        
    }
//    [self defaultUIWithSafeAreaInsets:self.view.safeAreaInsets];
}

//登录
- (IBAction)login:(UIButton *)sender {
//    
//    if (![LCRegExpTool lc_checkingPasswordWithShortest:6 longest:12 password:_passwordTF.text]){
//        
//        [self showToastWithMessage:@"请输入6-12位大小英文字母和数字组成的密码"];
//        return;
//    }

    [_accountTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    
    if ([Global stringIsNullWithString:_accountTF.text] ||[Global stringIsNullWithString:_passwordTF.text]) {
        
        [self showToastWithMessage:@"账号或密码不能为空"];
        return;
    }
    [[UserManager shareUserManager]loginWithUserName:_accountTF.text passWord:_passwordTF.text];
    [UserManager shareUserManager].loginSuccess = ^(id obj){
        
        [[LoginMannager sheardLoginMannager]initTimer]; //10分钟后续命
        [UIManager makeKeyAndVisible];
        [[Global sharedSingleton]
         setUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERNAME
         andValue:_accountTF.text];
        [[Global sharedSingleton]
         setUserDefaultsWithKey:UD_KEY_LAST_LOGIN_PASSWORD
         andValue:_passwordTF.text];
        
        if (![Global stringIsNullWithString:[[UserManager shareUserManager]crrentUserInfomation].token]) {  //有时候有时候没有
            [[LoginMannager sheardLoginMannager]initTimer]; //续命
        }
    } ;
}

//微信登陆
- (IBAction)weChatLogin:(UIButton *)sender {
    
    [WXApiRequestHandler sendAuthRequestScope:@"snsapi_userinfo"
                                            State:@"i-Top"
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
//    [UIManager showVC:@"ResetPasswordViewController"];
}

//密码可见
- (IBAction)visible:(UIButton *)sender {

    [self setupSeeIconWithAnimation:!sender.selected];
}

-(void)setupSeeIconWithAnimation:(BOOL)animation{

    _seeIcon.selected = animation;
    _passwordTF.secureTextEntry = _seeIcon.selected;
    [_seeIcon seePassword];
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

//-(void)hiddenNavigationController:(BOOL)animated{
//
//    [self.navigationController.navigationBar setHidden:animated];
//    [self.navigationController.tabBarController.tabBar setHidden:animated];
//}

//微信登陆回调
- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {

    if (response.errCode == 0) {

        [[Global sharedSingleton]
         setUserDefaultsWithKey:UD_KEY_LAST_WECHTLOGIN_CODE
         andValue:response.code];
        [[UserManager shareUserManager]wechatLoginWithCallBackCode:response.code];
        [UserManager shareUserManager].loginSuccess = ^ (id obj){
            
            if ([obj isKindOfClass:[NSString class]] && [obj rangeOfString:@"WeChat"].location != NSNotFound) {
                
                NSString *cacheKey = [NSString stringWithFormat:@"%@",obj];
                [[Global sharedSingleton]
                 setUserDefaultsWithKey:WECHTLOGIN_CACHE_KEY
                 andValue:cacheKey];
                [UIManager  bindPhoneViewControllerWithBindPhoneType:BindPhoneTypeBind oldPhoneCode:nil];
                [self hiddenNavigationController:NO];
            } else {
                
              
                if ( [UIManager appDelegate].tabBarController != nil) {
                    
                    [UIManager appDelegate].tabBarController = nil;
                }
                NSDictionary *dic = (NSDictionary *)obj;
                UserModel *user = [[UserModel alloc]initWithDictionary:dic error:nil];
                [[Global sharedSingleton]
                 setUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERINFOMATION
                 andValue:[user toJSONString]];
                [UIManager goMianViewController];
                
                if (![Global stringIsNullWithString:user.token]) {  //有时候  有时候没有
                    
                      [[LoginMannager sheardLoginMannager]initTimer]; //续命
                }
                
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

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
