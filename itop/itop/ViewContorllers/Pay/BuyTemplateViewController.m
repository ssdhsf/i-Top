//
//  BuyTemplateViewController.m
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BuyTemplateViewController.h"

@interface BuyTemplateViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *templateImage;
@property (weak, nonatomic) IBOutlet UILabel *templateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *showPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UILabel *payPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *chargeButton;

@property (strong, nonatomic)Userwallet *userwallet;

@end

@implementation BuyTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initNavigationBarItems{
    
    [super initNavigationBarItems];
    self.title = @"托管赏金" ;
}

-(void)initData{
    
    
    [super initData];
    self.showPriceLabel.text = [NSString stringWithFormat:@"¥%@",_productDetail.product.price];
    self.showPriceLabel.attributedText = [self.showPriceLabel.text setupAttributedString:9 color:UIColorFromRGB(0xeb6ea5) string:self.showPriceLabel.text];
    self.payPriceLabel.text = [NSString stringWithFormat:@"%@元",_productDetail.product.price];
    
    [[UserManager shareUserManager] getuserwallet];
    [UserManager shareUserManager].balanceSuccess = ^(NSDictionary  *obj) {
        
        _userwallet = [[Userwallet alloc]initWithDictionary:obj error:nil];
        _balanceLabel.text = [NSString stringWithFormat:@"(可用余额%@元)",_userwallet.price];
        
    };
    
    [_templateImage sd_setImageWithURL:[NSURL URLWithString:_productDetail.product.cover_img] placeholderImage:H5PlaceholderImage];
    _templateTitleLabel.text = _productDetail.product.title;
}

-(void)initView{
    
    [super initView];
    [_payButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_payButton)];
    _payButton.layer.masksToBounds = YES;
    _payButton.layer.cornerRadius = _payButton.height/2;
}

- (IBAction)pay:(UIButton *)sender {
    
    if ([self compareInputPrice]) {
        
        [UIManager paymentVerificationCodeViewControllerWithDemandId:_productDetail.product.id money:_productDetail.product.price payType:PAYTYPE_PRODUCT];
    } else {
        
        [self showToastWithMessage:@"余额不足，请充值"];
    }
}

-(BOOL)compareInputPrice{
    
    NSString*balancePrice = [NSString stringWithFormat:@"%@",_userwallet.price];
    NSString *payPrice = [NSString stringWithFormat:@"%@",_productDetail.product.price];
    BOOL result = payPrice.floatValue <= balancePrice.floatValue ? YES:NO ;
    return result;
}

@end
