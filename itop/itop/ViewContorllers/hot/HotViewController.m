//
//  HotViewController.m
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HotViewController.h"
#import "H5ListViewController.h"
//#import "HotTableViewCell.h"
//#import "HotDataSource.h"
#import "SegmentTapView.h"
#import "HotH5ItmeViewController.h"
#import "RecommendedViewController.h"
#import "HotDetailsViewController.h"


@interface HotViewController ()<SegmentTapViewDelegate,UIScrollViewDelegate>

//@property (nonatomic, strong)HotDataSource *hotDataSource;
@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, assign)NSInteger itmeIndex;

@property (nonatomic ,strong)UIScrollView *scroll;
@property (nonatomic ,strong)HotH5ItmeViewController *h5Vc;
@property (nonatomic ,strong)HotH5ItmeViewController *videoVc;
@property (nonatomic ,strong)RecommendedViewController *recommendedVc;
@property (nonatomic ,strong)RecommendedViewController *informationVc;
@property (nonatomic ,strong)RecommendedViewController *localVc;

@property (nonatomic, strong) UIView *navBgView;
@property (nonatomic, strong) UIButton *loctionBtn;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UILabel *loctionLable;
@property (nonatomic, strong) NSString *loctionString;

@end

@implementation HotViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

-(void)initView{
    
    [super initView];
    [self initSegment];
    [self createScrollView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigafindHairlineImageView:NO];
    [self setNavBar];
    self.navigationController.navigationBar.translucent = NO;
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
    
    [self setLeftBarItemString:@"" action:nil];
}

-(void)createScrollView{
    
    if(_scroll){
        
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        [_scroll removeFromSuperview];
        _scroll = nil;
    }
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeigh-129)];;
    [self.view addSubview:_scroll];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(self.dataArray.count*ScreenWidth, ScreenHeigh-129);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    int index = _scroll.contentOffset.x/ViewWidth;
    [self setItmeWithItmeTitle:self.dataArray[index] itemIndex:index];
}

-(void)setItmeWithItmeTitle:(NSString *)itmeTitle itemIndex:(NSInteger )itemIndex{
    
    __weak typeof(self) weakSelf = self;
    switch (itemIndex) {
        case 0:
            
            if (!_recommendedVc) {
                _recommendedVc = [[RecommendedViewController alloc]initWithNibName:@"RecommendedViewController" bundle:nil];
                _recommendedVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-178);
                _recommendedVc.itmeType = itmeTitle;
                _recommendedVc.getArticleListType = GetArticleListTypeHot;
                _recommendedVc.pushControl = ^ (H5List *h5){
                    HotDetailsViewController *hotDetailsVc = [[HotDetailsViewController alloc]init];
                    hotDetailsVc.itemDetailType = HotItemDetailType;
                    hotDetailsVc.hotDetail_id = h5.id;
                    hotDetailsVc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:hotDetailsVc animated:YES];
                    
                };
            }
            [_scroll addSubview:_recommendedVc.view];
            
            break;
        case 1:
            if (!_h5Vc) {
                _h5Vc = [[HotH5ItmeViewController alloc]initWithNibName:@"HotH5ItmeViewController" bundle:nil];
                _h5Vc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-178);
                _h5Vc.itemType = [itmeTitle isEqualToString:@"H5"] ? H5ItmeViewController : VideoItmeViewController;
                _h5Vc.getArticleListType = GetArticleListTypeHot;
                _h5Vc.pushH5DetailControl = ^ (H5List *h5){
                    HotDetailsViewController *hotDetailsVc = [[HotDetailsViewController alloc]init];
                    hotDetailsVc.itemDetailType = H5ItemDetailType;
                    hotDetailsVc.hotDetail_id = h5.id;
                    hotDetailsVc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:hotDetailsVc animated:YES];
                };
            }
            [_scroll addSubview:_h5Vc.view];
            break;

        case 2:
            if (!_informationVc) {
                _informationVc = [[RecommendedViewController alloc]init];
                _informationVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-178);
                _informationVc.itmeType = itmeTitle;
                _informationVc.getArticleListType = GetArticleListTypeHot;
                _informationVc.pushControl = ^ (H5List *h5){
                    HotDetailsViewController *hotDetailsVc = [[HotDetailsViewController alloc]init];
                    hotDetailsVc.hotDetail_id = h5.id;
                    hotDetailsVc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:hotDetailsVc animated:YES];
                };
            }
            [_scroll addSubview:_informationVc.view];
            break;
        case 3:
            if (!_videoVc) {
                _videoVc = [[HotH5ItmeViewController alloc]initWithNibName:@"HotH5ItmeViewController" bundle:nil];
                _videoVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-178);
                _videoVc.itemType = [itmeTitle isEqualToString:@"H5"] ? H5ItmeViewController : VideoItmeViewController;
                _videoVc.getArticleListType = GetArticleListTypeHot;
                
                _videoVc.pushH5DetailControl = ^ (H5List *h5){
                    
                    [[Global sharedSingleton]showToastInTop:weakSelf.view withMessage:@"暂时未开放"];
                };
                
            }
            [_scroll addSubview:_videoVc.view];
            break;
        case 4:
            if (!_localVc) {
                _localVc = [[RecommendedViewController alloc]init];
                _localVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-178);
                _localVc.itmeType = itmeTitle;
                _localVc.getArticleListType = GetArticleListTypeHot;
                _localVc.pushControl = ^ (H5List *h5){
                    HotDetailsViewController *hotDetailsVc = [[HotDetailsViewController alloc]init];
                    hotDetailsVc.hotDetail_id = h5.id;
                    hotDetailsVc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:hotDetailsVc animated:YES];
                };
            }
            [_scroll addSubview:_localVc.view];
            break;

        default:
            break;
    }
}

