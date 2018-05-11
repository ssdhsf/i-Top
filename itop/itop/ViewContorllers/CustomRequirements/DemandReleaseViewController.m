//
//  DemandReleaseViewController.m
//  itop
//
//  Created by huangli on 2018/4/23.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DemandReleaseViewController.h"
#import "DirectionalDemandReleaseViewController.h"

#define EFFECTIVE_HIGHT ScreenHeigh-NAVIGATION_HIGHT-40

@interface DemandReleaseViewController ()<SegmentTapViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, assign)NSInteger itmeIndex;//当前的选项
@property (nonatomic, assign)BOOL isSubmitBackOff; //是否是提交热点回掉操作

@property (nonatomic ,strong)UIScrollView *scroll;
@property (nonatomic ,strong)DirectionalDemandReleaseViewController *directionalVc;
@property (nonatomic ,strong)DirectionalDemandReleaseViewController *biddingVc;

@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation DemandReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    [super initView];
    [self initSegment];
    [self createScrollView];
    [UIManager sharedUIManager].customRequirementsBackOffBolck = ^(id obj){
        
        [self back];
    };
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    self.title = @"定制需求";
}

-(void)initData{
    
    self.dataArray = [NSArray arrayWithObjects:@"定向需求",@"竞标需求", nil];
    _itmeIndex = 0;
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
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, EFFECTIVE_HIGHT)];;
    [self.view addSubview:_scroll];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(self.dataArray.count*ScreenWidth, 0);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentOffset = CGPointMake(ScreenWidth*_itmeIndex, 0);
    [self setItmeWithItmeTitle:self.dataArray[_itmeIndex] itemIndex:_itmeIndex];
}

-(void)setItmeWithItmeTitle:(NSString *)itmeTitle itemIndex:(NSInteger )itemIndex{
    
    __weak typeof(self) weakSelf = self;
    switch (itemIndex) {
        case 0:
            if (!_directionalVc) {
                
                _directionalVc = [[DirectionalDemandReleaseViewController alloc]initWithNibName:@"DirectionalDemandReleaseViewController" bundle:nil];
                _directionalVc.demandType = DemandTypeDirectional;
                _directionalVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, EFFECTIVE_HIGHT);
            }
            [_scroll addSubview:_directionalVc.view];
            break;
        case 1:
            if (!_biddingVc ) {
                _biddingVc = [[DirectionalDemandReleaseViewController alloc]init];
                _biddingVc.demandType = DemandTypeBidding;
                _biddingVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, EFFECTIVE_HIGHT);
            }
            [_scroll addSubview:_biddingVc.view];
            break;
            
        default:
            break;
    }
}

#pragma mark --- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = scrollView.contentOffset.x/ViewWidth;
    [self.segment selectIndex:index];
    [self setItmeWithItmeTitle:self.dataArray[index] itemIndex:index];
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

@end
