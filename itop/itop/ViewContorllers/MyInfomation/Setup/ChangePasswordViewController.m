//
//  ChangePasswordViewController.m
//  itop
//
//  Created by huangli on 2018/3/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *originalPassImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passNewImageView;
@property (weak, nonatomic) IBOutlet UIImageView *againPassImageView;
@property (weak, nonatomic) IBOutlet UITextField *originalPassTF;
@property (weak, nonatomic) IBOutlet UITextField *passNewTF;
@property (weak, nonatomic) IBOutlet UITextField *againPassTF;

@property (weak, nonatomic) IBOutlet UIButton *passNewSeeButton;
@property (weak, nonatomic) IBOutlet UIButton *againPassSeeButton;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
  
    [super viewDidLoad];
}

-(void)initView{
    
    [super initView];
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = _submitButton.frame.size.height/2;
    [_submitButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitButton)];
}

-(void)initData{
    
    _originalPassTF.tag = 1;
    _passNewTF.tag = 2;
    _againPassTF.tag = 3;
    
    [self setupSeeIconWithAnimation:YES tag:_passNewSeeButton.tag];
    [self setupSeeIconWithAnimation:YES tag:_againPassSeeButton.tag];
}

-(void)initNavigationBarItems{
    
    self.title = @"修改密码";
}

- (IBAction)see:(UIButton *)sender {
    
    [self setupSeeIconWithAnimation:!sender.selected tag:sender.tag];
}


-(void)setupSeeIconWithAnimation:(BOOL)animation tag:(NSInteger)tag{
    
    if (tag == 1) {
        
        _passNewSeeButton.selected = animation;
        _passNewTF.secureTextEntry = _passNewSeeButton.selected;
        [_passNewSeeButton seePassword];
    } else {
        _againPassSeeButton.selected = animation;
        _againPassTF.secureTextEntry = _againPassSeeButton.selected;
        [_againPassSeeButton seePassword];
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
    
    _originalPassImageView.image = tag == 1 ?  [UIImage imageNamed:@"icon_password_selected"] :[UIImage imageNamed:@"icon_password_normal"];
    _passNewImageView.image = tag == 2 ?  [UIImage imageNamed:@"icon_password_selected"]:[UIImage imageNamed:@"icon_password_normal"];
    _againPassImageView.image = tag == 3 ?  [UIImage imageNamed:@"icon_password_selected"]:[UIImage imageNamed:@"icon_password_normal"];
}

- (IBAction)submit:(UIButton *)sender {
    
    if ([Global stringIsNullWithString:_originalPassTF.text]) {
        [self showToastWithMessage:@"请输入旧密码"];
        return;
    }
    
    if ([Global stringIsNullWithString:_passNewTF.text]) {
        [self showToastWithMessage:@"请输入新密码"];
        return;
    }
    
    if (![_passNewTF.text isEqualToString:_againPassTF.text]) {
        [self showToastWithMessage:@"两次输入的新密码不匹配"];
        return;
    }
    
    if (![LCRegExpTool lc_checkingPasswordWithShortest:6 longest:12 password:_againPassTF.text] || ![LCRegExpTool lc_checkingStrFormNumberAndLetter:_againPassTF.text]){
        
        [self showToastWithMessage:@"请输入6-12位大小英文字母和数字组成的密码"];
        return;
    }
    
    [[UserManager shareUserManager]changePassWithOriginalPass:_originalPassTF.text newPass:_passNewTF.text];
    [UserManager shareUserManager].changePassSuccess = ^(id obj){
    
        [self showToastWithMessage:@"密码修改成功"];
        [self back];
    };
}


@end
