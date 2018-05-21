//
//  TemplateDetaulViewController.m
//  itop
//
//  Created by huangli on 2018/2/4.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "TemplateDetaulViewController.h"
#import "DirectMessagesViewController.h"

@interface TemplateDetaulViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)ProductDetail *productDetail;
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)WebViewController *webVc;

/*type-H5*/
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIButton *companyButoon;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *usersCount;
@property (weak, nonatomic) IBOutlet UILabel *browseLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *mutabelCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *imageCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *desginerTiltleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *designerIcon;
@property (weak, nonatomic) IBOutlet UILabel *designerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *designerIntroductionLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusButton;
@property (nonatomic, assign)FocusType focusType;
//@property (nonatomic, strong)DesignerInfo *designerInfo;
@property (weak, nonatomic) IBOutlet UIButton *pricebutton;

@property (nonatomic, strong)CaseDetail *caseDetail; //案例详情

/*type-Case*/
@property (strong, nonatomic) IBOutlet UIView *caseDetailView;
@property (weak, nonatomic) IBOutlet UILabel *caseTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *caseDiscriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *casecustomerLabel;
@property (weak, nonatomic) IBOutlet UILabel *demandCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *caseDesignerIcon;
@property (weak, nonatomic) IBOutlet UILabel *caseDesignerNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *caseDesignerFocusButton;

@end

@implementation TemplateDetaulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigafindHairlineImageView:YES];
    [self hiddenNavigationController:NO];
}

-(void)initNavigationBarItems{
    
    self.title = @"模版详情";
}

-(void)initData{
    
    
    [super initData];
    
    [self hiddenOpraitionButtonWithIsHidden:YES];
    if (_productType == H5ProductTypeCase) {
        
        [[UserManager shareUserManager]caseDetailWithCaseId:_template_id];
        [UserManager shareUserManager].myCaseListSuccess = ^(NSDictionary *obj){
            
            _caseDetail = [[CaseDetail alloc]initWithDictionary:obj error:nil];
//            if ([_caseDetail.designer_info.user_id isEqualToNumber:[[UserManager shareUserManager] crrentUserId]]) {
            
            [self createScrollView];
            [self setupCaseDetailSubViewData];
//            [self createScrollView];
            
//            if (_productType == H5ProductTypeCase) {
            
            [self setupCaseDetailSubViewData];
//            } else {
            
//                [self setupDetailSubViewData];
//            }

//                _focu_focusButton    UIButton *    0x7fd9f8db7620    0x00007fd9f8db7620sButton.hidden = YES;
                
//            } else {
//
//                [self lodingDesignerInfomation];
//                _focusButton.hidden = NO;
//            }

            //        self.dataArray = [[DirectionalDemandReleaseStore shearDirectionalDemandReleaseStore]configurationCaseWitiCaseDetail:_caseDetail isEdit:_isEdit];
            
            //        [self steupTableView];
        };

    } else {
       
        [[UserManager shareUserManager]productDetailWithHotDetailId:_template_id];
        [UserManager shareUserManager].productDetailSuccess = ^(NSDictionary *dic){
            
            _productDetail = [[ProductDetail alloc]initWithDictionary:dic error:nil];
            _productDetail.product.descrip = dic[@"product"][@"description"];
            
            [self createScrollView];
            [self setupCaseDetailSubViewData];
            [self setupDetailSubViewData];
//            if ([_productDetail.product.user_id isEqualToNumber:[[UserManager shareUserManager] crrentUserId]]) {
//
//                [self createScrollView];
//                [self setupDetailSubViewData];
//                _focusButton.hidden = YES;
//
//            } else {
            
//                [self lodingDesignerInfomation];
//                _focusButton.hidden = NO;
//            }
        };
    }
}

//-(void)lodingDesignerInfomation{
//
//    NSNumber *desginer_id = _productType == H5ProductTypeCase ? _caseDetail.designer_info.user_id : _productDetail.product.user_id;
//    [[UserManager shareUserManager]designerDetailWithDesigner:desginer_id];
//    [UserManager shareUserManager].designerDetailSuccess = ^(id obj){
//
//        _designerInfo = [[DesignerInfo alloc]initWithDictionary:obj error:nil];
//
//        [self createScrollView];
//
//        if (_productType == H5ProductTypeCase) {
//
//            [self setupCaseDetailSubViewData];
//        } else {
//
//            [self setupDetailSubViewData];
//        }
//    };
//}

