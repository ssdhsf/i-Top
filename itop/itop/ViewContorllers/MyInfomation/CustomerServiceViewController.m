//
//  CustomerServiceViewController.m
//  itop
//
//  Created by huangli on 2018/3/3.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomerServiceViewController.h"


#define Customer_Service @"联系客服"
#define Opinion_Feedback @"意见反馈"
@interface CustomerServiceViewController ()

@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *feedbackSubmitButton;
@property (weak, nonatomic) IBOutlet UITextView *feedbackTV;

@property (strong, nonatomic) NSArray *views;

@end

@implementation CustomerServiceViewController

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
   
    self.title = _titel;
}

-(void)initView{
    
    [super initView];
    _views = [[NSBundle mainBundle] loadNibNamed:@"CustomerServiceViewController" owner:self options:nil];
    self.view = [_views firstObject];

    if ([_titel isEqualToString:Customer_Service]) {
        
        [self setupCustomerServiceView];
        self.view = [_views firstObject];
    } else {
        
        [self setupFeedbackView];
        self.view = [_views lastObject];
    }
}

-(void)setupFeedbackView{
    
    _feedbackSubmitButton.layer.masksToBounds = YES;
    [_feedbackSubmitButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_feedbackSubmitButton)];
    _feedbackSubmitButton.layer.cornerRadius = _feedbackSubmitButton.height/2;
    _feedbackTV.placeholder = @"请输入反馈内容，200字以内";
}

-(void)setupCustomerServiceView{

    _submitButton.layer.masksToBounds = YES;
    [_submitButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitButton)];
    _submitButton.layer.cornerRadius = _submitButton.height/2;
    _contentTV.placeholder = @"请输入反馈内容，200字以内";
    
}

- (IBAction)submit:(UIButton *)sender {
   
    if ([_titel isEqualToString:Customer_Service] &&[Global stringIsNullWithString:_contentTV.text]) {
        [self showToastWithMessage:@"输入内容"];
        return;
    }
    
    if ([_titel isEqualToString:Opinion_Feedback] &&[Global stringIsNullWithString:_feedbackTV.text]) {
        
        [self showToastWithMessage:@"请输入内容"];
        return;
    }
    
    if ([_titel isEqualToString:Customer_Service] && _contentTV.text.length <=200 ) {
        
        [[UserManager shareUserManager]opinionCustomerServiceWithContent:_contentTV.text feedbackType:sender.tag];
    } else if([_titel isEqualToString:Opinion_Feedback] && _feedbackTV.text.length <=200){
        
        [[UserManager shareUserManager]opinionCustomerServiceWithContent:_feedbackTV.text feedbackType:sender.tag];
    } else {
        
        [self showToastWithMessage:@"输入文字长度不能超过200"];
    }
    
    [UserManager shareUserManager].customerServiceSuccess = ^(id obj){
      
        [self alertOperation];
    };
}

-(void)alertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"留在此页" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        _contentTV.text = nil;
        _feedbackTV.text = nil;
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self back];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
