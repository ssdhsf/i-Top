//
//  HomeViewController.m
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HomeViewController.h"
#import "Constant.h"
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BMKLocationKit/BMKLocationAuth.h>
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

#define NAVBAR_CHANGE_POINT 50

static NSString *const HomeCellIdentifier = @"Home";
static NSString *const H5ListCellIdentifier = @"H5List";
static NSString *const DesignerListCellIdentifier = @"DesignerList";

@interface HomeViewController ()<BMKLocationAuthDelegate,BMKLocationManagerDelegate,WXApiManagerDelegate>

@property (nonatomic, strong)BMKLocationManager *locationManager;
@property (nonatomic, copy)BMKLocatingCompletionBlock completionBlock;
@property (nonatomic, strong)CarouselScrollView *bannerView;
@property (nonatomic, strong)CarouselScrollView *h5bannerView;
@property (nonatomic, strong)CarouselScrollView *designerbannerView;
@property (nonatomic, strong)CarouselScrollView *tagbannerView;
@property (nonatomic, strong)HomeDataSource *homeDataSource;

@property (nonatomic, strong) UIView *navBgView;
@property (nonatomic, strong) UIButton *loctionBtn;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UILabel *loctionLable;
@property (nonatomic, strong) NSString *loctionString;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) CAGradientLayer *layer;
@property (nonatomic, assign) BOOL isFirst;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [WXApiManager sharedManager].delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    if (_bannerView) {
        [_bannerView initTimer];
    }
    //取消导航栏最下面的那一条线
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    [self initMapLocation];
    [self initCarouselScrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initCollectionView];
    [self.collectionView.header beginRefreshing];
}

-(void)initData{
    
    [super initData];
    [self NSNotificationCenter];
    _isFirst = YES;
    
//    [self showRefresh];
//    self.showRefreshHeader = YES;
//    [self refreshData];
}

-(void)refreshData{

    self.collectionView.scrollEnabled =NO;
    [[UserManager shareUserManager] homeBanner];
    [UserManager shareUserManager].homeBannerSuccess  = ^(NSArray * arr){
        
        NSLog(@"%@",arr);
        _bannerView.imageURLArray = [[HomeStore shearHomeStore]configurationBanner:arr];
        [_bannerView createAutoCarouselScrollView];
        [self loadingTagList];
    };
    
    [UserManager shareUserManager].errorFailure = ^(id obj){
        
        [self collectionEndRefreshing];
    };
}

-(void)loadingTagList{
    
    [[UserManager shareUserManager] hometagListWithType:TagTypeProduct];
    [UserManager shareUserManager] .homeTagListSuccess = ^(NSArray *arr){
       
       NSArray *tagArray = [[HomeStore shearHomeStore]configurationTag:arr];
        Home *home = [[Home alloc]init];
        home.itemKey =Type_Home;
        home.itemArray = tagArray;
        home.itemHeader = @"主题";
        
        if (_isFirst) {
            [self.dataArray addObject: home];
        }else{
            [self.dataArray replaceObjectAtIndex:0 withObject:home];
        }
        [self loadingRecommendedH5List];
    };
}

-(void)loadingRecommendedH5List{
    
    [[UserManager shareUserManager]homeH5ListWithType:H5ProductTypeDefault PageIndex:1 PageCount:3];
    [UserManager shareUserManager].homeH5ListSuccess = ^ (NSArray *arr){
        
        NSArray* itemArray =[[H5ListStore shearH5ListStore] configurationMenuWithMenu:arr];
        Home *home = [[Home alloc]init];
        home.itemKey =Type_H5;
        home.itemArray = itemArray;
        home.itemHeader = @"推荐H5";
        if (_isFirst) {
            [self.dataArray addObject: home];
        }else{
            [self.dataArray replaceObjectAtIndex:1 withObject:home];
        }
//        [self.dataArray addObject: home];
        [self loadingDesignerList];
    };
}

