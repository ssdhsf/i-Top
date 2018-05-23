//
//  HomeViewController.m
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HomeViewController.h"
#import "Constant.h"
#import "CarouselScrollView.h"
#import "HomeStore.h"
#import "HomeDataSource.h"
#import "DesignerListViewCollectionViewCell.h"
#import "H5ListCollectionViewCell.h"
#import "HomeCollectionViewCell.h"
#import "HomeSectionHeaderView.h"
#import "HomeHeaderView.h"
#import "DesignerListViewController.h"
#import "H5ListStore.h"
#import "DesignerListStore.h"
#import "H5ListViewController.h"
#import "DesignerInfoViewController.h"
#import "TemplateDetaulViewController.h"
#import "MapLocationManager.h"
#import "CustomRequirementsStore.h"
#import "EditCaseStore.h"

#define NAVBAR_CHANGE_POINT 50

#define NAVBAR_HIDDEN_YES kDevice_Is_iPhoneX ? -44 : -20
#define NAVBAR_HIDDEN_NO kDevice_Is_iPhoneX ? -88 : -64

#define NAVBAR_HIDDEN_YES_SETUPSTART kDevice_Is_iPhoneX ? 44 : 20
#define NAVBAR_HIDDEN_NO_SETUPSTART kDevice_Is_iPhoneX ? 88 : 64


static NSString *const HomeCellIdentifier = @"Home";
static NSString *const H5ListCellIdentifier = @"H5List";
static NSString *const DesignerListCellIdentifier = @"DesignerList";

@interface HomeViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong)BMKLocationManager *locationManager;
@property (nonatomic, strong)CarouselScrollView *bannerView;//轮播图
@property (nonatomic, strong)CarouselScrollView *h5bannerView;　//推荐H5
@property (nonatomic, strong)CarouselScrollView *designerbannerView;//设计师
@property (nonatomic, strong)CarouselScrollView *tagbannerView;//tag
@property (nonatomic, strong)HomeDataSource *homeDataSource;
@property (nonatomic, strong)CarouselScrollView *custrombannerView;// 定制需求
@property (nonatomic, strong)CarouselScrollView *casebannerView;//精品案例

@property (nonatomic, strong) UIView *navBgView;
@property (nonatomic, strong) UIButton *loctionBtn;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UILabel *loctionLable;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) CAGradientLayer *layer;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, assign) BOOL isSelectProvince;
@property (nonatomic, strong) City *selectProvince;

@property (nonatomic, assign) NSInteger requstCount;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [UIManager appDelegate].tabBarController.delegate = self;
    [self registeredpushNotification];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshDesginerListData:) name:Notification_CHANGE_FOCUS_DESGINER object:nil];
//    [WXApiManager sharedManager].delegate = self;
}