-(void)initView{
    
    [super initView];
    [self.companyButoon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth/2);
        make.bottom.mas_equalTo(kDevice_Is_iPhoneX ? -34 : 0);
        make.height.mas_equalTo(45);
    }];
    [self.pricebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth/2);
        make.bottom.mas_equalTo(kDevice_Is_iPhoneX ? -34 : 0);
        make.height.mas_equalTo(45);
    }];
}

-(void)createScrollView{
    
    if(_scroll){
        
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        [_scroll removeFromSuperview];
        _scroll = nil;
    }
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigh-NAVIGATION_HIGHT-TABBAR_HIGHT+4)];;
    [self.view addSubview:_scroll];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(2*ScreenWidth, ScreenHeigh-169);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    [self setupWebViewVc];
    
    if (_productType == H5ProductTypeCase) {
        
         [self setupCaseDetailView];
    } else {
        
         [self setupDetailView];
    }
}

-(void)setupWebViewVc{
    
    _webVc = [[WebViewController alloc]init];
    if (_productType == H5ProductTypeCase) {
        
         _webVc.h5Url = _caseDetail.info.url;
    } else {
        
         _webVc.h5Url = _productDetail.product.url;
    }
   
    CGFloat webVcHigth = ScreenHeigh-NAVIGATION_HIGHT-TABBAR_HIGHT +4;
    _webVc.view.frame = CGRectMake(0, 0, ScreenWidth,  ScreenHeigh);
    [_scroll addSubview:_webVc.view];
}

-(void)setupDetailView{
    
    _detailView.frame = CGRectMake(ScreenWidth,0 , ScreenWidth, ScreenHeigh-NAVIGATION_HIGHT-TABBAR_HIGHT+4);
    NSInteger introduceLabelHeight = [Global heightWithString:_productDetail.product.descrip width:ScreenWidth-50 fontSize:15];
    _introduceLabel.frame = CGRectMake(25, 157, ScreenWidth-50, introduceLabelHeight+10);
    _mutabelCountLabel.frame = CGRectMake(25, CGRectGetMaxY(_introduceLabel.frame)+40, ScreenWidth-50, 21);
    _imageCountLabel.frame = CGRectMake(25, CGRectGetMaxY(_mutabelCountLabel.frame)+25, ScreenWidth-50, 21);
    _desginerTiltleLabel.frame = CGRectMake(25, CGRectGetMaxY(_imageCountLabel.frame)+40, ScreenWidth-50, 21);
    _designerIcon.frame = CGRectMake(25, CGRectGetMaxY(_desginerTiltleLabel.frame)+25, 40, 40);
    
    _designerIcon.layer.masksToBounds = YES;
    _designerIcon.layer.cornerRadius = 20;
    
    _designerNameLabel.frame = CGRectMake(CGRectGetMaxX(_designerIcon.frame)+24, CGRectGetMaxY(_desginerTiltleLabel.frame)+25, ScreenWidth-160, 21);
    
    NSInteger designerIntroductionLabelHeight = [Global heightWithString:_productDetail.designer_field width:ScreenWidth-110 fontSize:15];
    _designerIntroductionLabel.frame = CGRectMake(CGRectGetMaxX(_designerIcon.frame)+24, CGRectGetMaxY(_designerNameLabel.frame)+10, ScreenWidth-110, designerIntroductionLabelHeight);

    
    _focusType = [_productDetail.designer_follow integerValue];
    [self setupFocusState];
    
    [_scroll addSubview:_detailView];
}

