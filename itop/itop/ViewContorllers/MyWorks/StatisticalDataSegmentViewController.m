//
//  StatisticalDataSegmentViewController.m
//  itop
//
//  Created by huangli on 2018/4/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "StatisticalDataSegmentViewController.h"
#import "StatisticalDataViewController.h"

@interface StatisticalDataSegmentViewController ()<SegmentTapViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, assign)NSInteger itmeIndex;//当前的选项
@property (nonatomic ,strong)UIScrollView *scroll;

@property (nonatomic, strong)StatisticalDataViewController *vc1;
@property (nonatomic, strong)StatisticalDataViewController *vc2;
@property (nonatomic, strong)StatisticalDataViewController *vc3;

@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation StatisticalDataSegmentViewController

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
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    self.title = @"数据概况";
}

-(void)initData{
    
    
    if ([[UserManager shareUserManager]crrentUserType] > 1) {
      
        self.dataArray = [NSArray arrayWithObjects:@"推广",@"热点", @"粉丝", nil];
    } else {
      
        self.dataArray = [NSArray arrayWithObjects:@"H5作品",@"热点", @"粉丝", nil];
    }
    
    _itmeIndex = 0;
}

-(void)initSegment{
    
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(30, 19, ScreenWidth/2, 40) withDataArray:self.dataArray withFont:15];
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
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 59, ScreenWidth, ScreenHeigh-40)];;
    [self.view addSubview:_scroll];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(self.dataArray.count*ScreenWidth, ScreenHeigh-64);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentOffset = CGPointMake(ScreenWidth*_itmeIndex, 0);
    [self setItmeWithItmeTitle:self.dataArray[_itmeIndex] itemIndex:_itmeIndex];
}

-(void)setItmeWithItmeTitle:(NSString *)itmeTitle itemIndex:(NSInteger )itemIndex{
    
    __weak typeof(self) weakSelf = self;
    switch (itemIndex) {
        case 0:
            if (!_vc1 ) {
                
                _vc1 = [[StatisticalDataViewController alloc]init];
                if ([[UserManager shareUserManager] crrentUserType] > 1) {
                    
                     _vc1.statisticsType  = StatisticsTypePop;
                    
                } else {
                    _vc1.statisticsType  = StatisticsTypeH5Product;
                }
     
                _vc1.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-108);
            }
            [_scroll addSubview:_vc1.view];
            break;
            
        case 1:
            if (!_vc2) {
                _vc2 = [[StatisticalDataViewController alloc]init];
                _vc2.statisticsType  = StatisticsTypeHot;
                _vc2.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-108);
            }
            [_scroll addSubview:_vc2.view];
           
            break;
        case 2:
            if (!_vc3) {
                _vc3 = [[StatisticalDataViewController alloc]init];
                _vc3.statisticsType  = StatisticsTypeFuns;
                _vc3.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-108);
            }
            [_scroll addSubview:_vc3.view];
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