-(void)refreshDesginerListData:(NSNotificationCenter*)notifi{
    
    [self loadingDesignerListWithIsNotification:YES];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    if (_bannerView) {
        [_bannerView initTimer];
    }
    //取消导航栏最下面的那一条线
    [self hiddenNavigationController:NO];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"white_7"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES;
    [self setNavBar];
    if (self.collectionView) {
//        [self.navigationController setNavigationBarHidden:YES animated:NO];
        CGFloat offsetY = self.collectionView.contentOffset.y ;
        NSLog(@"%lf",offsetY);
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self haveHiddenAnimationWithAlpha:alpha
                       navigationBarHidden:NO
                                   offsetY:offsetY];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    if (_bannerView) {
        [_bannerView stopTimer];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    [self.navBgView removeFromSuperview];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    [self setLeftCustomBarItem:@"" action:nil];
}

-(void)initView{
    
    [super initView];
    [self initCarouselScrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initCollectionView];
    [self collectionBeginRefreshing];
    [self.collectionView reloadData];
    self.collectionView.scrollEnabled = YES;
    [self haveHiddenAnimationWithAlpha:0 navigationBarHidden:NO offsetY:0];
}

-(void)initData{
    
    [super initData];
    [self NSNotificationCenter];
    _isFirst = YES;
    _isSelectProvince = NO;
    for (int i = 0; i < 8; i ++) {
        
        Home *home = [[Home alloc]init];
        home.itemKey = [[HomeStore shearHomeStore]sectionTypeWithSection:i];
        home.itemArray = [NSArray array];
        home.itemHeader = [[HomeStore shearHomeStore]headerTitleWithSection:i];
        [self.dataArray addObject: home];
    }
}

-(void)refreshData{

    self.collectionView.scrollEnabled =NO;
    _requstCount = 0;
    
    [self loadHomeBanner]; //加载轮播图
    [self loadingTagList]; //加载标签
    [self loadingCustomRequirementsList]; //加载定制需求
    [self loadingCaseList]; //加载精品案例
    [self loadingRecommendedH5List]; //加载 推荐H5
    [self loadingDesignerListWithIsNotification:NO]; //加载设计师
    [self loadingScenarioH5List]; //加载场景H5
    [self loadingOnePageH5List]; //加载一页H5
    [self loadingVideoH5List]; //加载视频H5
    [UserManager shareUserManager].errorFailure = ^(id obj){
        
        [self collectionEndRefreshing];
        self.collectionView.scrollEnabled = YES;
    };
}

-(void)updataSectionWithSectionArray:(NSArray *)sectionDataArray index:(NSInteger)index{
    
    Home *home = self.dataArray[index];
    home.itemArray = sectionDataArray;
    [self.dataArray replaceObjectAtIndex:index withObject:home];
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:index]];
    _requstCount ++;
    
    if (_requstCount == 8) {
        
        [self collectionEndRefreshing];
        self.collectionView.scrollEnabled = YES;
    }
}

-(void)loadHomeBanner{
   
    [[UserManager shareUserManager] homeBanner];
    [UserManager shareUserManager].homeBannerSuccess  = ^(NSArray * arr){
        
        NSLog(@"%@",arr);
        _bannerView.imageURLArray = [[HomeStore shearHomeStore]configurationBanner:arr];
        [_bannerView createAutoCarouselScrollView];
    };
}

-(void)loadingTagList{
    
    [[UserManager shareUserManager] homeProductTagListWithType:@58];
    [UserManager shareUserManager] .homeTagListSuccess = ^(NSArray *arr){
       
       NSArray *itemArray = [[HomeStore shearHomeStore]configurationTag:arr];
        [self updataSectionWithSectionArray:itemArray index:0];
    };
}

-(void)loadingCustomRequirementsList{
    
    [[UserManager shareUserManager]customRequirementsListWithUserId:nil PageIndex:1 PageCount:3];
    [UserManager shareUserManager].customRequirementsSuccess = ^ (NSArray *arr){
        
        NSArray* itemArray =[[CustomRequirementsStore shearCustomRequirementsStore] configurationCustomRequirementsWithRequsData:arr];
        [self updataSectionWithSectionArray:itemArray index:1];
    };
}

-(void)loadingCaseList{
    
    [[UserManager shareUserManager]myCaseListWithPageIndex:self.page_no PageCount:10 getCaseType:GetCaseTypeHome userId:nil isShow:YES];
    [UserManager shareUserManager].myCaseListSuccess = ^(NSArray * arr){
        
        NSArray* itemArray = [[EditCaseStore shearEditCaseStore] configurationEditCaseStoreWithRequsData:arr];
        [self updataSectionWithSectionArray:itemArray index:2];
    };
}

-(void)loadingRecommendedH5List{
    
    [[UserManager shareUserManager]homeH5ListWithType:H5ProductTypeNoel PageIndex:1 PageCount:10 tagList:nil searchKey:nil isShow:YES];
}

-(void)loadingDesignerListWithIsNotification:(BOOL)isNotification{
    
    [[UserManager shareUserManager]designerlistWithPageIndex:1 PageCount:10 designerListType:DesignerListTypeHome searchKey:nil];
    [UserManager shareUserManager].designerlistSuccess = ^(NSArray * arr){
        
       NSArray *itemArray = [[DesignerListStore shearDesignerListStore]configurationMenuWithMenu:arr];
        [self updataSectionWithSectionArray:itemArray index:4];
    };
}

