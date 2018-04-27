//
//  CustomRequirementsStateDetailViewController.m
//  itop
//
//  Created by huangli on 2018/4/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsStateDetailViewController.h"
#import "CustomRequirementsStore.h"
#import "CustomRequirementsDetailTabelViewController.h"
#import "CustomRequirementsDesginListViewController.h"
#import "DesignerListStore.h"


@interface CustomRequirementsStateDetailViewController ()<SegmentTapViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *stateButton;
@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, assign)NSInteger itmeIndex;//当前的选项
@property (nonatomic, assign)BOOL isSubmitBackOff; //是否是提交热点回掉操作
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, strong)CustomRequirementsDetail *customRequirementsDetail;
@property(nonatomic,weak)CustomRequirementsDetailTabelViewController *customRequirementsDetaiVc;
@property(nonatomic,weak)CustomRequirementsDesginListViewController *customRequirementsDesginList;

@end

@implementation CustomRequirementsStateDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    [super initView];
    [self initSegment];
    [self createScrollView];
}

-(void)initData{
    
    [super initData];
    self.dataArray = [[CustomRequirementsStore shearCustomRequirementsStore] showPageTitleWithState:_customRequirementsType demandType:_demandType];
    [[UserManager shareUserManager]customRequirementsDetailWithDetailId:_demand_id];
    [UserManager shareUserManager].customRequirementsSuccess = ^(NSDictionary *obj){
        
        _customRequirementsDetail = [[CustomRequirementsDetail alloc]initWithDictionary:obj error:nil];
        _customRequirementsDetail.demand.descrip = obj[@"demand"][@"description"];
        [self initCheckStateView];
        [self setupChildViewController];
        for (int i = 0; i < self.dataArray.count; i++) {
            
            [self addChildViewInContentView:i];
        }
    };
}

-(void)initNavigationBarItems{
    
    self.title = @"定制详情";
}

-(void)initCheckStateView{
    
    [self.stateButton setTitle:[[CustomRequirementsStore shearCustomRequirementsStore]showStateWithState: [_customRequirementsDetail.demand.check_status integerValue]] forState:UIControlStateNormal];
}

-(void)initSegment{
    
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 113, ScreenWidth/2, 40) withDataArray:self.dataArray withFont:15];
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
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 154, ScreenWidth, ScreenHeigh-154-NAVIGATION_HIGHT)];
    [self.view addSubview:_scroll];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(self.dataArray.count*ScreenWidth, 0);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentOffset = CGPointMake(ScreenWidth*_itmeIndex, 0);
}

- (void)setupChildViewController{

    for (NSString *string in self.dataArray) {
        
        if ([string isEqualToString:@"订单"]) {
            
            CustomRequirementsDetailTabelViewController *oneVc = [[CustomRequirementsDetailTabelViewController alloc]init];
            NSArray *array = [[CustomRequirementsStore shearCustomRequirementsStore]configurationCustomRequirementsDetailWithMenu:_customRequirementsDetail];
            _customRequirementsDetaiVc = oneVc;
            //    oneVc.delegate = self;
            [oneVc.dataArray addObjectsFromArray: array];
            [self addChildViewController:_customRequirementsDetaiVc];
        }
        
        if ([string isEqualToString:@"投标"]) {
            
            CustomRequirementsDesginListViewController *twoVc = [[CustomRequirementsDesginListViewController alloc]init];
            _customRequirementsDesginList = twoVc;
            [twoVc.dataArray  addObject:[[DesignerListStore shearDesignerListStore]configurationCustomRequirementsDegsinListWithRequstData:_customRequirementsDetail.designer_list]];
            [self addChildViewController:_customRequirementsDesginList];
        }
    }
}
// 添加相应的控制器的view到内容视图中
- (void)addChildViewInContentView:(NSInteger)index{
    
    UIViewController *childView = self.childViewControllers[index];
    [self.scroll addSubview:childView.view];
    childView.view.frame = CGRectMake(index * ScreenWidth, 0, ScreenWidth, ScreenHeigh-NAVIGATION_HIGHT-154);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = scrollView.contentOffset.x/ViewWidth;
    [self.segment selectIndex:index];
}

#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index{
    
    __weak typeof(self) weakSelf = self;
    //添加滚动动画
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.scroll.contentOffset = CGPointMake(ScreenWidth*index, 0);
    } completion:^(BOOL finished) {
        
    }];
}


@end
