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

@property (weak, nonatomic) IBOutlet UIButton *openDemandButton;
@property (weak, nonatomic) IBOutlet UILabel *demandDescriptionLabel;

@property (nonatomic, strong)CustomRequirementsStateListTableViewController *directionalStateListVc;
@property (nonatomic, strong)CustomRequirementsStateListTableViewController *biddingStateListVc;

@end

@implementation CustomRequirementsStateListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [UIManager sharedUIManager].customRequirementsRequestDataBackOffBolck = ^ (id obj){ //操作回掉
        
        if (_itmeIndex == 0) {
          
            [self.directionalStateListVc tableViewbeginRefreshing];
        } else {
            
            [self.biddingStateListVc tableViewbeginRefreshing];
        }
    };
    
    [UIManager sharedUIManager].payBackOffBolck = ^ (NSNumber *payType){ //托管赏金
        
        if ([payType integerValue] == PAYTYPE_ENTERPRISE) {
            if (_itmeIndex == 0) {
                
                [self.directionalStateListVc tableViewbeginRefreshing];
            } else {
                
                [self.biddingStateListVc tableViewbeginRefreshing];
            }
        } else {
            
            [self initData];
        }
        
    };
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
}

-(void)initData{
    
    [super initData];
    _openDemandButton.hidden = YES;
    _demandDescriptionLabel.hidden = YES;
    [[UserManager shareUserManager]demandAuthority];
    [UserManager shareUserManager].demandAuthoritySuccess = ^(id obj){ //有权限
        
        self.dataArray = [NSArray arrayWithObjects:@"定向需求",@"竞标需求", nil];
        [self initSegment];
        [self createScrollView];
        
        if ([[UserManager shareUserManager]crrentUserType] == UserTypeEnterprise) {
            [self setRightCustomBarItem:@"dingzhi_icon_add" action:@selector(DirectionalDemandRelease)];
        }
        _itmeIndex = 0;
    };
    
    [UserManager shareUserManager].demandAuthorityFailure = ^(id obj){//没有权限
        
        _openDemandButton.hidden = NO;
        _demandDescriptionLabel.hidden = NO;
        self.noDataType = NoDataTypeProduct;
        self.originY = 50;
        self.tipsMessage = @"您还没有开通定制服务呢";
        [self setHasData:NO];
    };
}

-(void)initView{
    
    [super initView];
    _openDemandButton.layer.cornerRadius = _openDemandButton.height/2;
    [_openDemandButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_openDemandButton)];
    _openDemandButton.layer.masksToBounds = YES;
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

- (IBAction)openDemand:(UIButton *)sender {
    
    [UIManager showVC:@"OpenDemandServiceViewController"];
    
}


@end
