//
//  MyhotViewController.m
//  itop
//
//  Created by huangli on 2018/3/15.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyhotViewController.h"
#import "H5ListViewController.h"
#import "RecommendedViewController.h"
#import "HotDetailsViewController.h"
#import "MyHotH5ItmeViewController.h"
#import "MyHotDetailViewController.h"

@interface MyhotViewController ()<SegmentTapViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, assign)NSInteger itmeIndex;//当前的选项
@property (nonatomic, assign)BOOL isSubmitBackOff; //是否是提交热点回掉操作

@property (nonatomic ,strong)UIScrollView *scroll;
@property (nonatomic ,strong)MyHotH5ItmeViewController *h5Vc;
@property (nonatomic ,strong)MyHotH5ItmeViewController *videoVc;
@property (nonatomic ,strong)RecommendedViewController *informationVc;

@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation MyhotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    self.title = @"热点";
}

-(void)initData{
    
    self.dataArray = [NSArray arrayWithObjects:@"H5",@"资讯", @"视频", nil];
    _itmeIndex = 0;
    _isSubmitBackOff = NO;
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
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeigh-40)];;
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
            if (!_h5Vc || _isSubmitBackOff) {
               
                _h5Vc = [[MyHotH5ItmeViewController alloc]initWithNibName:@"MyHotH5ItmeViewController" bundle:nil];
                _h5Vc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-108);
                _h5Vc.itemType = [itmeTitle isEqualToString:@"H5"] ? H5ItmeViewController : VideoItmeViewController;
                _h5Vc.getArticleListType = GetArticleListTypeMyHot;
                _h5Vc.pushMyHotH5Control = ^ (H5List *h5){
                    
//                    if ([h5.check_status integerValue] == 2) {
                        MyHotDetailViewController *hotDetailsVc = [[MyHotDetailViewController alloc]init];
                        hotDetailsVc.itemDetailType = H5ItemDetailType;
                        hotDetailsVc.hotDetail_id = h5.id;
                        hotDetailsVc.checkStatusType = [h5.check_status integerValue];
                        hotDetailsVc.hidesBottomBarWhenPushed = YES;
                        [weakSelf.navigationController pushViewController:hotDetailsVc animated:YES];
//                    } else {
//                        
//                        [weakSelf showToastWithMessage:@"审核中"];
//                    }
                };
            }
            [_scroll addSubview:_h5Vc.view];
            break;
            
        case 1:
            if (!_informationVc || _isSubmitBackOff) {
                _informationVc = [[RecommendedViewController alloc]init];
                _informationVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-108);
                _informationVc.itmeType = itmeTitle;
                _informationVc.getArticleListType = GetArticleListTypeMyHot;
                _informationVc.pushControl = ^ (H5List *h5){
                    
//                    if ([h5.check_status integerValue] == 2) {
                        MyHotDetailViewController *hotDetailsVc = [[MyHotDetailViewController alloc]init];
                        hotDetailsVc.itemDetailType = HotItemDetailType;
                        hotDetailsVc.hotDetail_id = h5.id;
                        hotDetailsVc.checkStatusType = [h5.check_status integerValue];
                        hotDetailsVc.hidesBottomBarWhenPushed = YES;
                        [weakSelf.navigationController pushViewController:hotDetailsVc animated:YES];
//                    } else {
//                        
//                        [weakSelf showToastWithMessage:@"审核中"];
//                    }
                };
            }
            [_scroll addSubview:_informationVc.view];
            break;
        case 2:
            if (!_videoVc || _isSubmitBackOff) {
                _videoVc = [[MyHotH5ItmeViewController alloc]initWithNibName:@"MyHotH5ItmeViewController" bundle:nil];
                _videoVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-108);
                _videoVc.itemType = [itmeTitle isEqualToString:@"H5"] ? H5ItmeViewController : VideoItmeViewController;
                _videoVc.getArticleListType = GetArticleListTypeMyHot;
                _videoVc.pushMyHotH5Control = ^ (H5List *h5){
                    
                    [[Global sharedSingleton]showToastInTop:weakSelf.view withMessage:@"暂时未开放"];
                };
            }
            [_scroll addSubview:_videoVc.view];
            break;
            
        default:
            break;
    }
    
    _isSubmitBackOff = NO;
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

- (IBAction)release:(UIButton *)sender {
    
    [UIManager showVC:@"ReleaseHotViewController"];
    [UIManager sharedUIManager].realesHotBackOffBolck = ^(NSString *itmeIndex){
       
        _itmeIndex = [itmeIndex integerValue];
        _isSubmitBackOff = YES;
        [self initSegment];
        [self createScrollView];
    };
}

@end
