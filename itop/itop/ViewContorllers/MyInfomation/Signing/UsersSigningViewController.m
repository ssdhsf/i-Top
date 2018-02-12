//
//  UsersSigningViewController.m
//  itop
//
//  Created by huangli on 2018/2/11.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "UsersSigningViewController.h"

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
    
    _nameTF.placeholder = @"请输入姓名";
    _workTF.placeholder = @"请输入职位";
    _mobiliTF.placeholder = @"请输入手机号码";
    _verificationCodeTF.placeholder = @"请输入验证码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)agreedProtcol:(UIButton *)sender {
    
    NSLog(@"ddddd");
}

- (IBAction)browseProtcol:(UIButton *)sender {
    
    NSLog(@"dsd");
}

- (IBAction)verificationCode:(UIButton *)sender {
    
    
}

- (IBAction)protocol:(UIButton *)sender {
    
    
}

@end
