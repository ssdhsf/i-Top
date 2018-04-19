//
//  MyFocusViewController.m
//  itop
//
//  Created by huangli on 2018/2/9.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyFocusViewController.h"
#import "HotH5ItmeViewController.h"
#import "DesignerListViewController.h"
#import "SegmentTapView.h"
#import "HotDetailsViewController.h"
#import "RecommendedViewController.h"

@interface MyFocusViewController ()<SegmentTapViewDelegate,UIScrollViewDelegate>

@property (nonatomic ,strong)UIScrollView *scroll;
@property (nonatomic ,strong)HotH5ItmeViewController *h5Vc;
//@property (nonatomic ,strong)HotH5ItmeViewController *infomationVc;
@property (nonatomic ,strong)HotH5ItmeViewController *videoVc;
@property (nonatomic ,strong)DesignerListViewController *designerListVc;
@property (nonatomic ,strong)RecommendedViewController *infomationVc;


@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, assign)NSInteger itmeIndex;

@end

@implementation MyFocusViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
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
    
    self.title = @"关注";
    [self setRightCustomBarItem:@"hot_icon_search" action:@selector(search)];
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

-(void)initData{
    
    self.dataArray = @[@"设计师",@"H5",@"资讯", @"视频"];
}

-(void)initSegment{
    
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(32, 0, ScreenWidth-64, 65) withDataArray:self.dataArray withFont:17];
    self.segment.delegate = self;
    self.segment.lineColor = [UIColor clearColor];
    self.segment.textNomalColor = UIColorFromRGB(0x434a5c);
    self.segment.textSelectedColor = UIColorFromRGB(0xf95aee);
    [self.view addSubview:self.segment];
}

-(void)setItmeWithItmeTitle:(NSString *)itmeTitle itemIndex:(NSInteger )itemIndex{
    
    __weak typeof(self) weakSelf = self;
    switch (itemIndex) {
        case 0:
            
            if (!_designerListVc) {
                _designerListVc = [[DesignerListViewController alloc]initWithNibName:@"DesignerListViewController" bundle:nil];
                _designerListVc.designerListType = DesignerListTypeFocus;
                _designerListVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-178);
                
                _designerListVc.pushDesignerDetailControl = ^ (NSString *designerDetails_id){
                    
                    [UIManager designerDetailWithDesignerId:designerDetails_id];
                    
                };
            }
            [_scroll addSubview:_designerListVc.view];
            
            break;
        case 1:
            if (!_h5Vc) {
                _h5Vc = [[HotH5ItmeViewController alloc]initWithNibName:@"HotH5ItmeViewController" bundle:nil];
                _h5Vc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-178);
                _h5Vc.itemType =  H5ItmeViewController ;
                _h5Vc.getArticleListType = GetArticleListTypeFocus;
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
            if (!_infomationVc) {
                _infomationVc = [[RecommendedViewController alloc]init];
                _infomationVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-178);

                _infomationVc.itmeType = itmeTitle;
                _infomationVc.getArticleListType = GetArticleListTypeFocus;
                _infomationVc.pushControl = ^ (H5List *h5){
                    HotDetailsViewController *hotDetailsVc = [[HotDetailsViewController alloc]init];
                    hotDetailsVc.itemDetailType = HotItemDetailType;
                    hotDetailsVc.hotDetail_id = h5.id;
                    hotDetailsVc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:hotDetailsVc animated:YES];
                };
            }
            [_scroll addSubview:_infomationVc.view];
            break;
        case 3:
            if (!_videoVc) {
                _videoVc = [[HotH5ItmeViewController alloc]initWithNibName:@"HotH5ItmeViewController" bundle:nil];
                _videoVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-178);
                _videoVc.itemType = VideoItmeViewController;
                _videoVc.getArticleListType = GetArticleListTypeFocus;
                _videoVc.pushH5DetailControl = ^ (H5List *h5){
                    
                    [weakSelf showToastWithMessage:@"暂未开放"];
                };
            }
            [_scroll addSubview:_videoVc.view];
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

-(void)search{
    
    NSLog(@"zouni");
}

@end
