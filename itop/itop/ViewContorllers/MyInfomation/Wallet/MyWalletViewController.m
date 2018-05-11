//
//  MyWalletViewController.m
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyWalletViewController.h"
#import "RechargeViewController.h"

@interface MyWalletViewController ()

@property (weak, nonatomic) IBOutlet UIButton *payButtob;//充值
@property (weak, nonatomic) IBOutlet UIButton *cashButton;//提现

@property (weak, nonatomic) IBOutlet UILabel *earningsLabel; //收益
@property (weak, nonatomic) IBOutlet UILabel *allIDouLabel; //总i豆
@property (weak, nonatomic) IBOutlet UILabel *remainingLabel;//账户余额

@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initNavigationBarItems{
    
    self.title = @"我的钱包";
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initView {
    
    [super initView];
    
    _payButtob.backgroundColor = UIColorFromRGB(0xFFA5EC);
    _cashButton.backgroundColor = UIColorFromRGB(0xB499F8);
    _payButtob.layer.masksToBounds = YES;
    _payButtob.layer.cornerRadius = _payButtob.height/2;

    _cashButton.layer.masksToBounds = YES;
    _cashButton.layer.cornerRadius = _cashButton.height/2;
}

- (IBAction)recharge:(UIButton *)sender {
     [UIManager showVC:@"RechargeViewController"];
}

- (IBAction)tradingList:(UIButton *)sender {
    
    [UIManager showVC:@"TradingListViewController"];
}

- (IBAction)earningsList:(UIButton *)sender {
    
    [UIManager showVC:@"EarningListViewController"];
}

@end
