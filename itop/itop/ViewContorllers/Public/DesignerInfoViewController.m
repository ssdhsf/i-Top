//
//  DesignerInfoViewController.m
//  itop
//
//  Created by huangli on 2018/1/29.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DesignerInfoViewController.h"
#import "DesignerInfoHeaderView.h"
#import "H5ListStore.h"
#import "H5ListDataSource.h"
#import "H5ListCollectionViewCell.h"
#import "DirectMessagesViewController.h"
#import "InfomationStore.h"

#define HEADER_TEXTHIGHT 13
#define HEADER_TEXTWIDTH 100
#define HEADER_TETILTEXTWIDTH 40
#define HEADER_TITLETEXT_Y ScreenWidth *0.285-42
#define HEADER_CONTENTTEXT_Y ScreenWidth *0.285-20

static NSString *const H5ListCellIdentifier = @"H5List";

@interface DesignerInfoViewController ()

@property (nonatomic, strong)UIImageView *iconImage;
@property (nonatomic, strong)UIButton *backButton;
@property (nonatomic, strong)UILabel *workNumberTitleLabel;
@property (nonatomic, strong)UILabel *workNumberLabel;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *introductionLabel;
@property (nonatomic, strong)UILabel *salesTitleLabel;
@property (nonatomic, strong)UILabel *salesLabel;
@property (nonatomic, strong)UILabel *fansTitleLabel;
@property (nonatomic, strong)UILabel *fansLabel;
@property (nonatomic, strong)UIButton *focusButton;
@property (nonatomic, strong)UIButton *massageButton;
@property (nonatomic, strong)H5ListDataSource *h5ListDataSource;
@property (nonatomic, strong)DesignerInfo *designerInfo;
@property (nonatomic, assign)FocusType focusType;

@property (nonatomic, assign)BOOL isOperation;//是否操作关注

@property (nonatomic, strong)UIImageView *provinceIcon;
@property (nonatomic, strong)UILabel *province;

@property (nonatomic, assign)NSInteger introductionLabelHeight; //简介高度

@end

@implementation DesignerInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:YES];
}

-(void)initView{
    
    [super initView];
    [self addHeaderSubViews];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    [self initCollectionViewWithFrame:ControllerViewFrame(0, 260, ScreenWidth, ScreenHeigh-260) flowLayout:layout];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(ScreenWidth *0.285-(80/2)+80+8+16+8+_introductionLabelHeight+8+17+16+28);
    }];
    [self steupCollectionView];
}

-(void)initData{
    
    [super initData];
    [self refreshData];
    _isOperation = NO;
}

-(void)refreshData{
    
    [[UserManager shareUserManager]designerDetailWithDesigner:_desginer_id];
    [UserManager shareUserManager].designerDetailSuccess = ^(id obj){
        
        _designerInfo = [[DesignerInfo alloc]initWithDictionary:obj error:nil];
        [self setSubViewsValue];
        [self showRefresh];
        self.page_no = 1;
        [[UserManager shareUserManager] designerProductListWithDesigner:_desginer_id PageIndex:self.page_no PageCount:10];
        [UserManager shareUserManager].designerProductListSuccess = ^(NSArray * obj){
          
            if (obj.count == 0) {
                self.originY = 230;
            }

            [self listDataWithListArray:[[H5ListStore shearH5ListStore]configurationMenuWithMenu:obj] page:self.page_no];
            
        };
        
        [UserManager shareUserManager].errorFailure = ^(id obj){
            
            [self collectionEndRefreshing];
        };

    };

}

