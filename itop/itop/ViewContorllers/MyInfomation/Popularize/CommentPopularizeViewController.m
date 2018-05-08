//
//  CommentPopularizeViewController.m
//  itop
//
//  Created by huangli on 2018/4/11.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CommentPopularizeViewController.h"

@interface CommentPopularizeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *commentTV;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) NSMutableArray *effectButtons;
@property (strong, nonatomic) NSMutableArray *serviceButtons;
@property (strong, nonatomic) NSMutableArray *sincerityButtons;
@property (assign, nonatomic) NSInteger effect;
@property (assign, nonatomic) NSInteger service;
@property (assign, nonatomic) NSInteger sincerity;

@property (weak, nonatomic) IBOutlet UILabel *baseTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *seviceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ultimateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteTitleLabel;



@end

@implementation CommentPopularizeViewController

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
    
    switch (_commentType) {
            
        case CommentTypePopularize:
            
            self.title = @"推广评价";
            break;
            
        case CommentTypeDemandDesginerToEnterprise:
        case CommentTypeDemandEnterpriseToDesginer:

            self.title = @"定制合作评价";
            break;
            
        default:
            break;
    }
}

-(void)initData{
    
    [super initData];
    _effectButtons = [NSMutableArray array];
    _serviceButtons = [NSMutableArray array];
    _sincerityButtons = [NSMutableArray array];
    [self setTitleText];
}

-(NSArray *)commentTypePopularizeTitle{
    
    NSArray *title = @[@"推广效果",@"服务态度",@"诚信度",@"备注"];
    
    return title;
}

-(NSArray *)commentTypeDemandDesginerToEnterpriseTitle{
    
    NSArray *title = @[@"需求明确",@"改动需求率",@"态度",@"备注"];
    
    return title;
}

-(NSArray *)commentTypeDemandEnterpriseToDesginerTitle{
    
    NSArray *title = @[@"产品质量",@"完成失效",@"专业度",@"备注"];
    return title;
}

-(void)setTitleText{
    
    switch (_commentType) {
       
        case CommentTypePopularize:
            
            self.baseTitleLabel.text = [self commentTypePopularizeTitle][0];
            self.seviceTitleLabel.text = [self commentTypePopularizeTitle][1];
            self.ultimateTitleLabel.text = [self commentTypePopularizeTitle][2];
            self.noteTitleLabel.text = [self commentTypePopularizeTitle][3];
            break;
            
        case CommentTypeDemandDesginerToEnterprise:
            
            self.baseTitleLabel.text = [self commentTypeDemandDesginerToEnterpriseTitle][0];
            self.seviceTitleLabel.text = [self commentTypeDemandDesginerToEnterpriseTitle][1];
            self.ultimateTitleLabel.text = [self commentTypeDemandDesginerToEnterpriseTitle][2];
            self.noteTitleLabel.text = [self commentTypeDemandDesginerToEnterpriseTitle][3];

            break;
            
        case CommentTypeDemandEnterpriseToDesginer:
            
            self.baseTitleLabel.text = [self commentTypeDemandEnterpriseToDesginerTitle][0];
            self.seviceTitleLabel.text = [self commentTypeDemandEnterpriseToDesginerTitle][1];
            self.ultimateTitleLabel.text = [self commentTypeDemandEnterpriseToDesginerTitle][2];
            self.noteTitleLabel.text = [self commentTypeDemandEnterpriseToDesginerTitle][3];
            break;

        default:
            break;
    }
}

-(void)initView{
    
    [super initView];
    _submitButton.layer.masksToBounds = YES;
    [_submitButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitButton)];
    _submitButton.layer.cornerRadius = _submitButton.height/2;
    
    [self addGradeStarViewButtons];
}

-(void)addGradeStarViewButtons{
    
    _effect = 0;
    _service = 0;
    _sincerity = 0;

    if (_effectButtons .count != 0) {
        
        for (UIButton *star in _effectButtons) {
            
            if (star.selected == YES) {
                
                [star setImage:[UIImage imageNamed:@"dingzhi_icon_starfen"] forState:UIControlStateNormal];
                _effect ++;
            } else {
                
                [star setImage:[UIImage imageNamed:@"dingzhi_icon_starhui"] forState:UIControlStateNormal];
            }
        }
        
        for (UIButton *star in _serviceButtons) {
            
            if (star.selected == YES) {
                
                _service ++;
                [star setImage:[UIImage imageNamed:@"dingzhi_icon_starfen"] forState:UIControlStateNormal];
            } else {
                
                [star setImage:[UIImage imageNamed:@"dingzhi_icon_starhui"] forState:UIControlStateNormal];
            }
        }
        
        for (UIButton *star in _sincerityButtons) {
            
            if (star.selected == YES) {
                _sincerity ++;
                [star setImage:[UIImage imageNamed:@"dingzhi_icon_starfen"] forState:UIControlStateNormal];
            } else {
                
                [star setImage:[UIImage imageNamed:@"dingzhi_icon_starhui"] forState:UIControlStateNormal];
            }
        }
    } else {
        
        for (int i = 0; i<15; i++) {
            
            UIButton *star = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if ( i < 5) {
                
                star.frame = CGRectMake(108 + i*30, 20, 20, 20);
                [_effectButtons addObject:star];
                
            } else if (i > 4 && i < 10){
                
                star.frame = CGRectMake(108 + (i-5)*30, 61, 20, 20);
                [_serviceButtons addObject:star];
                
            } else{
                
                star.frame = CGRectMake(108 + (i-10)*30, 102, 20, 20);
                [_sincerityButtons addObject:star];
            }
            star.tag = i;
            [star setImage:[UIImage imageNamed:@"dingzhi_icon_starhui"] forState:UIControlStateNormal];
            [star addTarget:self action:@selector(grade:) forControlEvents:UIControlEventTouchDown];
            
            [self.view addSubview:star];
        }
    }
}

-(void)grade:(UIButton *)sender{

    NSMutableArray *arr = sender.tag < 5 ? _effectButtons : sender.tag > 9 ? _sincerityButtons : _serviceButtons ;
    
    for (UIButton *star in arr) {
        
        if ( star.tag <= sender.tag) {
            
            star.selected = YES;
        } else {
            
            star.selected = NO;
        }
    }
    
    [self addGradeStarViewButtons];
}

- (IBAction)submitButton:(UIButton *)sender {
    
    if (_effect == 0) {
        
        [self showToastWithMessage:@"请评分推广效果"];
        return;
    }
    
    if (_service == 0) {
        
        [self showToastWithMessage:@"请评分服务态度"];
        return;
    }

    if (_effect == 0) {
        
        [self showToastWithMessage:@"请评分诚信度"];
        return;
    }
    
    if ([Global stringIsNullWithString:_commentTV.text]) {
        
        [self showToastWithMessage:@"请输入评价内容"];
        return;
    }
    
    NSNumber *cus_id = _commentType == CommentTypePopularize ? _popularize_id : _demand_id;
    [[UserManager shareUserManager]commentPopularizeWithOrderId:cus_id effect:@(_effect) service:@(_service) sincerity:@(_sincerity) content:_commentTV.text commentType:_commentType];
    
    [UserManager shareUserManager].popularizeSuccess = ^ (id obj){
        
        [self back];
        
        if ([UIManager sharedUIManager].commentPopularizeBackOffBolck) {
            [UIManager sharedUIManager].commentPopularizeBackOffBolck(nil);
        }
    };
}


@end
