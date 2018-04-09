//
//  SigningTypeViewController.m
//  itop
//
//  Created by huangli on 2018/2/27.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SigningTypeViewController.h"
#import "DesignerSigningViewController.h"
#import "CompanySigningViewController.h"

@interface SigningTypeViewController ()

@property (weak, nonatomic) IBOutlet UIView *desinerSelectView;
@property (weak, nonatomic) IBOutlet UIView *companySelectView;
@property (weak, nonatomic) IBOutlet UIView *naturalSelectView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (assign, nonatomic)  NSInteger selectTag;
@property (strong, nonatomic)  NSArray *vcNameArray;

@end

@implementation SigningTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initNavigationBarItems{
    
    self.title = @"入驻申请";
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initView{
    
    [super initView];
    _desinerSelectView.layer.masksToBounds = YES;
    _companySelectView.layer.masksToBounds = YES;
    _naturalSelectView.layer.masksToBounds = YES;
    _desinerSelectView.layer.cornerRadius = _desinerSelectView.height/2;
    _companySelectView.layer.cornerRadius = _companySelectView.height/2;
    _naturalSelectView.layer.cornerRadius = _naturalSelectView.height/2;
    _desinerSelectView.tag = 0;
    _companySelectView.tag = 1;
    _naturalSelectView.tag = 2;
    _selectTag = 100;
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = _nextButton.frame.size.height/2;
    [_nextButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_nextButton)];
}

-(void)initData{
    
    [super initData];
    _vcNameArray = @[@"DesignerSigningViewController",
                     @"CompanySigningViewController",
                     @"MarketingViewController"];
}

- (IBAction)selection:(UIButton *)sender {

    _selectTag = sender.tag;
    _desinerSelectView.backgroundColor = sender.tag == _desinerSelectView.tag ? UIColorFromRGB(0xfda5ed) : UIColorFromRGB(0xe0e3e6);
    _companySelectView.backgroundColor = sender.tag == _companySelectView.tag ? UIColorFromRGB(0xfda5ed) : UIColorFromRGB(0xe0e3e6);
    _naturalSelectView.backgroundColor = sender.tag == _naturalSelectView.tag ? UIColorFromRGB(0xfda5ed) : UIColorFromRGB(0xe0e3e6);
}

- (IBAction)next:(UIButton *)sender {
    
    if (_selectTag == _desinerSelectView.tag || _selectTag == _companySelectView.tag || _selectTag == _naturalSelectView.tag) {
        
        [UIManager showVC:_vcNameArray[_selectTag]];
    } else {
        
        [self showToastWithMessage:@"请选择角色"];
    }
}

@end