-(void)steupCollectionView{
    
    CollectionViewCellConfigureBlock congfigureBlock = ^(H5ListCollectionViewCell *cell , H5List *item, NSIndexPath *indexPath){
        
        [cell setH5LietItmeOfModel:item];
        
    };
    
    CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock = ^(UICollectionReusableView *headerView, NSIndexPath *indexPath){
        
        // headerView
        
    };
    self.h5ListDataSource = [[H5ListDataSource alloc]initWithItems:self.dataArray cellIdentifier:H5ListCellIdentifier headerIdentifier:nil
                                                cellConfigureBlock:congfigureBlock
                                      cellHeaderConfigureCellBlock:cellHeaderConfigureCellBlock
                             ];
    [self steupCollectionViewWithDataSource:self.h5ListDataSource
                             cellIdentifier:H5ListCellIdentifier
                                    nibName:@"H5ListCollectionViewCell"];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((ScreenWidth-20)/3, ((ScreenWidth-20)/3-20)*1.69+32+5+5+7+9);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake((ScreenWidth-20), 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    

    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    H5List *h5 = [_h5ListDataSource itemAtIndexPath:indexPath];
    [UIManager pushTemplateDetailViewControllerWithTemplateId:h5.id productType:H5ProductTypeDefault];
}

-(void)addHeaderSubViews{
  
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth *0.285)];
    [self.view addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(108);
    }];

    [bgView.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(bgView)];
/*-------------------*/
    
    UIView *iconBgView = [UIView new];
    [self.view addSubview:iconBgView];
    
    [iconBgView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(108-(85/2)-10);
        make.width.height.mas_equalTo(85);

    }];
    iconBgView.backgroundColor = [UIColor whiteColor];
    iconBgView.layer.masksToBounds = YES;
    iconBgView.layer.cornerRadius = 85/2;

/*---------头像----------*/

    self.iconImage = [UIImageView new];
    [self.view addSubview:_iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(108-(80/2)-10);
        make.width.height.mas_equalTo(80);
    }];
    self.iconImage.layer.masksToBounds = YES;
    self.iconImage.layer.cornerRadius = 80/2;
/*---------姓名----------*/
    
    self.nameLabel = [UILabel new];
//    CGFloat nameHeight = [[Global sharedSingleton]widthForString:_designerInfo.nickname fontSize:12 andHeight:16];
    [self.view addSubview:_nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(108-(80/2)+80+8);
        make.width.mas_equalTo(ScreenWidth/2 - 20);
        make.height.mas_equalTo(16);
    }];
    
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    
/*---------城市----------*/
    
    _provinceIcon = [UIImageView new];
    [self.view addSubview:_provinceIcon];
    [self.provinceIcon mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(ScreenWidth/2 + 10);
        make.top.mas_equalTo(108-(80/2)+80+8);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    _province = [UILabel new];
    [self.view addSubview:_province];
    [self.province mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(ScreenWidth/2 + 30);
        make.top.mas_equalTo(108-(80/2)+80+8);
        make.width.mas_equalTo(ScreenWidth - (ScreenWidth/2 + 45));
        make.height.mas_equalTo(16);
    }];
    self.province.font = [UIFont systemFontOfSize:12];
    self.province.textAlignment = NSTextAlignmentLeft;
/*--------介绍-----------*/
    
    self.introductionLabel = [UILabel new];
    [self.view addSubview:_introductionLabel];
    _introductionLabelHeight =  [Global heightWithString:_designerInfo.field width:ScreenWidth-100 fontSize:9];
    [self.introductionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(108-(80/2)+80+8+16+8);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(_introductionLabelHeight+5);
       
    }];
    self.introductionLabel.font = [UIFont systemFontOfSize:9];
    self.introductionLabel.textAlignment = NSTextAlignmentCenter;
    self.introductionLabel.numberOfLines = 0;