-(void)loadingDesignerList{
    
    [[UserManager shareUserManager]designerlistWithPageIndex:1 PageCount:10 designerListType:DesignerListTypeHome];
    [UserManager shareUserManager].designerlistSuccess = ^(NSArray * arr){
        
       NSArray *itemArray = [[DesignerListStore shearDesignerListStore]configurationMenuWithMenu:arr];
        Home *home = [[Home alloc]init];
        home.itemKey =Type_Designer;
        home.itemArray = itemArray;
        home.itemHeader = @"推荐设计师";
        if (_isFirst) {
            [self.dataArray addObject: home];
        }else{
            [self.dataArray replaceObjectAtIndex:2 withObject:home];
        }
//        [self.dataArray addObject: home];
        [self loadingScenarioH5List];
    };
}

-(void)loadingScenarioH5List{
    
    [[UserManager shareUserManager]homeH5ListWithType:H5ProductTypeScenario PageIndex:1 PageCount:3];
    [UserManager shareUserManager].homeH5ListSuccess = ^ (NSArray *arr){
        NSArray* itemArray =[[H5ListStore shearH5ListStore] configurationMenuWithMenu:arr];
        Home *home = [[Home alloc]init];
        home.itemKey =Type_H5;
        home.itemArray = itemArray;
        home.itemHeader = @"场景H5";
        if (_isFirst) {
            [self.dataArray addObject: home];
        }else{
            [self.dataArray replaceObjectAtIndex:3 withObject:home];
        }
//        [self.dataArray addObject: home];
        [self loadingOnePageH5List];
    };
}

-(void)loadingOnePageH5List{
    
    [[UserManager shareUserManager]homeH5ListWithType:H5ProductTypeSinglePage PageIndex:1 PageCount:3];
    [UserManager shareUserManager].homeH5ListSuccess = ^ (NSArray *arr){
        
        NSArray* itemArray =[[H5ListStore shearH5ListStore] configurationMenuWithMenu:arr];
        Home *home = [[Home alloc]init];
        home.itemKey =Type_H5;
        home.itemArray = itemArray;
        home.itemHeader = @"一页H5";
        if (_isFirst) {
            [self.dataArray addObject: home];
        }else{
            [self.dataArray replaceObjectAtIndex:4 withObject:home];
        }
//        [self.dataArray addObject: home];
        [self loadingVideoH5List];
    };
}