-(void)initData{

    [self.dataArray addObjectsFromArray:[NSArray arrayWithObjects:@"推荐",@"H5",@"资讯", @"视频", @"本地", nil]];
}

-(void)initSegment{
    
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(32, 0, ScreenWidth-64, 65) withDataArray:self.dataArray withFont:17];
    self.segment.delegate = self;
    self.segment.lineColor = [UIColor clearColor];
    self.segment.textNomalColor = UIColorFromRGB(0x434a5c);
    self.segment.textSelectedColor = UIColorFromRGB(0xf95aee);
    [self.view addSubview:self.segment];
}

#pragma mark --- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = scrollView.contentOffset.x/ViewWidth;
    [self.segment selectIndex:index+1];
    [self setItmeWithItmeTitle:self.dataArray[index] itemIndex:index];
//    _itmeIndex = index;
}

#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index{
    
    __weak typeof(self) weakSelf = self;
    //添加滚动动画
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.scroll.contentOffset = CGPointMake(ScreenWidth*index, 0);
    } completion:^(BOOL finished) {
        
        [self setItmeWithItmeTitle:self.dataArray[index] itemIndex:index];
    }];
}

- (void)setNavBar{
    
    UIView *navBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, ScreenWidth, 64)];
    [self.navigationController.navigationBar addSubview:navBgView];
    self.navBgView = navBgView;
    navBgView.backgroundColor = [UIColor clearColor];
    
    UITextField *searchBtn = [[UITextField alloc] initWithFrame:CGRectMake(0, 27, 200 * KadapterW, 30)];

    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,20,26)];
    leftView.backgroundColor = [UIColor clearColor];
    //左面导航按钮
    UIButton *readerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loctionBtn = readerButton;
    readerButton.frame = CGRectMake(20, 0, 25 , 25 );
    self.loctionBtn.centerY = searchBtn.centerY;
    
    self.loctionLable = [[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(self.loctionBtn.frame), 40, 35 , 16 )];
    //    self.loctionLable.centerY = searchBtn.centerY;
    self.loctionLable.font = [UIFont systemFontOfSize:9];
    self.loctionLable .text = self.loctionString;
    [navBgView addSubview: self.loctionLable];
    [navBgView addSubview:self.loctionBtn];
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.frame = CGRectMake(ScreenWidth-50 , 0, 25 , 25 );
    self.searchBtn.centerY = searchBtn.centerY;
    [self.searchBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchDown];
    [navBgView addSubview:self.searchBtn];
    [self.loctionBtn setImage:[UIImage imageNamed:@"hot_icon_location"] forState:UIControlStateNormal];
    [self.searchBtn setImage:[UIImage imageNamed:@"hot_icon_search"] forState:UIControlStateNormal];
}


@end
