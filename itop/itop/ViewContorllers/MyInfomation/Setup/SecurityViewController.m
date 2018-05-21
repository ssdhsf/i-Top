//
//  SecurityViewController.m
//  itop
//
//  Created by huangli on 2018/3/4.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SecurityViewController.h"
#import "ChangePhoneViewController.h"

@interface SecurityViewController ()

@property (weak, nonatomic) IBOutlet UIButton *changePasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *changeMobiliButton;
@property (weak, nonatomic) IBOutlet UILabel *mobiliLabel;
@property (weak, nonatomic) IBOutlet UIImageView *changeMobiliImage;
@property (weak, nonatomic) IBOutlet UIImageView *changePassImage;
@property (weak, nonatomic) IBOutlet UILabel *tipsBindMobiliTltleLabel;

@end

@implementation SecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initNavigationBarItems{
    
    self.title = @"账号和安全";
}

-(void)initData{
    
    [super initData];
    UserModel *user = [[UserManager shareUserManager]crrentUserInfomation];
    
    _mobiliLabel.text = user.phone;
    _mobiliLabel.text = [_mobiliLabel.text stringByReplacingOccurrencesOfString:[_mobiliLabel.text substringWithRange:NSMakeRange(3,4)] withString:@"****"];
    if ([Global stringIsNullWithString:user.name]) {
        
        _tipsBindMobiliTltleLabel.text = @"绑定手机号码";
    }else{
        
        _tipsBindMobiliTltleLabel.text =  @"修改手机号码";
    }
}

- (IBAction)changePassword:(UIButton *)sender {
 
    if(sender.tag == 1){

        ChangePhoneViewController *vc = [[ChangePhoneViewController alloc]init];
        vc.oldPhone = [[UserManager shareUserManager]crrentUserInfomation].phone;
        [self.navigationController pushViewController:vc animated:YES];
        
//        [UIManager showVC:@"BindPhoneViewController"];
        
    }else{

        [UIManager showVC:@"ChangePasswordViewController"];
    }
}

@end
