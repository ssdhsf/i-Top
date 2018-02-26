//
//  UsersSigningViewController.m
//  itop
//
//  Created by huangli on 2018/2/11.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "UsersSigningViewController.h"

#define TIPSMESSEGE(__CONTENT) [NSString stringWithFormat:@"请输入%@",__CONTENT]
@interface UsersSigningViewController ()
@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *protcolbutton;
@property (weak, nonatomic) IBOutlet UIButton *agreedbutton;
@property (weak, nonatomic) IBOutlet UIView *agreedView;
@property (weak, nonatomic) IBOutlet UIButton *subMitButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *workTF;
@property (weak, nonatomic) IBOutlet UITextField *mobiliTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;

@end

@implementation UsersSigningViewController

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

-(void)initNavigationBarItems{
    
    self.title = @"入驻申请";
}

-(void)initView{
    
    [super initView];
    [self setupViews];
    [self setupViewsData];
}

-(void)setupViews{
    
    [_verificationCodeButton.layer addSublayer:[UIColor setGradualChangingColor: _verificationCodeButton fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
    [_subMitButton.layer addSublayer:[UIColor setGradualChangingColor: _subMitButton fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
    _verificationCodeButton.layer.masksToBounds = YES;
    _subMitButton.layer.masksToBounds = YES;
    _agreedView.layer.masksToBounds = YES;
    _verificationCodeButton.layer.cornerRadius = _verificationCodeButton.height/2;
    _subMitButton.layer.cornerRadius = _subMitButton.height/2;
    _agreedView.layer.cornerRadius = _agreedView.height/2;
    [_agreedbutton bringSubviewToFront:_agreedbutton];;
}

-(void)setupViewsData{
    
    _nameTF.placeholder = TIPSMESSEGE(@"姓名");
    _workTF.placeholder = TIPSMESSEGE(@"职位");
    _mobiliTF.placeholder = TIPSMESSEGE(@"手机号");
    _verificationCodeTF.placeholder =TIPSMESSEGE(@"验证码");
}

- (IBAction)agreedProtcol:(UIButton *)sender {
    
    _agreedbutton.selected = !_agreedbutton.selected;
    if (_agreedbutton.selected) {
        
        _agreedView.backgroundColor = UIColorFromRGB(0xfda5ed);
    } else {
        _agreedView.backgroundColor = UIColorFromRGB(0xe0e3e6);
    }
    NSLog(@"ddddd");
}

- (IBAction)browseProtcol:(UIButton *)sender {
    
    NSLog(@"dsd");
}

- (IBAction)verificationCode:(UIButton *)sender {
   
    if ([Global stringIsNullWithString:_mobiliTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"手机号")];
        return;
    }

    [[UserManager shareUserManager]getVerificationCodeWithPhone:_mobiliTF.text];
    [UserManager shareUserManager].verificationSuccess = ^(id obj){
        
        [[Global sharedSingleton]showToastInTop:self.view withMessage:@"验证码已发送至您手机"];
        NSLog(@"%@",obj);
    };
}

- (IBAction)protocol:(UIButton *)sender {
   
    
    
}

- (IBAction)subMit:(UIButton *)sender {
   
    if ([Global stringIsNullWithString:_nameTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"姓名")];
        return;
    }
    
    if ([Global stringIsNullWithString:_workTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"职位")];
        return;
    }
    if ([Global stringIsNullWithString:_mobiliTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"手机号")];
        return;
    }
    if ([Global stringIsNullWithString:_verificationCodeTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"验证码")];
        return;
    }
    
    if (!_agreedbutton.selected) {
        
        [self showToastWithMessage:@"您还没有同意入驻协议"];
        return;
    }
}

@end
