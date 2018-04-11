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

-(void)initView{
    
    [super initView];
    _submitButton.layer.masksToBounds = YES;
    [_submitButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitButton)];
    _submitButton.layer.cornerRadius = _submitButton.height/2;

}

-(void)addGradeStarViewButtons{
    
    for (int i = 0; i<15; i++) {
        
        UIButton *star = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if ( i < 5) {
            
            star.frame = CGRectMake(98 + i*30, 20, 20, 20);
            
        } else if (i > 5 && i < 10){
            
            star.frame = CGRectMake(98 + (i-5)*30, 61, 20, 20);

        } else{
            
            star.frame = CGRectMake(98 + (i-10)*30, 102, 20, 20);
 
        }
        
        [star setImage:[UIImage imageNamed:@"hot_icon_collect"] forState:UIControlStateNormal];
        
        [self.view addSubview:star];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitButton:(UIButton *)sender {
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
