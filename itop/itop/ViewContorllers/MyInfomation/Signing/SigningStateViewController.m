//
//  SigningStateViewController.m
//  itop
//
//  Created by huangli on 2018/2/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SigningStateViewController.h"
#import "SigningTypeViewController.h"

@interface SigningStateViewController ()

@property (weak, nonatomic) IBOutlet UIButton *stateButton;
@property (weak, nonatomic) IBOutlet UILabel *staleContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (assign, nonatomic) SigningStateType signing;

@end

@implementation SigningStateViewController

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

-(void)initView{
    
    [super initView];
    [_nextButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_nextButton)];
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = _nextButton.height/2;
    self.nextButton.frame = CGRectMake(0, CGRectGetMaxY(_staleContentLabel.frame)+50, 150 , 35);
    self.nextButton.centerX = self.staleContentLabel.centerX;
}

-(void)initNavigationBarItems{
    
    [super initNavigationBarItems];
    if (_showView_type == ShowSigningStateViewTypeNext) {
        
        self.title = @"入驻申请";
    }else {
        
        self.title = @"审核状态";
    }
}

-(void)initData{
    
    [super initData];
    
    self.staleContentLabel.frame = CGRectMake(20, CGRectGetMaxY(_stateButton.frame)+50, ScreenWidth-40, 42);
    if (_showView_type == ShowSigningStateViewTypeNext) {
        
        [self.stateButton setImage:[UIImage imageNamed:@"ruzhu_icon_check"] forState:UIControlStateNormal];
        [self.stateButton setTitle:@"提交成功" forState:UIControlStateNormal];
        self.staleContentLabel.text = @"您的入驻申请已提交，管理员会在1-3个工作日内完成审核。";
        self.nextButton.hidden = YES;
    } else{
        
//        signing = SigningStateTypeUnCheck;
        NSString *message;
        if (_signingState.designer != nil) { //获取设计师
            
            _signing = [_signingState.designer.check_status integerValue];
            message = _signingState.designer.message;
        }
        
        if (_signingState.enterprise != nil) {
            
            _signing = [_signingState.enterprise.check_status integerValue];
            message = _signingState.enterprise.message;
        }
        
        if (_signingState.marketing != nil) {
            
            _signing = [_signingState.marketing.check_status integerValue];
            message = _signingState.marketing.message;
        }
        
        switch (_signing) {
          
            case SigningStateTypeCheckOn:
            case SigningStateTypeUnCheck:
                
                [self.stateButton setImage:[UIImage imageNamed:@"ruzhu_icon_check"] forState:UIControlStateNormal];
                [self.stateButton setTitle:@"审核中" forState:UIControlStateNormal];
                self.staleContentLabel.text = @"您的入驻申请已提交，管理员会在1-3个工作日内完成审核。";
                self.nextButton.hidden = YES;
                break;
                
            case SigningStateTypePass:
                
                [self.stateButton setImage:[UIImage imageNamed:@"ruzhu_icon_success"] forState:UIControlStateNormal];
                [self.stateButton setTitle:@"入驻成功" forState:UIControlStateNormal];
                self.nextButton.hidden = NO;
                switch (_signingType) {
                    case SigningTypeDesigner:
                         [self.nextButton setTitle:@"开启设计师之旅" forState:UIControlStateNormal];
                        self.staleContentLabel.text = @"您的入驻申请已经通过审核，恭喜你成为i-Top平台设计师。";

                        break;
                    case SigningTypeCompany:
                        [self.nextButton setTitle:@"开启企业之旅" forState:UIControlStateNormal];
                        self.staleContentLabel.text = @"您的入驻申请已经通过审核，恭喜你成为i-Top平台企业用户。";

                        break;
                    case SigningTypeMarketing:
                        [self.nextButton setTitle:@"开启自营销人之旅" forState:UIControlStateNormal];
                        self.staleContentLabel.text = @"您的入驻申请已经通过审核，恭喜你成为i-Top平台自营销人。";

                        break;
                    default:
                        break;
                }
               
                break;
            case SigningStateTypeUnPass:
                
                [self.stateButton setImage:[UIImage imageNamed:@"ruzhu_icon_close"] forState:UIControlStateNormal];
                
                [self.stateButton setTitle:@"不通过" forState:UIControlStateNormal];
                self.staleContentLabel.text = [NSString stringWithFormat:@"您的入驻申请不通过，具体原因如下。%@",message];
               NSInteger messageHight = [Global heightWithString:[NSString stringWithFormat:@"您的入驻申请不通过，具体原因如下。%@",message] width:ScreenWidth-40 fontSize:15];
                
                self.staleContentLabel.frame = CGRectMake(20, CGRectGetMaxY(_stateButton.frame)+50, ScreenWidth-40 , messageHight+20);
                self.nextButton.hidden = NO;
                [self.nextButton setTitle:@"重新提交" forState:UIControlStateNormal];
                break;

            default:
                break;
        }
    }
}

-(void)back{
    
    if (_showView_type == ShowSigningStateViewTypeNext) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        
        [super back];
    }
}

- (IBAction)next:(UIButton *)sender {
    
    
    switch (_signing) {
        case SigningStateTypePass:
            
            [[UserManager shareUserManager]loginWithUserName:[[Global sharedSingleton] getUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERNAME] passWord:[[Global sharedSingleton] getUserDefaultsWithKey:UD_KEY_LAST_LOGIN_PASSWORD]];
            [UserManager shareUserManager].loginSuccess = ^(id obj){
                
                [UIManager makeKeyAndVisible];
                
            } ;
            break;
            
        case SigningStateTypeUnPass:
            switch (_signingType) {
                case SigningTypeDesigner:
                    
                    [UIManager  showVC:@"DesignerSigningViewController"];
                    break;
                case SigningTypeCompany:
                    
                    [UIManager  showVC:@"CompanySigningViewController"];
                    break;
                    
                case SigningTypeMarketing:
                    
                    [UIManager  showVC:@"MarketingViewController"];
                    break;
                    
                default:
                    break;
            }

            break;
            
        default:
            break;
    }
}

@end