-(void)loadingVideoH5List{
    
    [[UserManager shareUserManager]homeH5ListWithType:H5ProductTypeVideo PageIndex:1 PageCount:3];
    [UserManager shareUserManager].homeH5ListSuccess = ^ (NSArray *arr){
        
        NSArray* itemArray =[[H5ListStore shearH5ListStore] configurationMenuWithMenu:arr];
        Home *home = [[Home alloc]init];
        home.itemKey =Type_H5;
        home.itemArray = itemArray;
        home.itemHeader = @"视频H5";
        if (_isFirst) {
            [self.dataArray addObject: home];
        }else{
            [self.dataArray replaceObjectAtIndex:5 withObject:home];
        }
        
        _isFirst = NO;
//        [self.dataArray addObject: home];
        
        NSLog(@"%ld",self.dataArray.count);
        
        [self.collectionView.header endRefreshing];
//        [self initCollectionView];
                [self.collectionView reloadData];
        self.collectionView.scrollEnabled = YES;

        [self haveHiddenAnimationWithAlpha:0 navigationBarHidden:NO offsetY:0];
        
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
        make.bottom.mas_equalTo(-44);
        make.top.mas_equalTo(self.view);
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
                 Home *home = weakSelf.dataArray[0];
                 TagList*tag = home.itemArray[indx];
                 [weakSelf loadinH5ListWithH5Type:GetH5ListTypeTag index:indx title:tag.name];
                 NSLog(@"%ld",(long)indx);

            };
            _tagbannerView.tag = 3;
            [_tagbannerView createTagScrollView];
            [newCell addSubview:_tagbannerView];
            
        } else if (indexPath.section == 1) {

            UICollectionViewCell *newCell = cell;
            
            for (UIView *view in newCell.subviews) {
                
                if ([view isKindOfClass: [CarouselScrollView class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            _h5bannerView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, newCell.height) placeHolderImage:nil imageURLs:(NSArray *)item imageDidSelectedBlock:^(NSInteger selectedIndex) {
                
                Home *home = self.dataArray[1];
                H5List *list = home.itemArray[selectedIndex];
                [UIManager pushTemplateDetailViewControllerWithTemplateId:list.id];
//                NSLog(@"你选择第%ld张图片",selectedIndex);

            }];
            _h5bannerView.tag = 1;
            [_h5bannerView createTopScrollView];
            [newCell addSubview:_h5bannerView];
        } else if (indexPath.section == 2){
            
            UICollectionViewCell *newCell = cell;
            for (UIView *view in newCell.subviews) {
                
                if ([view isKindOfClass: [CarouselScrollView class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            _designerbannerView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, newCell.height) placeHolderImage:nil imageURLs:(NSArray *)item imageDidSelectedBlock:^(NSInteger selectedIndex) {
                
                Home *home = self.dataArray[2];
                DesignerList *designer = home.itemArray[selectedIndex];                     [UIManager designerDetailWithDesignerId:designer.id];
            }];
            [_designerbannerView createdesignerScrollView];
            [newCell addSubview:_designerbannerView];
            _designerbannerView.tag = 2;
            
        } else  if (indexPath.section > 2) {
          
            [cell setItmeOfModel:item];
        }
        
    };
    
    CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock = ^(UICollectionReusableView *headerView, NSIndexPath *indexPath){
        
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
                
                if (section == 2) {

                    [UIManager designerListWithDesignerListType:DesignerListTypeHome];
                    
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
        [UIManager pushTemplateDetailViewControllerWithTemplateId:h5.id];
    }

    NSLog(@"23");
}


//测试发送消息到微信
- (IBAction)authWechat:(UIButton *)sender {
    
    [WXApiRequestHandler sendText:@"i-Top分享测试"
                          InScene:WXSceneTimeline];
}

//测试发送消息到微信回调
- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response{
   
    NSLog(@"%@",response);
}

//选择城市
-(void)selectorCity{
    
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
        
       
        return CGSizeMake(ScreenWidth, (ScreenWidth/3-33)*1.7+32+5+5+7+9-17);
    }else if (indexPath.section == 2){
        
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
    
    [[LoginMannager sheardLoginMannager]presentViewLoginViewController];
    [[LoginMannager sheardLoginMannager] clearLoginUserMassage];
    AppDelegate *app = ApplicationDelegate;
    app.tabBarController = nil;
    [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager] topViewController].view  withMessage:@"登录过期"];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:Notification_LogoutView object:nil];
}

- (void)setNavBar{
    
    UIView *navBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, ScreenWidth, 64)];
    [self.navigationController.navigationBar addSubview:navBgView];
    self.navBgView = navBgView;
    
    _layer = [CAGradientLayer layer];
    navBgView.backgroundColor = [UIColor clearColor];
    
    _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 27, 200 * KadapterW, 30)];
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
    readerButton.frame = CGRectMake(20, 0, 20 , 20 );
    self.loctionBtn.centerY = _searchBtn.centerY;

    self.loctionLable = [[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(self.loctionBtn.frame), 40, 35 , 16 )];
    self.loctionLable.font = [UIFont systemFontOfSize:9];
    self.loctionLable .text = self.loctionString;
    [navBgView addSubview: self.loctionLable];
    [navBgView addSubview:self.loctionBtn];
    
    self.messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.messageBtn.frame = CGRectMake(ScreenWidth-20-19 , 0, 19 , 19 );
    self.messageBtn.centerY = _searchBtn.centerY;
    [self.messageBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchDown];
    
    JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.messageBtn alignment:JSBadgeViewAlignmentTopRight];
    badgeView.badgeTextFont = [UIFont systemFontOfSize:9];
    badgeView.badgeText = @"12";
    badgeView.size = CGSizeMake(12, 12);
    [navBgView addSubview:self.messageBtn];
    [self.loctionBtn setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
    [self.messageBtn setImage:[UIImage imageNamed:@"icon_remind"] forState:UIControlStateNormal];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y ;
    NSLog(@"%lf",offsetY);
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
#pragma mark HaveHiddenAnimation
        //begin
        
        [self haveHiddenAnimationWithAlpha:alpha navigationBarHidden:NO offsetY:offsetY];
        
    } else if(offsetY < 0){
#pragma mark HaveHiddenAnimation
        
        [self haveHiddenAnimationWithAlpha:0 navigationBarHidden:YES offsetY:offsetY];
        
    }  else {
#pragma mark HaveHiddenAnimation
        
        [self haveHiddenAnimationWithAlpha:0 navigationBarHidden:NO offsetY:offsetY];
    }
}

