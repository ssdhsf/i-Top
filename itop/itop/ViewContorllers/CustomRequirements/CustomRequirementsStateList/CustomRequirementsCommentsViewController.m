//
//  CustomRequirementsCommentsViewController.m
//  itop
//
//  Created by huangli on 2018/5/2.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsCommentsViewController.h"

@interface CustomRequirementsCommentsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *comentsBaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsSevieceLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsProfessionLabel;

@end

@implementation CustomRequirementsCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    [super initView];
    
    [self addGradeStarViews];
    
    CGFloat contentHeigt = [Global heightWithString:_customRequirementsComments.content width:ScreenWidth-118 fontSize:15];
    _commentContentLabel.frame = CGRectMake(110, 143, ScreenWidth-130, contentHeigt);
}

-(void)initData{
    
    [super initData];
    
    if (_userType == UserTypeDesigner) {
        
        _comentsBaseLabel.text = @"需求明确";
        _commentsSevieceLabel.text = @"改动需求率";
        _commentsProfessionLabel.text = @"态度";

    } else{
        
        _comentsBaseLabel.text = @"产品质量";
        _commentsSevieceLabel.text = @"完成实效";
        _commentsProfessionLabel.text = @"专业度";
    }
    _commentContentLabel.text = _customRequirementsComments.content;
}

-(void)addGradeStarViews{
    
        for (int i = 0; i<15; i++) {
            
            UIImageView *star = [[UIImageView alloc]init];
            
            if ( i < 5) {
                
                star.frame = CGRectMake(110 + i*30, 20, 20, 20);
                NSInteger state = _userType == UserTypeDesigner ?  [_customRequirementsComments.specific integerValue] :  [_customRequirementsComments.quality integerValue];
                if (i < state) {

                    star.image = [UIImage imageNamed:@"dingzhi_icon_starfen"];
                } else {

                    star.image = [UIImage imageNamed:@"dingzhi_icon_starhui"];
                }
            } else if (i > 4 && i < 10){
                
                star.frame = CGRectMake(110 + (i-5)*30, 61, 20, 20);
                NSInteger state = _userType == UserTypeDesigner ? [_customRequirementsComments.change integerValue] : [_customRequirementsComments.time integerValue] ;
                if (i-5 < state) {
                    
                    star.image = [UIImage imageNamed:@"dingzhi_icon_starfen"];
                } else {
                    
                    star.image = [UIImage imageNamed:@"dingzhi_icon_starhui"];
                }

            } else{
                
                star.frame = CGRectMake(110 + (i-10)*30, 102, 20, 20);

                NSInteger state = _userType == UserTypeDesigner ?  [_customRequirementsComments.attitude integerValue] :  [_customRequirementsComments.profession integerValue];
                if (i-10 < state) {
                    
                    star.image = [UIImage imageNamed:@"dingzhi_icon_starfen"];
                } else {
                    
                    star.image = [UIImage imageNamed:@"dingzhi_icon_starhui"];
                }

            }
            [self.view addSubview:star];
        }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
