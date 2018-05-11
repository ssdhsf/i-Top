//
//  CustomRequirementsStateListController.m
//  itop
//
//  Created by huangli on 2018/4/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsStateListController.h"
#import "CustomRequirementsStateListTableViewController.h"

#define EFFECTIVE_HIGHT ScreenHeigh-NAVIGATION_HIGHT-40

@interface CustomRequirementsStateListController ()<SegmentTapViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, assign)NSInteger itmeIndex;//当前的选项
@property (nonatomic, assign)BOOL isSubmitBackOff; //是否是提交热点回掉操作
@property (nonatomic ,strong)UIScrollView *scroll;
@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, strong)CustomRequirementsStateListTableViewController *directionalStateListVc;
@property (nonatomic, strong)CustomRequirementsStateListTableViewController *biddingStateListVc;

@end

@implementation CustomRequirementsStateListController

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
    
    self.title = @"定制管理";
    [self setRightCustomBarItem:@"dingzhi_icon_add" action:@selector(DirectionalDemandRelease)];
}

-(void)initData{
    self.dataArray = [NSArray arrayWithObjects:@"定向需求",@"竞标需求", nil];
    _itmeIndex = 0;
}

-(void)initView{
    
    [super initView];
    [self initSegment];
    [self createScrollView];
}

-(void)initSegment{
    
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/2, 40) withDataArray:self.dataArray withFont:15];
    self.segment.delegate = self;
    self.segment.lineColor = [UIColor clearColor];
    self.segment.textNomalColor = UIColorFromRGB(0x434a5c);
    self.segment.textSelectedColor = UIColorFromRGB(0xf95aee);
    [self.segment selectIndex:_itmeIndex];
    [self.view addSubview:self.segment];
}

-(void)createScrollView{
    
    if(_scroll){
        
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        [_scroll removeFromSuperview];
        _scroll = nil;
    }
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, EFFECTIVE_HIGHT)];
    [self.view addSubview:_scroll];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(self.dataArray.count*ScreenWidth, 0);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentOffset = CGPointMake(ScreenWidth*_itmeIndex, 0);
    [self setItmeWithItmeTitle:self.dataArray[_itmeIndex] itemIndex:_itmeIndex];
}

-(void)setItmeWithItmeTitle:(NSString *)itmeTitle itemIndex:(NSInteger )itemIndex{
    
    switch (itemIndex) {
        case 0:
            if (!_directionalStateListVc) {
                
                _directionalStateListVc = [[CustomRequirementsStateListTableViewController alloc]init];
                _directionalStateListVc.demandType = DemandTypeDirectional;
                _directionalStateListVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, _scroll.height);
            }
            [_scroll addSubview:_directionalStateListVc.view];
            break;
        case 1:
            if (!_biddingStateListVc) {
                _biddingStateListVc = [[CustomRequirementsStateListTableViewController alloc]init];
                _biddingStateListVc.demandType = DemandTypeBidding;
                _biddingStateListVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, _scroll.height);
            }
            [_scroll addSubview:_biddingStateListVc.view];
            break;
            
        default:
            break;
    }
}

#pragma mark --- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _itmeIndex = scrollView.contentOffset.x/ViewWidth;
    [self.segment selectIndex:_itmeIndex];
    [self setItmeWithItmeTitle:self.dataArray[_itmeIndex] itemIndex:_itmeIndex];
}

#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index{
    
    __weak typeof(self) weakSelf = self;
    //添加滚动动画
    _itmeIndex = index;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.scroll.contentOffset = CGPointMake(ScreenWidth*_itmeIndex, 0);
    } completion:^(BOOL finished) {
        
        [self setItmeWithItmeTitle:self.dataArray[_itmeIndex] itemIndex:_itmeIndex];
    }];
}

-(void)DirectionalDemandRelease{
    
      [UIManager showVC:@"DemandReleaseViewController"];
}

@end
