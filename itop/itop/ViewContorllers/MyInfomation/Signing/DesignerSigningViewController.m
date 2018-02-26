//
//  DesignerSigningViewController.m
//  itop
//
//  Created by huangli on 2018/2/12.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DesignerSigningViewController.h"
#import "YZTagList.h"

@interface DesignerSigningViewController ()

@property (strong, nonatomic) YZTagList *tagList;
@property (strong, nonatomic) NSMutableArray *tagArray;
@property (weak, nonatomic) IBOutlet UILabel *goodAtTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;

@end

@implementation DesignerSigningViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
}

-(void)initView{
    
    NSArray *data = @[@"企业招聘",@"企业学习",@"企业拓展",@"个人发展",@"设计",@"H5",@"android",@"web",@"最多选3个"];
    _tagArray = [NSMutableArray array];
    for (NSString *tag in data) {
        
        SpecialityTag *specialityTag = [[SpecialityTag alloc]init];
        specialityTag.tag = tag;
        specialityTag.selecteTag = NO;
        [_tagArray addObject:specialityTag];
    }
    [self addkeywordsViewWithkeywords:_tagArray];
    [self setupViews];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)setupViews{
    
    [_verificationCodeButton.layer addSublayer:[UIColor setGradualChangingColor: _verificationCodeButton fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
    [_submitButton.layer addSublayer:[UIColor setGradualChangingColor: _submitButton fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
    _verificationCodeButton.layer.masksToBounds = YES;
    _submitButton.layer.masksToBounds = YES;
    _verificationCodeButton.layer.cornerRadius = _verificationCodeButton.height/2;
    _submitButton.layer.cornerRadius = _submitButton.height/2;
    
    _submitButton.frame = CGRectMake(self.view.centerX-65,CGRectGetMaxY(_tagList.frame)+30,130 , 35);
//    _submitButton.centerX = self.view.centerX;
}

-(void)addkeywordsViewWithkeywords:(NSArray *)keywords{
    
    // 高度可以设置为0，会自动跟随标题计算
    _tagList = [[YZTagList alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_goodAtTitleLabel.frame), CGRectGetMinY(_goodAtTitleLabel.frame), ScreenWidth-CGRectGetMaxX(_goodAtTitleLabel.frame)-20, 0)];
    _tagList.tag = 1;
    _tagList.backgroundColor = [UIColor whiteColor];
    _tagList.tagCornerRadius = 3;
    _tagList.borderColor = UIColorFromRGB(0xc6c8ce);
    _tagList.borderWidth = 1;
    _tagList.tagFont =  [UIFont systemFontOfSize:15] ;
    // 设置标签背景色
//    _tagList.tagBackgroundColor = RGB(244, 245, 247);
    _tagList.tagColor = [UIColor blackColor];
    [_tagList addTags:keywords];
    [self.view addSubview:_tagList];
    
     __weak typeof(self) weakSelf = self;
    _tagList.clickTagBlock = ^ (NSString *tag){
        
        NSInteger selectNumber = 0 ;
        for (SpecialityTag *sTag in weakSelf.tagArray) {
            if (sTag.selecteTag ==YES) {
                
                selectNumber ++;
            }
        }
        if (selectNumber == 3) {
            
            [[Global sharedSingleton]showToastInTop:weakSelf.view withMessage:@"选择不超过3个"];
        } else {
            
            for (SpecialityTag *sTag in weakSelf.tagArray) {
                if ([sTag.tag isEqualToString:tag]) {
                    
                    sTag.selecteTag = !sTag.selecteTag;
                }
            }
        }
        [weakSelf addkeywordsViewWithkeywords:weakSelf.tagArray];
        NSLog(@"%@",tag);
    };
}

@end