/*---------返回----------*/
    
    _backButton = [UIButton new];
    [self.view addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(40);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    [_backButton setImage:[UIImage imageNamed:@"home_icon_backwhite"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    NSLog(@"%f",ScreenWidth *0.285);
/*---------作品数量----------*/
    _workNumberTitleLabel = [UILabel new];
    [self.view addSubview:_workNumberTitleLabel];
    [_workNumberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(ScreenWidth/2 - 42.5-40-40);
        make.top.mas_equalTo(HEADER_TITLETEXT_Y);
        make.width.mas_equalTo(HEADER_TETILTEXTWIDTH);
        make.height.mas_equalTo(HEADER_TEXTHIGHT);
    }];
    _workNumberTitleLabel .text = @"作品";
    _workNumberTitleLabel.textAlignment = NSTextAlignmentCenter;
    _workNumberTitleLabel.font = [UIFont systemFontOfSize:9];
    _workNumberTitleLabel.textColor = [UIColor whiteColor];
    
    _workNumberLabel = [UILabel new];
    [self.view addSubview:_workNumberLabel];
    [_workNumberLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(ScreenWidth/2 - 42.5-40-40);
        make.top.mas_equalTo(HEADER_CONTENTTEXT_Y);
        make.width.mas_equalTo(HEADER_TETILTEXTWIDTH);
        make.height.mas_equalTo(HEADER_TEXTHIGHT);
    }];
    _workNumberLabel.textAlignment = NSTextAlignmentCenter;
    _workNumberLabel.textColor = [UIColor whiteColor];
    _workNumberLabel.font = [UIFont systemFontOfSize:9];
    
/*-------------------*/
    _salesTitleLabel = [UILabel new];
    [self.view addSubview:_salesTitleLabel];
    [_salesTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(ScreenWidth/2 - 42.5-40);
        make.top.mas_equalTo(HEADER_TITLETEXT_Y);
        make.width.mas_equalTo(HEADER_TETILTEXTWIDTH);
        make.height.mas_equalTo(HEADER_TEXTHIGHT);
    }];

    _salesTitleLabel.text = @"销量";
    _salesTitleLabel.textAlignment = NSTextAlignmentCenter;
    _salesTitleLabel.font = [UIFont systemFontOfSize:9];
    _salesTitleLabel.textColor = [UIColor whiteColor];
    
    _salesLabel = [UILabel new];
    [self.view addSubview:_salesLabel];
    [_salesLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(ScreenWidth/2 - 42.5-40);
        make.top.mas_equalTo(HEADER_CONTENTTEXT_Y);
        make.width.mas_equalTo(HEADER_TETILTEXTWIDTH);
        make.height.mas_equalTo(HEADER_TEXTHIGHT);
    }];
    _salesLabel.textAlignment = NSTextAlignmentCenter;
    _salesLabel.textColor = [UIColor whiteColor];
    _salesLabel.font = [UIFont systemFontOfSize:9];
/*-------------------*/
    
    _fansTitleLabel = [UILabel new];
    [self.view addSubview:_fansTitleLabel];
    [_fansTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(ScreenWidth-(ScreenWidth/4+HEADER_TETILTEXTWIDTH/2));
        make.top.mas_equalTo(HEADER_TITLETEXT_Y);
        make.width.mas_equalTo(HEADER_TETILTEXTWIDTH);
        make.height.mas_equalTo(HEADER_TEXTHIGHT);
    }];
   
    _fansTitleLabel.text = @"粉丝";
    _fansTitleLabel.textAlignment = NSTextAlignmentCenter;
    _fansTitleLabel.textColor = [UIColor whiteColor];
    _fansTitleLabel.font = [UIFont systemFontOfSize:9];

/*-------------------*/
    _fansLabel = [UILabel new];
    [self.view addSubview:_fansLabel];
    [_fansLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(ScreenWidth-(ScreenWidth/4+HEADER_TETILTEXTWIDTH/2));
        make.top.mas_equalTo(HEADER_CONTENTTEXT_Y);
        make.width.mas_equalTo(HEADER_TETILTEXTWIDTH);
        make.height.mas_equalTo(HEADER_TEXTHIGHT);
    }];
    _fansLabel.textAlignment = NSTextAlignmentCenter;
    _fansLabel.textColor = [UIColor whiteColor];
    _fansLabel.font = [UIFont systemFontOfSize:9];
/*-------------------*/

    _focusButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-60, 180, 40, 16)];
    [self.view addSubview:_focusButton];
    [_focusButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(ScreenWidth/2-70);
        make.top.mas_equalTo(ScreenWidth *0.285-(80/2)+80+8+16+8+_introductionLabelHeight+8+17);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(HEADER_TEXTHIGHT);
    }];
    [_focusButton addTarget:self action:@selector(focus) forControlEvents:UIControlEventTouchDown];
     [_focusButton.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_focusButton) atIndex:0];
    _focusButton.layer.masksToBounds = YES;
    _focusButton.layer.cornerRadius = 2;
    [_focusButton setTitle:@"关注" forState:UIControlStateNormal];
    _focusButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