-(void)setupDetailSubViewData{
    
    _titleLable.text = _productDetail.product.title;
    _usersCount.text = _productDetail.product.sale_count;
    _browseLabel.text = _productDetail.product.browse_count;
    _commentsLabel.text = _productDetail.product.comment_count;
    _introduceLabel.text = _productDetail.product.descrip;
    _imageCountLabel.text = [NSString stringWithFormat:@"图片  %@  文字  %@  logo  %@  其他  %@",_productDetail.product.comment_count,_productDetail.product.comment_count,_productDetail.product.comment_count,_productDetail.product.comment_count];
    _designerNameLabel.text = _productDetail.designer_name;
    
    NSString *price = [NSString stringWithFormat:@"¥%@",_productDetail.product.price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:price];
    //设置范围
    NSRange range1 = NSMakeRange(0, 1);
    //为某一范围内文字设置多个属性
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           [UIColor whiteColor], NSForegroundColorAttributeName,
                           [UIFont systemFontOfSize:12.0], NSFontAttributeName,  nil];
    [str setAttributes:attrs range:range1];
    [_pricebutton setAttributedTitle:str forState:UIControlStateNormal];
    [_designerIcon sd_setImageWithURL:[NSURL URLWithString:_productDetail.designer_head_img] placeholderImage:PlaceholderImage];
    _designerIntroductionLabel.text = _productDetail.designer_field;
    [self.companyButoon setTitle:@"企业免费使用" forState:UIControlStateNormal];
     [self hiddenOpraitionButtonWithIsHidden:NO];
}

-(void)setupCaseDetailView{
    
    _caseDetailView.frame = CGRectMake(ScreenWidth,0 , ScreenWidth, ScreenHeigh-NAVIGATION_HIGHT-TABBAR_HIGHT+4);
    NSInteger introduceLabelHeight = [Global heightWithString:_caseDetail.info.descrip width:ScreenWidth-50 fontSize:15];
    _caseDiscriptionLabel.frame = CGRectMake(25, 52, ScreenWidth-50, introduceLabelHeight+10);
    _casecustomerLabel.frame = CGRectMake(25, CGRectGetMaxY(_caseDiscriptionLabel.frame)+40, ScreenWidth-50, 21);
    _demandCountLabel.frame = CGRectMake(25, CGRectGetMaxY(_casecustomerLabel.frame)+25, ScreenWidth-50, 21);
    _caseDesignerIcon.frame = CGRectMake(25, ScreenHeigh-300, 40, 40);
    
    _caseDesignerIcon.layer.masksToBounds = YES;
    _caseDesignerIcon.layer.cornerRadius = 20;
    _caseDesignerNameLabel.frame = CGRectMake(CGRectGetMaxX(_caseDesignerIcon.frame)+24, 0, ScreenWidth-160, 21);
//    _focusType = [_caseDetail.designer_info.follow integerValue];
    
    _caseDesignerNameLabel.centerY = _caseDesignerIcon.centerY;
    [self setupCaseDesginerFocusState];
    [_scroll addSubview:_caseDetailView];
}

-(void)setupCaseDetailSubViewData{
    
    _caseTitleLabel.text = _caseDetail.info.title;
    _caseDiscriptionLabel.text = _caseDetail.info.descrip;
    _casecustomerLabel.text = [NSString stringWithFormat:@"案例客户  %@",_caseDetail.info.customer_name];
    _demandCountLabel.text = [NSString stringWithFormat:@"定制  %@",_caseDetail.info.demand_count];
    _caseDesignerNameLabel.text = _caseDetail.designer_info.nickname;
    [_caseDesignerIcon sd_setImageWithURL:[NSURL URLWithString:_caseDetail.designer_info.head_img] placeholderImage:PlaceholderImage];
    [_pricebutton setTitle:@"在线咨询" forState:UIControlStateNormal];
    [self.companyButoon setTitle:@"立即定制" forState:UIControlStateNormal];
    [self hiddenOpraitionButtonWithIsHidden:NO];
}

#pragma mark 改变热点FocusButton状态
-(void)setupFocusState{
    
    if (_focusType == FocusTypeFocus) {
        
        _focusButton.frame = CGRectMake(ScreenWidth-85, CGRectGetMinY(_designerNameLabel.frame), 65, 20);
        [_focusButton setTitle:@"取消关注" forState:UIControlStateNormal];
    }else {
        
        _focusButton.frame = CGRectMake(ScreenWidth-70, CGRectGetMinY(_designerNameLabel.frame), 50, 20);
        [_focusButton setTitle:@"关注" forState:UIControlStateNormal];
    }
    [_focusButton.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_focusButton) atIndex:0];
    _focusButton.layer.masksToBounds = YES;
    _focusButton.layer.cornerRadius = 2;
}

