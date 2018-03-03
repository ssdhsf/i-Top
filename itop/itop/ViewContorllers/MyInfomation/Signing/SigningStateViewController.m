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

@end

@implementation SigningStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)initNavigationBarItems{
    
    [super initNavigationBarItems];
    if (_showView_type == ShowViewTypeNext) {
        
        self.title = @"入驻申请";
    }else {
        
        self.title = @"审核状态";
    }
}

-(void)initData{
    
    [super initData];
    
    if (_showView_type == ShowViewTypeNext) {
        
        [self.stateButton setImage:[UIImage imageNamed:@"ruzhu_icon_check"] forState:UIControlStateNormal];
        [self.stateButton setTitle:@"提交成功" forState:UIControlStateNormal];
        self.staleContentLabel.text = @"您的入驻申请已提交，管理员会在1-3个工作日内完成审核。";
    } else{
        
    }
}

-(void)back{
    
    if (_showView_type == ShowViewTypeNext) {
        
        for (UIViewController *vc in self.navigationController.viewControllers) {
          
            if ([vc isKindOfClass:[SigningTypeViewController class]]) {
                
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    } else {
        
        [self back];
    }
}

@end
