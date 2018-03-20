//
//  TemplateDetaulViewController.m
//  itop
//
//  Created by huangli on 2018/2/4.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "TemplateDetaulViewController.h"

@interface TemplateDetaulViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)ProductDetail *productDetail;
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)WebViewController *webVc;
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
@property (nonatomic, strong)DesignerInfo *designerInfo;



@property (weak, nonatomic) IBOutlet UIButton *pricebutton;


@end

@implementation TemplateDetaulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigafindHairlineImageView:YES];
}

-(void)initNavigationBarItems{
    
    self.title = @"模版详情";
}

-(void)initData{
    
    [super initData];
    [[UserManager shareUserManager]productDetailWithHotDetailId:_template_id];
    [UserManager shareUserManager].productDetailSuccess = ^(NSDictionary *dic){
        
        _productDetail = [[ProductDetail alloc]initWithDictionary:dic error:nil];
        _productDetail.product.descrip = dic[@"product"][@"description"];
        [self lodingDesignerInfomation];
    };
}

-(void)lodingDesignerInfomation{
    
    [[UserManager shareUserManager]designerDetailWithDesigner:_productDetail.product.user_id];
    [UserManager shareUserManager].designerDetailSuccess = ^(id obj){
        
        _designerInfo = [[DesignerInfo alloc]initWithDictionary:obj error:nil];
        [self createScrollView];
        [self setupDetailSubViewData];
    };
}

-(void)initView{
    
    [super initView];
}

-(void)createScrollView{
    
    if(_scroll){
        
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        [_scroll removeFromSuperview];
        _scroll = nil;
    }
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigh-109)];;
    [self.view addSubview:_scroll];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(2*ScreenWidth, ScreenHeigh-109);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    [self setupWebViewVc];
    [self setupDetailView];
}

-(void)setupWebViewVc{
    
    _webVc = [[WebViewController alloc]init];
    _webVc.h5Url = _productDetail.product.url;
    _webVc.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeigh-109);
    [_scroll addSubview:_webVc.view];
}

-(void)setupDetailView{
    
    _detailView.frame = CGRectMake(ScreenWidth,0 , ScreenWidth, ScreenHeigh-109);
    
    NSInteger introduceLabelHeight = [Global heightWithString:_productDetail.product.share_description width:ScreenWidth-50 fontSize:15];
    _introduceLabel.frame = CGRectMake(25, 157, ScreenWidth-50, introduceLabelHeight);
    _mutabelCountLabel.frame = CGRectMake(25, CGRectGetMaxY(_introduceLabel.frame)+40, ScreenWidth-50, 21);
    _imageCountLabel.frame = CGRectMake(25, CGRectGetMaxY(_mutabelCountLabel.frame)+25, ScreenWidth-50, 21);
    _desginerTiltleLabel.frame = CGRectMake(25, CGRectGetMaxY(_imageCountLabel.frame)+40, ScreenWidth-50, 21);
    _designerIcon.frame = CGRectMake(25, CGRectGetMaxY(_desginerTiltleLabel.frame)+25, 40, 40);
    
    _designerIcon.layer.masksToBounds = YES;
    _designerIcon.layer.cornerRadius = 20;
    
    _designerNameLabel.frame = CGRectMake(CGRectGetMaxX(_designerIcon.frame)+24, CGRectGetMaxY(_desginerTiltleLabel.frame)+25, ScreenWidth-160, 21);
    
    NSInteger designerIntroductionLabelHeight = [Global heightWithString:_productDetail.product.description width:ScreenWidth-110 fontSize:15];
    _designerIntroductionLabel.frame = CGRectMake(CGRectGetMaxX(_designerIcon.frame)+24, CGRectGetMaxY(_designerNameLabel.frame)+10, ScreenWidth-110, designerIntroductionLabelHeight);

    
    _focusType = [_designerInfo.follow integerValue];
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
    _designerIntroductionLabel.text = _designerInfo.field;
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
    [_focusButton.layer insertSublayer:[UIColor setGradualChangingColor:_focusButton fromColor:@"FFA5EC" toColor:@"DEA2FF"] atIndex:0];
    _focusButton.layer.masksToBounds = YES;
    _focusButton.layer.cornerRadius = 2;
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
}
- (IBAction)company:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