#pragma mark 改变热点FocusButton状态
-(void)setupCaseDesginerFocusState{
    
    if (_focusType == FocusTypeFocus) {
        
        _caseDesignerFocusButton.frame = CGRectMake(ScreenWidth-85, 0, 65, 20);
        [_caseDesignerFocusButton setTitle:@"取消关注" forState:UIControlStateNormal];
    }else {
        
        _caseDesignerFocusButton.frame = CGRectMake(ScreenWidth-70, 0, 50, 20);
        [_caseDesignerFocusButton setTitle:@"关注" forState:UIControlStateNormal];
    }
    [_caseDesignerFocusButton.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_caseDesignerFocusButton) atIndex:0];
    _caseDesignerFocusButton.layer.masksToBounds = YES;
    _caseDesignerFocusButton.layer.cornerRadius = 2;
    _caseDesignerFocusButton.centerY = _caseDesignerIcon.centerY;
}

- (IBAction)focus:(UIButton *)sender {
    
    [[UserManager shareUserManager]focusOnUserWithUserId:_productDetail.product.user_id focusType:_focusType];
    [UserManager shareUserManager].focusOnUserSuccess = ^ (id obj){
        
        _focusType = !_focusType;
        if (_focusType == FocusTypeFocus) {
            
            [[Global sharedSingleton]showToastInCenter:self.view withMessage:@"关注成功"];
        } else {
            
            [[Global sharedSingleton]showToastInCenter:self.view withMessage:@"已取消关注"];
        }
        
        [self setupFocusState];
    };
}

- (IBAction)price:(UIButton *)sender {
    
    if ([[UserManager shareUserManager]crrentUserInfomation] == nil) {
        
        [self showToastWithMessage:@"登陆后才可以使用功能"];
    } else {
        
        if ([sender.titleLabel.text isEqualToString:@"在线咨询"]) {
            
            if ([[UserManager shareUserManager]crrentUserId] != _caseDetail.designer_info.user_id) {
                DirectMessagesViewController *vc = [[DirectMessagesViewController alloc]init];
                vc.otherUser_id = [NSString stringWithFormat:@"%@", _caseDetail.designer_info.user_id];
                vc.otherUser_name = _caseDetail.designer_info.nickname;
                [UIManager pushVC:vc];
            } else {
                [self showToastWithMessage:@"该作品是您自己的"];
            }
        } else {
            
            [UIManager payProductViewControllerWithProductDetail:_productDetail];
        }
    }
}

- (IBAction)company:(UIButton *)sender {
    
    if ([[UserManager shareUserManager]crrentUserInfomation] == nil) {
        
        [self showToastWithMessage:@"登陆后才可以使用功能"];
    } else{
        if ([sender.titleLabel.text isEqualToString:@"立即定制"] ) {
        
            if ( [[UserManager shareUserManager] crrentUserType] == UserTypeEnterprise) {
                
                [UIManager customRequirementsReleaseViewControllerWithDemandAddType:DemandAddTypeOnProduct demandType:DemandTypeDirectional demand_id:nil desginerId:_caseDetail.designer_info.user_id productId:_caseDetail.info.id];
                
            } else {
                
                [self showToastWithMessage:@"非企业用户不能定制"];
            }
        }else {
            
            if ([[UserManager shareUserManager] crrentUserType] == UserTypeEnterprise) {
                
                [self showToastWithMessage:@"功能暂未开放"];
            } else if ([[UserManager shareUserManager] crrentUserType] == UserTypeDesigner  || [[UserManager shareUserManager] crrentUserType] == UserTypeMarketing){
                
                [self showToastWithMessage:@"仅限企业用户免费使用"];
            } else{
                
                [UIManager  showVC:@"CompanySigningViewController"];
                //            [self showToastWithMessage:@"功能暂未开放"];
            }
        }

    }
}

-(void)hiddenOpraitionButtonWithIsHidden:(BOOL)isHidden{
    
    _companyButoon.hidden = isHidden;
    _pricebutton.hidden = isHidden;
}


@end