-(void)loadingScenarioH5List{
    
    [[UserManager shareUserManager]homeH5ListWithType:H5ProductTypeScenario PageIndex:1 PageCount:3 tagList:nil searchKey:nil isShow:YES];
}

-(void)loadingOnePageH5List{
    
    [[UserManager shareUserManager]homeH5ListWithType:H5ProductTypeSinglePage PageIndex:1 PageCount:3 tagList:nil searchKey:nil isShow:YES];

}

-(void)loadingVideoH5List{
    
    [[UserManager shareUserManager]homeH5ListWithType:H5ProductTypeVideo PageIndex:1 PageCount:3 tagList:nil searchKey:nil isShow:YES];
    [UserManager shareUserManager].homeH5ListSuccess = ^ (NSArray *arr, NSNumber *type){
        
        NSArray* itemArray =[[H5ListStore shearH5ListStore] configurationMenuWithMenu:arr];
        
        NSInteger index ;
        switch ([type integerValue]) {
            case H5ProductTypeNoel:
                
                index = 3;
                break;
            case H5ProductTypeScenario:
                
                index = 5;
                break;
            case H5ProductTypeSinglePage:
                
                index = 6;
                break;
            case H5ProductTypeVideo:
                
                index = 7;
                break;
                
            default:
                break;
        }
        [self updataSectionWithSectionArray:itemArray index:index];
    };
}

-(void)initCarouselScrollView{
    
    _bannerView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/2.1) placeHolderImage:nil imageURLs: [[HomeStore shearHomeStore]configurationBanner:nil] imageDidSelectedBlock:^(NSInteger selectedIndex) {

            NSLog(@"你选择了第%ld张图片",selectedIndex);
    }];
    _bannerView.tag = 0 ;
}

-(void)initCollectionView{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    [self initCollectionViewWithFrame:ControllerViewFrame(0, 0, ViewWidth, ViewHeigh) flowLayout:layout];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(kDevice_Is_iPhoneX ? -83 : -49);
        make.top.mas_equalTo(kDevice_Is_iPhoneX ? -88 : -64);
    }];
    
    [self steupCollectionView];
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(collectionViewDidTriggerHeaderRefresh)];
}

