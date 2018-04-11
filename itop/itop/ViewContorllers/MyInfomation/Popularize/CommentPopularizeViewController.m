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
    
    self.title = @"推广评价";
}

-(void)initData{
    
    [super initData];
    _effectButtons = [NSMutableArray array];
    _serviceButtons = [NSMutableArray array];
    _sincerityButtons = [NSMutableArray array];
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
                
                [star setImage:[UIImage imageNamed:@"hot_icon_havecollection"] forState:UIControlStateNormal];
                _effect ++;
            } else {
                
                [star setImage:[UIImage imageNamed:@"hot_icon_collect"] forState:UIControlStateNormal];
            }
        }
        
        for (UIButton *star in _serviceButtons) {
            
            if (star.selected == YES) {
                
                _service ++;
                [star setImage:[UIImage imageNamed:@"hot_icon_havecollection"] forState:UIControlStateNormal];
            } else {
                
                [star setImage:[UIImage imageNamed:@"hot_icon_collect"] forState:UIControlStateNormal];
            }
        }
        
        for (UIButton *star in _sincerityButtons) {
            
            if (star.selected == YES) {
                _sincerity ++;
                [star setImage:[UIImage imageNamed:@"hot_icon_havecollection"] forState:UIControlStateNormal];
            } else {
                
                [star setImage:[UIImage imageNamed:@"hot_icon_collect"] forState:UIControlStateNormal];
            }
        }
    } else {
        
        for (int i = 0; i<15; i++) {
            
            UIButton *star = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if ( i < 5) {
                
                star.frame = CGRectMake(98 + i*30, 20, 20, 20);
                [_effectButtons addObject:star];
                
            } else if (i > 4 && i < 10){
                
                star.frame = CGRectMake(98 + (i-5)*30, 61, 20, 20);
                [_serviceButtons addObject:star];
                
            } else{
                
                star.frame = CGRectMake(98 + (i-10)*30, 102, 20, 20);
                [_sincerityButtons addObject:star];
            }
            star.tag = i;
            [star setImage:[UIImage imageNamed:@"hot_icon_collect"] forState:UIControlStateNormal];
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
    
    [[UserManager shareUserManager]commentPopularizeWithOrderId:_popularize_id effect:@(_effect) service:@(_service) sincerity:@(_sincerity) content:_commentTV.text];
    
    [UserManager shareUserManager].popularizeSuccess = ^ (id obj){
        
        [self back];
        [UIManager sharedUIManager].commentPopularizeBackOffBolck(nil);
    };
    
}


@end
