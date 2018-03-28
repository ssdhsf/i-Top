//
//  PopularizeManagementViewController.m
//  itop
//
//  Created by huangli on 2018/3/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "PopularizeManagementViewController.h"
#import "PopularizeItmeTableViewController.h"

@interface PopularizeManagementViewController ()<SegmentTapViewDelegate,UIScrollViewDelegate,UpdateFrameDelegate>

@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)PopularizeItmeTableViewController *itemAllVc;
@property (nonatomic, strong)PopularizeItmeTableViewController *itemBeginVc;
@property (nonatomic, strong)PopularizeItmeTableViewController *itemGoingVc;
@property (nonatomic, strong)PopularizeItmeTableViewController *itemCancelVc;
@property (nonatomic, strong)PopularizeItmeTableViewController *itemEndVc;
@property (nonatomic, assign)NSInteger itmeIndex;//当前的选项

@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollerView;
@property (nonatomic ,strong)UIScrollView *scroll;
@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation PopularizeManagementViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    self.title = @"推广管理";
}

-(void)initView{
    
    [super initView];
    [self initSegment];
    [self createScrollView];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.rootScrollerView.contentSize = CGSizeMake(ScreenWidth, ScreenHeigh+300);
    self.rootScrollerView.delegate = self;
}

-(void)initData{
    
    self.dataArray = [NSArray arrayWithObjects:@"全部",@"待接单", @"进行中",@"已取消",@"已完成", nil];
    _itmeIndex = 0;
}

-(void)initSegment{
    
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 274, ScreenWidth, 40) withDataArray:self.dataArray withFont:15];
    self.segment.delegate = self;
    self.segment.lineColor = [UIColor clearColor];
    self.segment.textNomalColor = UIColorFromRGB(0x434a5c);
    self.segment.textSelectedColor = UIColorFromRGB(0xf95aee);
    [self.segment selectIndex:_itmeIndex];
    [self.rootScrollerView addSubview:self.segment];
}

-(void)createScrollView{
    
    if(_scroll){
        
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        [_scroll removeFromSuperview];
        _scroll = nil;
    }
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 346, ScreenWidth, ScreenHeigh)];;
    [self.rootScrollerView addSubview:_scroll];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(self.dataArray.count*ScreenWidth, ScreenHeigh);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentOffset = CGPointMake(ScreenWidth*_itmeIndex, 0);
    [self setItmeWithItmeTitle:self.dataArray[_itmeIndex] itemIndex:_itmeIndex];
}

-(void)setItmeWithItmeTitle:(NSString *)itmeTitle itemIndex:(NSInteger )itemIndex{
    
    __weak typeof(self) weakSelf = self;
    switch (itemIndex) {
        case 0:
            if (!_itemAllVc) {
                
                _itemAllVc = [[PopularizeItmeTableViewController alloc]initWithNibName:@"PopularizeItmeTableViewController" bundle:nil];
                _itemAllVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh);
                _itemAllVc.orderStatus = OrderStatusTypeNoel;
                _itemAllVc.delegate = weakSelf;

            }
        [_scroll addSubview:_itemAllVc.view];
             
        break;
        case 1:
            if (!_itemBeginVc) {
                
                _itemBeginVc = [[PopularizeItmeTableViewController alloc]initWithNibName:@"PopularizeItmeTableViewController" bundle:nil];
                _itemBeginVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-346);
                _itemBeginVc.orderStatus = OrderStatusTypeReady;
                
            }
            [_scroll addSubview:_itemBeginVc.view];
            break;

        case 2:
            if (!_itemGoingVc) {
                
                _itemGoingVc = [[PopularizeItmeTableViewController alloc]initWithNibName:@"PopularizeItmeTableViewController" bundle:nil];
                _itemGoingVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-346);
                _itemGoingVc.orderStatus = OrderStatusTypeGoOn;
                
            }
            [_scroll addSubview:_itemGoingVc.view];
            break;

        case 3:
            if (!_itemCancelVc) {
                
                _itemCancelVc = [[PopularizeItmeTableViewController alloc]initWithNibName:@"PopularizeItmeTableViewController" bundle:nil];
                _itemCancelVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-346);
                _itemCancelVc.orderStatus = OrderStatusTypefail;
                
            }
            [_scroll addSubview:_itemCancelVc.view];
            break;

        case 4:
            if (!_itemEndVc) {
                
                _itemEndVc = [[PopularizeItmeTableViewController alloc]initWithNibName:@"PopularizeItmeTableViewController" bundle:nil];
                _itemEndVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-346);
                _itemEndVc.orderStatus = OrderStatusTypeSucess;
                
            }
            [_scroll addSubview:_itemEndVc.view];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    int index = scrollView.contentOffset.x/ViewWidth;
    [self.segment selectIndex:index];
    [self setItmeWithItmeTitle:self.dataArray[index] itemIndex:index];
}

-(void)updateScrollerViewFrameWithTableViewContentOffset:(CGFloat)contentOffsetY{
    
    NSLog(@"%lf",contentOffsetY);
}

- (IBAction)top:(UIButton *)sender {
    
    self.rootScrollerView.contentOffset = CGPointMake(0, 242);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