-(void)steupCollectionView{
    
    __weak typeof(self) weakSelf = self;
    CollectionViewCellConfigureBlock congfigureBlock = ^(id cell , id item, NSIndexPath *indexPath){
        
        if (indexPath.section == 0) {
            UICollectionViewCell *newCell = cell;
            
            for (UIView *view in newCell.subviews) {
                
                if ([view isKindOfClass: [CarouselScrollView class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            _tagbannerView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, newCell.height) placeHolderImage:nil imageURLs:(NSArray *)item imageDidSelectedBlock:^(NSInteger selectedIndex) {
                
                NSLog(@"你选择了第%ld张图片",selectedIndex);
                
            }];
            
            _tagbannerView.tagDidScrolledBlock = ^(NSInteger indx){

                [[Global sharedSingleton]showToastInTop:weakSelf.view withMessage:[NSString stringWithFormat:@"选择了第%ldtag",(long)indx]];
                 Home *home = weakSelf.dataArray[indexPath.section];
                 TagList*tag = home.itemArray[indx];
                 [weakSelf loadinH5ListWithH5Type:GetH5ListTypeTag index:[tag.tag_type integerValue] title:tag.name];
                 NSLog(@"%ld",(long)indx);

            };
            _tagbannerView.tag = 1;
            [_tagbannerView createTagScrollView];
            [newCell addSubview:_tagbannerView];
            
        } else if (indexPath.section == 1){
            
            UICollectionViewCell *newCell = cell;
            
            for (UIView *view in newCell.subviews) {
                
                if ([view isKindOfClass: [CarouselScrollView class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            _custrombannerView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, newCell.height) placeHolderImage:nil imageURLs:(NSArray *)item imageDidSelectedBlock:^(NSInteger selectedIndex) {
                
                Home *home = self.dataArray[indexPath.section];
                CustomRequirements *custom = home.itemArray[selectedIndex];
                 [UIManager customRequirementsDetailViewControllerWithCustomId:custom.id];
//                [UIManager pushTemplateDetailViewControllerWithTemplateId:list.id];
                //                NSLog(@"你选择第%ld张图片",selectedIndex);
                
            }];
            _custrombannerView.tag = 2;
            [_custrombannerView createCustromScrollView];
            [newCell addSubview:_custrombannerView];
            
        } else if (indexPath.section == 2){
            
            UICollectionViewCell *newCell = cell;
            
            for (UIView *view in newCell.subviews) {
                
                if ([view isKindOfClass: [CarouselScrollView class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            _casebannerView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, newCell.height) placeHolderImage:nil imageURLs:(NSArray *)item imageDidSelectedBlock:^(NSInteger selectedIndex) {
                
                Home *home = self.dataArray[indexPath.section];
                EditCase *editCase = home.itemArray[selectedIndex];
                [UIManager pushTemplateDetailViewControllerWithTemplateId:editCase.id productType:H5ProductTypeCase];
                
            }];
            _casebannerView.tag = 3;
            [_casebannerView createTopScrollViewWithType:H5ProductTypeCase];
            [newCell addSubview:_casebannerView];
            
        }else if (indexPath.section == 3) {

            UICollectionViewCell *newCell = cell;
            
            for (UIView *view in newCell.subviews) {
                
                if ([view isKindOfClass: [CarouselScrollView class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            _h5bannerView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, newCell.height) placeHolderImage:nil imageURLs:(NSArray *)item imageDidSelectedBlock:^(NSInteger selectedIndex) {
                
                Home *home = self.dataArray[indexPath.section];
                H5List *list = home.itemArray[selectedIndex];
                [UIManager pushTemplateDetailViewControllerWithTemplateId:list.id productType:H5ProductTypeDefault];
//                NSLog(@"你选择第%ld张图片",selectedIndex);

            }];
            _h5bannerView.tag = 4;
            [_h5bannerView createTopScrollViewWithType:H5ProductTypeDefault];
            [newCell addSubview:_h5bannerView];
        } else if (indexPath.section == 4){
            
            UICollectionViewCell *newCell = cell;
            for (UIView *view in newCell.subviews) {
                
                if ([view isKindOfClass: [CarouselScrollView class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            _designerbannerView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, newCell.height) placeHolderImage:nil imageURLs:(NSArray *)item imageDidSelectedBlock:^(NSInteger selectedIndex) {
                
                Home *home = self.dataArray[indexPath.section];
                DesignerList *designer = home.itemArray[selectedIndex];
                [UIManager designerDetailWithDesignerId:designer.id];
            }];
            [_designerbannerView createdesignerScrollView];
            [newCell addSubview:_designerbannerView];
            _designerbannerView.tag = 5;
            
        } else  if (indexPath.section > 4) {
          
            [cell setItmeOfModel:item];
        }
    };
    
    CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock = ^(UICollectionReusableView *headerView, NSIndexPath *indexPath){  //透视图
        
        Home *home = [_homeDataSource itemAtIndexPath:indexPath.section];
        if (indexPath.section == 0) {
            
            [headerView addSubview: _bannerView];
        } else {
            for (UIView *view in headerView.subviews) {
                
                if ([view isKindOfClass: [HomeSectionHeaderView class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            HomeSectionHeaderView *infView = [[HomeSectionHeaderView alloc] init];
            infView.frame = headerView.bounds;
            [infView initSubViewsWithSection:indexPath.section];
            infView.sectionHeader = ^(NSInteger section){
                
                if (section == 1) {

                    [UIManager customRequirementsViewController];
                    
                }else if (section == 2) {
                    
                    [UIManager getCaseViewControllerWithGetCaseType:GetCaseTypeHome];
                    
                }else if (section == 4) {
                    
                    [UIManager designerListWithDesignerListType:DesignerListTypeHome searchKey:nil];
                    
                }else {
                    
                    [self loadinH5ListWithH5Type:GetH5ListTypeProduct index:section title:home.itemHeader];
                }
            };
            infView.titleLbl.text = home.itemHeader;
            infView.backgroundColor = UIColor.whiteColor;

            [headerView addSubview:infView];
        }
        
    };
    self.homeDataSource = [[HomeDataSource alloc]initWithItems:self.dataArray cellIdentifier:HomeCellIdentifier headerIdentifier:nil
                                                          cellConfigureBlock:congfigureBlock
                                                cellHeaderConfigureCellBlock:cellHeaderConfigureCellBlock
                                  ];
    [self.collectionView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"H5ListCollectionViewCell"] forCellWithReuseIdentifier:H5ListCellIdentifier];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"DesignerListViewCollectionViewCell"] forCellWithReuseIdentifier:DesignerListCellIdentifier];
    [self.collectionView registerClass:[HomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self steupCollectionViewWithDataSource:self.homeDataSource
                             cellIdentifier:HomeCellIdentifier
                                    nibName:@"HomeCollectionViewCell"];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return  [self sizeForItemAtIndex:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGSizeMake(ScreenWidth, ScreenWidth/2.1+23);
    }
    return CGSizeMake(ScreenWidth, 57);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return [self minimumInteritemSpacingForSectionAtIndex:section];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section > 2) {
        
        Home *home = [_homeDataSource itemAtIndexPath:indexPath.section];
        H5List *h5 = home.itemArray[indexPath.row];
           [UIManager pushTemplateDetailViewControllerWithTemplateId:h5.id productType:H5ProductTypeDefault];
    }

    NSLog(@"23");
}

-(CGSize)sizeForItemAtIndex:(NSIndexPath *)indexPath{
    
    Home *home = [_homeDataSource itemAtIndexPath:indexPath.section];
    if (indexPath.section == 0) {
        
        CGFloat replenish = 0;
        
        if (ScreenWidth/3-102 < 23) {
           
            replenish = 20;
        }
        return CGSizeMake(ScreenWidth, (ScreenWidth/3-102+19+5+9+5+replenish)*2);
    }else if (indexPath.section == 1) {
        
        return CGSizeMake(ScreenWidth, 133);
    }else if (indexPath.section == 2 || indexPath.section == 3) {
        
        return CGSizeMake(ScreenWidth, (ScreenWidth/3-33)*1.7+32+5+5+7+9-17);
    }else if (indexPath.section == 4){
        
//        CGFloat workLabelHeight = 0;
//        for (DesignerInfo *designer in home.itemArray) {
//            
//            if ([Global heightWithString:designer.field width:ScreenWidth/3-40 fontSize:12] > workLabelHeight) {
//                workLabelHeight = [Global heightWithString:designer.field width:ScreenWidth/3-40 fontSize:12];
//            }
//        }
//        DesignerInfo *designer = home.itemArray[indexPath.row];
//        NSInteger workLabel = [Global heightWithString:designer.field width:ScreenWidth/3-40 fontSize:12];
        
        return CGSizeMake(ScreenWidth, (ScreenWidth/3-35)+5+18+5+8+16+5+32+16);

    }else{
        if ([home.itemKey isEqualToString:Type_H5]) {
            
            //        NSLog(@"%f",(ScreenWidth/3-33)*1.7+32+5+7+9+5);
            return CGSizeMake(ScreenWidth/3, (ScreenWidth/3-33)*1.7+32+5+5+7+9-17);
        } else if ([home.itemKey isEqualToString:Type_Home]){
            
            if ((ScreenWidth/3-102) < 22) {
                return CGSizeMake(ScreenWidth/3, 22+19+5+9+5);
            }else {
                return CGSizeMake(ScreenWidth/3, ScreenWidth/3-102+19+5+9+5);
            }
            
        }else {
            return CGSizeMake(ScreenWidth/3, ScreenWidth/3*1.5);
        }
    }
}

-(CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    CGFloat spaceX = 0;
    return spaceX;
}

- (void)NSNotificationCenter{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logoutView:)
                                                 name:Notification_LogoutView
                                               object:nil];//token失败
}

//登陆异常
- (void)logoutView:(NSNotification *)notification {
    
    [[UIManager sharedUIManager]LoginViewControllerWithLoginState:YES];
//    [[LoginMannager sheardLoginMannager]presentViewLoginViewController];
    [[LoginMannager sheardLoginMannager] clearLoginUserMassage];
    [[LoginMannager sheardLoginMannager] stopTimer];
    AppDelegate *app = ApplicationDelegate;
    app.tabBarController = nil;
    [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager] topViewController].view  withMessage:@"登录过期"];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:Notification_LogoutView object:nil];
}

- (void)setNavBar{
    
    UIView *navBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kDevice_Is_iPhoneX ? -44:-20, ScreenWidth, kDevice_Is_iPhoneX ?88:64)];
    [self.navigationController.navigationBar addSubview:navBgView];
    self.navBgView = navBgView;
    
    _layer = [CAGradientLayer layer];
    navBgView.backgroundColor = [UIColor clearColor];
    
    _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,kDevice_Is_iPhoneX ? 20+27: 27, 200 * KadapterW, 30)];
    _searchBtn.centerX = self.view.centerX;
    
    UIColor *color = [UIColor whiteColor];
    
    [_searchBtn setBackgroundColor:[color colorWithAlphaComponent:1.0]];
    _searchBtn.layer.masksToBounds = YES;
    _searchBtn.layer.cornerRadius = _searchBtn.frame.size.height/2;
    [_searchBtn setTitle:@"搜索感兴趣的H5/设计师/热点" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:9];
    [_searchBtn setImage:[UIImage imageNamed:@"search_icon_serch"] forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(homeSearch) forControlEvents:UIControlEventTouchDown];
    [navBgView addSubview:_searchBtn];
    
    //左面导航按钮
    UIButton *readerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loctionBtn = readerButton;
    readerButton.frame = CGRectMake(20, 0, 25 , 25 );
    self.loctionBtn.centerY = _searchBtn.centerY;

    self.loctionLable = [[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(self.loctionBtn.frame), kDevice_Is_iPhoneX ? 20+40:40, 35 , 16 )];
    self.loctionLable.font = [UIFont systemFontOfSize:9];
//    self.loctionLable .text = self.loctionString;
    [navBgView addSubview: self.loctionLable];
    [navBgView addSubview:self.loctionBtn];
    
    self.messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.messageBtn.frame = CGRectMake(ScreenWidth-20-19 , 0, 25 , 25 );
    self.messageBtn.centerY = _searchBtn.centerY;
    [self.messageBtn addTarget:self action:@selector(messageList) forControlEvents:UIControlEventTouchDown];
    
//    JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.messageBtn alignment:JSBadgeViewAlignmentTopRight];
//    badgeView.badgeTextFont = [UIFont systemFontOfSize:9];
//    badgeView.badgeText = @"12";
//    badgeView.size = CGSizeMake(10, 10);
    [navBgView addSubview:self.messageBtn];
    [self.loctionBtn setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
    [self.messageBtn setImage:[UIImage imageNamed:@"icon_remind"] forState:UIControlStateNormal];
    [self.loctionBtn addTarget:self action:@selector(selectLoction) forControlEvents:UIControlEventTouchDown];
    
    if (!_isSelectProvince) {
        if ([MapLocationManager sharedMapLocationManager].location == nil) {
            
            [[MapLocationManager sharedMapLocationManager] initMapLocation];
            [UserManager shareUserManager].mapLocationManagerSuccess = ^(NSString *loction){
                
                self.loctionLable .text = loction;
            };
            
            [UserManager shareUserManager].mapLocationManagerFailure = ^(NSError *error){
                
                [self showToastWithError:error];
            };
        } else {
            self.loctionLable .text = [MapLocationManager sharedMapLocationManager].location;
        }
    } else {
       
        self.loctionLable .text = _selectProvince.name;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y ;
    CGFloat compareOffsetY;
    CGFloat compareOffsetStart =  self.navigationController.isNavigationBarHidden ?
        (float)-NAVBAR_HIDDEN_YES : (float)-NAVBAR_HIDDEN_NO;
    NSLog(@"%lf",offsetY);
    
    if (offsetY > (float)NAVBAR_CHANGE_POINT) {
        CGFloat alpha  = MIN(1, 1 - ((float)NAVBAR_CHANGE_POINT + (float)NAVIGATION_HIGHT - offsetY) / (float)NAVIGATION_HIGHT);
#pragma mark HaveHiddenAnimation
        [self haveHiddenAnimationWithAlpha:alpha navigationBarHidden:NO offsetY:offsetY];
        
    } else if(offsetY < compareOffsetStart){
#pragma mark HaveHiddenAnimation
        
        [self haveHiddenAnimationWithAlpha:0 navigationBarHidden:YES offsetY:offsetY];
        
    } else {
#pragma mark HaveHiddenAnimation
        
        [self haveHiddenAnimationWithAlpha:0 navigationBarHidden:NO offsetY:offsetY];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //有nav时一开始的偏移量为-64，所以这里加上了64，如果是自定义nav则没有这种情况
//    stopPosition = ;
    NSLog(@"滑动停止:%f",scrollView.contentOffset.y);
}

-(void)haveHiddenAnimationWithAlpha:(CGFloat)alpha navigationBarHidden:(BOOL)animation offsetY:(NSInteger)offsetY{

    self.navBgView.hidden = animation;
//    [self.navigationController setNavigationBarHidden:animation animated:NO];
    if (offsetY < (float)NAVBAR_CHANGE_POINT) { //icon为黑色
        
        [self.loctionBtn setImage:[UIImage imageNamed:@"home_icon_locationblack"] forState:UIControlStateNormal];
        [self.messageBtn setImage:[UIImage imageNamed:@"home_icon_remindblack"] forState:UIControlStateNormal];
    } else {
        
        [self.loctionBtn setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
        [self.messageBtn setImage:[UIImage imageNamed:@"icon_remind"] forState:UIControlStateNormal];
    }
    
    _layer = [UIColor setGradualChangingColor:self.navBgView fromColor:@"FFA5EC" toColor:@"B499F8" alpha:alpha gradientLayer:_layer];
    [self.navBgView.layer insertSublayer:_layer atIndex:0];
}

-(void)messageList{
    
    if ([[UserManager shareUserManager]isLogin]) {
       
         [UIManager showVC:@"MessageViewController"];
    } else{
        
        [[UIManager sharedUIManager]LoginViewControllerWithLoginState:NO];
    }
}

-(void)loadinH5ListWithH5Type:(GetH5ListType)type index:(NSInteger)index title:(NSString *)title{
    
    H5ListViewController *h5Vc = [[H5ListViewController alloc]init];
    if (type == GetH5ListTypeTag) {
      
        h5Vc.tagList = @[title];
    } else {
        switch (index) {
            case 3:
                h5Vc.h5ProductType = H5ProductTypeNoel;
                break;
            case 5:
                h5Vc.h5ProductType = H5ProductTypeScenario;
                break;
            case 6:
                h5Vc.h5ProductType = H5ProductTypeSinglePage;
                break;
            case 7:
                h5Vc.h5ProductType = H5ProductTypeVideo;
                break;
            default:
                break;
        }
    }
    h5Vc.getH5ListType = type;
    h5Vc.titleStr = title;
    h5Vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:h5Vc animated:YES];
}

-(void)homeSearch{
    
    [UIManager showVC:@"SearchViewController"];
}

-(void)selectLoction{
    
    [UIManager showVC:@"ProvinceViewController"];
    [UIManager sharedUIManager].selectProvinceBackOffBolck = ^(City *city){
        
        _isSelectProvince = YES;
        _selectProvince = city;
    };
}

-(void)fontReceivePushNotificationAlert:(NSNotification *)notification{
    
    [self AlertOperation];
}

-(void)AlertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"收到i-Top推送消息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
//        [self back];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)backgroundReceiveClickPushNotificationAlert:(NSNotification *)notification{
    
}

//点击我的作品前 判断用户是否登陆
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    ThemeNavigationController *nav=(ThemeNavigationController*)viewController;
    BOOL isSelectProductItem =
    [nav.tabBarItem.title isEqualToString:@"我的推广"]||
    [nav.tabBarItem.title isEqualToString:@"我的作品"]||
    [nav.tabBarItem.title isEqualToString:@"推广管理"] ? YES : NO;
    if (![[UserManager shareUserManager]isLogin] && isSelectProductItem) {
        
        [[UIManager sharedUIManager]LoginViewControllerWithLoginState:NO];
        return NO;
    }
    
    return YES;
}


@end
