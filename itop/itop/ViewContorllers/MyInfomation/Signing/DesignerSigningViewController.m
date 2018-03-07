//
//  DesignerSigningViewController.m
//  itop
//
//  Created by huangli on 2018/2/12.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DesignerSigningViewController.h"
#import "YZTagList.h"
#import "DesignerSigningStore.h"

#define TIPSMESSEGE(__CONTENT) [NSString stringWithFormat:@"请输入%@",__CONTENT]

@interface DesignerSigningViewController ()

//设计师信息页
@property (strong, nonatomic) YZTagList *tagList;
@property (strong, nonatomic) NSMutableArray *tagArray;
@property (strong, nonatomic) NSArray *views;
@property (weak, nonatomic) IBOutlet UILabel *goodAtTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobiliTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//上传作品页面
@property (weak, nonatomic) IBOutlet UIButton *selectItopProductButton;
@property (weak, nonatomic) IBOutlet UITextField *productLinkTF;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UITextField *fileNameTF;

@property (weak, nonatomic) IBOutlet UIButton *agreedbutton;
@property (weak, nonatomic) IBOutlet UIView *agreedView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) CAShapeLayer *currentShapeLayer;


@end

@implementation DesignerSigningViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
}

-(void)initView{
    
    _views = [[NSBundle mainBundle] loadNibNamed:@"DesignerSigningViewController" owner:self options:nil];
    self.view = [_views firstObject];
//    NSArray *data = @[@"企业宣传",@"企业招聘",@"产品介绍",@"活动促销",@"报名培训",@"会议邀请",@"品牌推广",@"节日传情",@"商务科技",@"扁平简约",@"清新文艺",@"卡通手绘",@"时尚炫酷",@"中国风",@"最多选3个"];
    _tagArray = [NSMutableArray array];
    for (NSString *tag in [[DesignerSigningStore shearDesignerSigningStore]fieldArray]) {
        
        SpecialityTag *specialityTag = [[SpecialityTag alloc]init];
        specialityTag.tag = tag;
        specialityTag.selecteTag = NO;
        [_tagArray addObject:specialityTag];
    }
    [self buttonSublayer];
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
    _verificationCodeButton.layer.masksToBounds = YES;
    _verificationCodeButton.layer.cornerRadius = _verificationCodeButton.height/2;
    _submitButton.layer.masksToBounds = YES;
    [_submitButton.layer addSublayer:[UIColor setGradualChangingColor: _submitButton fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
    _submitButton.layer.cornerRadius = _submitButton.height/2;
    
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = _nextButton.height/2;
    _nextButton.frame = CGRectMake(ScreenWidth/2-65,CGRectGetMaxY(_tagList.frame)+30,130 , 35);
//    _nextButton.frame = CGRectMake(self.view.centerX-65,CGRectGetMaxY(_tagList.frame)+30,130 , 35);
//    _nextButton.centerX = self.view.centerX;
    [_nextButton.layer addSublayer:[UIColor setGradualChangingColor: _submitButton fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
   
    [_uploadButton.layer addSublayer:[UIColor setGradualChangingColor: _uploadButton fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
    _uploadButton.layer.masksToBounds = YES;
    _uploadButton.layer.cornerRadius = _uploadButton.height/2;
    [_selectItopProductButton.layer addSublayer:_currentShapeLayer];
    
    _agreedView.layer.masksToBounds = YES;
    _agreedView.layer.cornerRadius = _agreedView.height/2;
}

-(void)initNavigationBarItems{
    
    self.title = @"入驻申请";
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
    [_scrollView addSubview:_tagList];
//    _nextButton.frame = CGRectMake(ScreenWidth/2-65,CGRectGetMaxY(_tagList.frame)+30,130 , 35);
    
     __weak typeof(self) weakSelf = self;
    _tagList.clickTagBlock = ^ (NSString *tag, BOOL select){
        
        NSInteger selectNumber = 0 ;
        for (SpecialityTag *sTag in weakSelf.tagArray) {
            if (sTag.selecteTag ==YES) {
                
                selectNumber ++;
            }
        }
        if (selectNumber == 3) {
            
            for (SpecialityTag *sTag in weakSelf.tagArray) {
                if ([sTag.tag isEqualToString:tag]  && sTag.selecteTag == YES) {
                    
                    sTag.selecteTag = !sTag.selecteTag;
                    [weakSelf addkeywordsViewWithkeywords:weakSelf.tagArray];
                    return ;
                }
            }
            [[Global sharedSingleton]showToastInTop:weakSelf.view withMessage:@"选择不超过3个"];
            return ;
        }else {
        
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

- (IBAction)verificationCode:(UIButton *)sender {
    
    if ([Global stringIsNullWithString:_mobiliTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"手机号")];
        return;
    }
    
    [[UserManager shareUserManager]getVerificationCodeWithPhone:_mobiliTF.text];
    [UserManager shareUserManager].verificationSuccess = ^(id obj){
        
        [[Global sharedSingleton]showToastInTop:self.view withMessage:@"验证码已发送至您手机"];
        NSLog(@"%@",obj);
    };
}

- (IBAction)next:(UIButton *)sender {

    if ([Global stringIsNullWithString:_nameTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"姓名")];
        return;
    }
    
    if ([Global stringIsNullWithString:_mobiliTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"手机号")];
        return;
    }
    if ([Global stringIsNullWithString:_verificationCodeTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"验证码")];
        return;
    }

    NSInteger selectNumber = 0 ;
    for (SpecialityTag *sTag in self.tagArray) {
        if (sTag.selecteTag ==YES) {
            
            selectNumber ++;
        }
    }
    
    if (selectNumber == 0) {
        
        [self showToastWithMessage:@"请选择您的特长"];
        return;
    }
    
    self.view  = [_views lastObject];

}

- (IBAction)agreedProtcol:(UIButton *)sender {
    
    _agreedbutton.selected = !_agreedbutton.selected;
    if (_agreedbutton.selected) {
        
        _agreedView.backgroundColor = UIColorFromRGB(0xfda5ed);
    } else {
        _agreedView.backgroundColor = UIColorFromRGB(0xe0e3e6);
    }
    NSLog(@"ddddd");
}

- (IBAction)Protcol:(UIButton *)sender {
    
    [UIManager protocolWithProtocolType:ProtocolTypeDesginer];
}

-(void)back{
    
    if (self.view == [_views lastObject]) {
        
        self.view  = [_views firstObject];
    }else {
        
        [super back];
    }
}

-(void)buttonSublayer{
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, _selectItopProductButton.size.width, _selectItopProductButton.size.height);//虚线框的大小
    borderLayer.position = CGPointMake(CGRectGetMidX(_selectItopProductButton.bounds),CGRectGetMidY(_selectItopProductButton.bounds));//虚线框锚点
    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;//矩形路径
    borderLayer.lineWidth = 0.5/[[UIScreen mainScreen] scale];//虚线宽度
    //虚线边框
    borderLayer.lineDashPattern = @[@6, @3];
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor grayColor].CGColor;
    _currentShapeLayer = borderLayer;
}

@end