-(void)haveHiddenAnimationWithAlpha:(CGFloat)alpha navigationBarHidden:(BOOL)animation offsetY:(NSInteger)offsetY{
    
    [self.navigationController setNavigationBarHidden:animation animated:NO];
    if (offsetY<NAVBAR_CHANGE_POINT) { //icon为黑色
        
        [self.loctionBtn setImage:[UIImage imageNamed:@"home_icon_locationblack"] forState:UIControlStateNormal];
        [self.messageBtn setImage:[UIImage imageNamed:@"home_icon_remindblack"] forState:UIControlStateNormal];
    } else {
        
        [self.loctionBtn setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
        [self.messageBtn setImage:[UIImage imageNamed:@"icon_remind"] forState:UIControlStateNormal];
    }
    
    _layer = [UIColor setGradualChangingColor:self.navBgView fromColor:@"FFA5EC" toColor:@"DEA2FF" alpha:alpha gradientLayer:_layer];
    [self.navBgView.layer insertSublayer:_layer atIndex:0];
}

-(void)loginOut{
    
}

-(void)loadinH5ListWithH5Type:(GetH5ListType)type index:(NSInteger)index title:(NSString *)title{
    
    H5ListViewController *h5Vc = [[H5ListViewController alloc]init];
    if (type == GetH5ListTypeTag) {
      
        h5Vc.tagH5LisType = index;
    } else {
        switch (index) {
            case 1:
                h5Vc.h5ProductType = H5ProductTypeDefault;
                break;
            case 3:
                h5Vc.h5ProductType = H5ProductTypeScenario;
                break;
            case 4:
                h5Vc.h5ProductType = H5ProductTypeSinglePage;
                break;
            case 5:
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

-(void)initMapLocation{
    
    NSLog(@"%@",AKAPKEY);
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:AKAPKEY authDelegate:self];
    //初始化实例
    _locationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    _locationManager.delegate = self;
    //设置返回位置的坐标系类型
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    //设置距离过滤参数
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置应用位置类型
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    //设置是否允许后台定位
    _locationManager.allowsBackgroundLocationUpdates = NO;
    //设置位置获取超时时间
    _locationManager.locationTimeout = 10;
    //设置获取地址信息超时时间
    _locationManager.reGeocodeTimeout = 10;
    
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:NO completionBlock:^(BMKLocation *location, BMKLocationNetworkState state, NSError *error)
     {
         if (error)
         {
             NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
         }
         if (location) {//得到定位信息，添加annotation
             
             if (location.location) {
                 NSLog(@"LOC = %@",location.location);
             }
             if (location.rgcData) {
                 
                 self.loctionLable.text = [NSString stringWithFormat:@"%@",[location.rgcData.city description]];
                 //                 [self setLeftBarItemString:[NSString stringWithFormat:@"%@>",[location.rgcData.city description]] action:@selector(selectorCity)];
                 
                 self.loctionString = [location.rgcData.city description];
                 NSLog(@"rgc = %@",[location.rgcData.city description]);
             }
         }
         NSLog(@"netstate = %d",state);
     }];
}

-(void)homeSearch{
    
    [UIManager showVC:@"SearchViewController"];
    NSLog(@"search");
}


@end