/*-------------------*/
    _massageButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2+20, 180, 40, HEADER_TEXTHIGHT)];
    [self.view addSubview:_massageButton];
    [_massageButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(ScreenWidth/2+20);
        make.top.mas_equalTo(ScreenWidth *0.285-(80/2)+80+8+16+8+_introductionLabelHeight+8+17);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(HEADER_TEXTHIGHT);
    }];
    [_massageButton addTarget:self action:@selector(message) forControlEvents:UIControlEventTouchDown];
    [_massageButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_massageButton)];
    [_massageButton setTitle:@"私信" forState:UIControlStateNormal];
    _massageButton.layer.masksToBounds = YES;
    _massageButton.layer.cornerRadius = 2;
    _massageButton.titleLabel.font = [UIFont systemFontOfSize:10];
}

-(void)setSubViewsValue{
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:_designerInfo.head_img] placeholderImage:PlaceholderImage];
    self.nameLabel.text = _designerInfo.nickname;
    self.introductionLabel.text = _designerInfo.field;
    _workNumberLabel.text = _designerInfo.follow_total;
    _salesLabel.text = _designerInfo.sale_total;
    _fansLabel.text = _designerInfo.fans_total;
    _focusType = [_designerInfo.follow integerValue];
    [self setupFocusState];
    self.provinceIcon.image = [UIImage imageNamed:@"hot_icon_location"];
    self.province.text = @"广州市";
}

#pragma mark 改变热点FocusButton状态
-(void)setupFocusState{
    
    if (_focusType == FocusTypeFocus) {
        
        [_focusButton setTitle:@"取消关注" forState:UIControlStateNormal];
    }else {

        [_focusButton setTitle:@"关注" forState:UIControlStateNormal];
    }
    [_focusButton.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_focusButton) atIndex:0];
    _focusButton.layer.masksToBounds = YES;
    _focusButton.layer.cornerRadius = 2;
}

-(void)message{
    
    UserModel *model = [[UserManager shareUserManager]crrentUserInfomation];
    NSString *vison = [[InfomationStore shearInfomationStore]userVersionWithVersion:model.other_info.version];
    if ([vison isEqualToString:@"蓝钻版"] || [vison isEqualToString:@"黑钻版"] ) {
        
        DirectMessagesViewController *vc = [[DirectMessagesViewController alloc]init];
        vc.otherUser_id = [NSString stringWithFormat:@"%@", _designerInfo.user_id];
        vc.otherUser_name = _designerInfo.nickname;
        [UIManager pushVC:vc];
    } else {
        
        [self showToastWithMessage:@"会员等级不足,无法私信"];
    }
}

-(void)focus{
    
    [[UserManager shareUserManager]focusOnUserWithUserId:[NSString stringWithFormat:@"%@",_designerInfo.user_id] focusType:_focusType];
    [UserManager shareUserManager].focusOnUserSuccess = ^ (id obj){
        
        _focusType = !_focusType;
        if (_focusType == FocusTypeFocus) {
            
            [[Global sharedSingleton]showToastInCenter:self.view withMessage:@"关注成功"];
        } else {
            
            [[Global sharedSingleton]showToastInCenter:self.view withMessage:@"已取消关注"];
        }
        
        [self setupFocusState];
        _isOperation = YES;
    };
}

-(void)back{
   
    if (_isOperation) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:Notification_CHANGE_FOCUS_DESGINER object:nil userInfo:nil];
    }
    [super back];
}

//DirectMessagesViewController *vc = [[DirectMessagesViewController alloc]init];
//vc.otherUser_id = message.user_id;
//vc.otherUser_name = message.nickname;
//[UIManager pushVC:vc];

@end
