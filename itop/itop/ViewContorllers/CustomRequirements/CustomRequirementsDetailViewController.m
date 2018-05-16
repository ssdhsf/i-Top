//
//  CustomRequirementsDetailViewController.m
//  itop
//
//  Created by huangli on 2018/4/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsDetailViewController.h"
#import "KylinScrollView.h"
#import "CustomRequirementsStore.h"
#import "CustomRequirementsDetailTabelViewController.h"
#import "CustomRequirementsDesginListViewController.h"
#import "DesignerListStore.h"

#import "Demand.h"
#import "Enterprise.h"

@interface CustomRequirementsDetailViewController ()<UIScrollViewDelegate,SegmentTapViewDelegate,CustomRequirementsDetailViewControllerDelegate,CustomRequirementsDesginListViewControllerDelegate>

@property (strong, nonatomic) UIScrollView *rootScrollView;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *headImage;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *expectedPriceLabel;
@property (strong, nonatomic) UILabel *detailLabel;

@property (nonatomic, strong) SegmentTapView *segment;
@property (assign, nonatomic) NSInteger checkState;
@property (assign, nonatomic) int itmeIndex;
@property (strong, nonatomic) NSArray *titleArray;

/**内容的view*/
@property(nonatomic,weak)UIScrollView *contentView;
@property(nonatomic,weak)CustomRequirementsDetailTabelViewController *customRequirementsDetaiVc;
@property(nonatomic,weak)CustomRequirementsDesginListViewController *customRequirementsDesginList;

@property(nonatomic,strong)CustomRequirementsDetail *customRequirementsDetail;

@property (weak, nonatomic) IBOutlet UIButton *tenderButton;
@property (weak, nonatomic) IBOutlet UIButton *consultingButton;

@end

static CGFloat const HeaderH = 223;

@implementation CustomRequirementsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    
    [super initData];
//    _checkState = 3;
    self.titleArray = [NSArray arrayWithObjects:@"需求详情",@"投标信息", nil];
    
    [[UserManager shareUserManager]customRequirementsDetailWithDetailId:_custom_id];
    [UserManager shareUserManager].customRequirementsSuccess = ^(NSDictionary *obj){
       
        _customRequirementsDetail = [[CustomRequirementsDetail alloc]initWithDictionary:obj error:nil];
        _customRequirementsDetail.demand.descrip = obj[@"demand"][@"description"];
        NSLog(@"%@",obj);
        _checkState = [_customRequirementsDetail.demand.check_status integerValue];
        [self setupHeaderView];
        [self initCheckStateView];
        [self setupChildViewController];
        [self addChildViewInContentView:0];
        [self addChildViewInContentView:1];
        [self setData];
    };
    _itmeIndex = 0;
}

-(void)initView{
    
    [super initView];
    [self.tenderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth/2);
        make.bottom.mas_equalTo(kDevice_Is_iPhoneX ? -34 : 0);
        make.height.mas_equalTo(45);
    }];
    [self.consultingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth/2);
        make.bottom.mas_equalTo(kDevice_Is_iPhoneX ? -34 : 0);
        make.height.mas_equalTo(45);
    }];
}

-(void)initNavigationBarItems{
    
    self.title = @"需求详情";
}

-(void)setData{
  
    self.titleLabel.text = _customRequirementsDetail.demand.title;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_customRequirementsDetail.enterprise.head_img] placeholderImage:PlaceholderImage options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.expectedPriceLabel.text = [NSString stringWithFormat:@"预算 ¥%@",_customRequirementsDetail.demand.price];
//    _customRequirementsDetail.demand.browse_count
    
    NSString *time = [[Global sharedSingleton]timeFormatTotimeStringFormatWithtime:_customRequirementsDetail.demand.create_datetime willPattern:TIME_PATTERN_second didPattern:TIME_PATTERN_day];
    self.detailLabel.text = [NSString stringWithFormat:@"%@   发布：%@    浏览：%@    投标：%@",_customRequirementsDetail.enterprise.name,time ,_customRequirementsDetail.demand.browse_count,_customRequirementsDetail.demand.browse_count];
    
    self.detailLabel.font = [UIFont systemFontOfSize:10];
    self.expectedPriceLabel.font = [UIFont systemFontOfSize:15];
}

-(void)setupHeaderView{
   
    UIScrollView *rootScrollview = [[UIScrollView alloc]init];
    _rootScrollView = rootScrollview;
    rootScrollview.pagingEnabled = NO;
    rootScrollview.bounces = NO;
    rootScrollview.delegate = self;
    rootScrollview.contentSize = CGSizeMake(0 , ScreenHeigh + 259);

    [self.view addSubview: rootScrollview];
    [rootScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(kDevice_Is_iPhoneX ? -79 : -45);
    }];
    
     rootScrollview.bounces = NO;
    rootScrollview.showsHorizontalScrollIndicator = NO;

    UIView *headerView = [[UIView alloc]init];
    _headerView = headerView;

    UIImageView *headImage = [[UIImageView alloc]init];
    _headImage = headImage;
    headImage.layer.cornerRadius = 10;
    headImage.layer.masksToBounds = YES;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    _titleLabel = titleLabel;
    
    UILabel * detailLabel = [[UILabel alloc]init];
    _detailLabel = detailLabel;

    UILabel * expectedPriceLabel = [[UILabel alloc]init];
    _expectedPriceLabel = expectedPriceLabel;
    
    headerView.clipsToBounds = YES;
    [headerView addSubview:_headImage];
    [headerView addSubview:_titleLabel];
    [headerView addSubview:_detailLabel];
    [headerView addSubview:_expectedPriceLabel];
    
    [rootScrollview addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rootScrollview.mas_top);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(HeaderH));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(20));
        make.right.equalTo(@(-20));
        make.left.equalTo(@(20));
        make.height.equalTo(@(21));
    }];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(45));
        make.left.equalTo(@(46));
        make.right.equalTo(@(-20));
        make.height.equalTo(@(21));
    }];
    
    [expectedPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(96));
        make.left.equalTo(@(21));
        make.right.equalTo(@(-20));
        make.height.equalTo(@(21));
    }];
    
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(46));
        make.left.equalTo(@(20));
        make.height.width.equalTo(@(20));
    }];
    
    SegmentTapView*segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(20, 223, 200, 50) withDataArray:self.titleArray withFont:15];
    self.segment = segment;
    segment.delegate = self;
    segment.lineColor = [UIColor clearColor];
    segment.textNomalColor = UIColorFromRGB(0x434a5c);
    segment.textSelectedColor = UIColorFromRGB(0xf95aee);
    [segment selectIndex:_itmeIndex];
    [rootScrollview addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.left.equalTo(@(20));
        make.width.equalTo(@(150));
        make.height.equalTo(@(50));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromRGB(0xF0F1F3);
    [segment addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(segment.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(1));
    }];
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    _contentView = contentView;
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    contentView.delegate = self;
    contentView.contentSize = CGSizeMake(self.titleArray.count * ScreenWidth , 0);
    
    [rootScrollview addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segment.mas_bottom);
        make.width.equalTo(@(ScreenWidth));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(ScreenHeigh - NAVIGATION_HIGHT));
    }];
}

-(void)initCheckStateView{
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(25, 150, ScreenWidth-50, 2)];
    lineView.backgroundColor = UIColorFromRGB(0xF5F7F9);
    CAGradientLayer *layer =
    [UIColor setLocalGradualChangingColor:CGRectMake(0, 0, (lineView.width/6)*(_checkState-1), 2) fromColor:@"FFA5EC" toColor:@"B499F8"];
    [lineView.layer addSublayer:layer];
    [_headerView addSubview:lineView];
    for (int i = 0; i<7; i++) {
        
        UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+(lineView.width/6)*i - 8, 143, 16, 16)];
        stateLabel.text = [NSString stringWithFormat:@"%d",i+1];
        stateLabel.layer.cornerRadius = stateLabel.width/2;
        stateLabel.textAlignment = NSTextAlignmentCenter;
        stateLabel.font = [UIFont systemFontOfSize:9];
        stateLabel.layer.masksToBounds = YES;
        
        if (i < _checkState) {
    
            stateLabel.backgroundColor = UIColorFromRGB(0xFBA5ED);
            stateLabel.textColor = UIColorFromRGB(0xFFFFFF);
        } else {
            stateLabel.backgroundColor = UIColorFromRGB(0xF5F7F9);
            stateLabel.textColor = UIColorFromRGB(0x434a5c);
        }
        UILabel *stateTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(stateLabel.frame) + 10, 40, 16)];
        stateTextLabel.centerX = stateLabel.centerX;
        stateTextLabel.textAlignment = NSTextAlignmentCenter;
        stateTextLabel.font = [UIFont systemFontOfSize:10];
        stateTextLabel.text = [[CustomRequirementsStore shearCustomRequirementsStore] stateStringWithCheckState:i];
        stateTextLabel.transform = CGAffineTransformMakeRotation(M_PI / 4);
        [_headerView addSubview:stateLabel];
        [_headerView addSubview:stateTextLabel];
    }
}

- (void)setupChildViewController{
    
    CustomRequirementsDetailTabelViewController *oneVc = [[CustomRequirementsDetailTabelViewController alloc]init];
    NSArray *array = [[CustomRequirementsStore shearCustomRequirementsStore]configurationCustomRequirementsDetailWithMenu:_customRequirementsDetail];
    _customRequirementsDetaiVc = oneVc;
    oneVc.delegate = self;
    [oneVc.dataArray addObjectsFromArray: array];
//    [self addChildViewController:oneVc];
    
    CustomRequirementsDesginListViewController *twoVc = [[CustomRequirementsDesginListViewController alloc]init];
    _customRequirementsDesginList = twoVc;
   [twoVc.dataArray  addObject:[[DesignerListStore shearDesignerListStore]configurationCustomRequirementsDegsinListWithRequstData:_customRequirementsDetail.designer_list]];
    twoVc.delegate = self;
    [self addChildViewController:_customRequirementsDetaiVc];
    [self addChildViewController:_customRequirementsDesginList];
}
// 添加相应的控制器的view到内容视图中
- (void)addChildViewInContentView:(NSInteger)index{

    UIViewController *childView = self.childViewControllers[index];
    [self.contentView addSubview:childView.view];
    childView.view.frame = CGRectMake(index * ScreenWidth, 0, ScreenWidth, ScreenHeigh-NAVIGATION_HIGHT-50);

    // 取出要跳转的view
    CustomRequirementsDetailTabelViewController *oneView = (CustomRequirementsDetailTabelViewController *)childView;
//    // 跳转时滚动到当前view 的offsetY位置
    [self customRequirementsDetailScrollToChangeHeaderViewHeight:oneView.tableView.contentOffset.y];
    
    CustomRequirementsDesginListViewController*towView = (CustomRequirementsDesginListViewController *)childView;
    //    // 跳转时滚动到当前view 的offsetY位置
    [self customRequirementsDetailScrollToChangeHeaderViewHeight:towView.tableView.contentOffset.y];
    oneView.tableView.scrollEnabled = NO;
    towView.tableView.scrollEnabled = NO;
//    oneView.tableView.bounces = NO;
//    towView.tableView.bounces = NO;
    //    NSLog(@"第二个控制制 OFFSETY ----//%f",twovc.tableView.contentOffset.y);
}

#pragma mark- TableViewScrollDelegate
/**
 *  通过代理接收每个子控制器的滚动Y值
 *
 *  @param scrollY 滚动了多少Y值
 */
- (void)customRequirementsDetailViewControllerTableViewDidScroll:(CGFloat)scrollY{
   
    [self customRequirementsDetailScrollToChangeHeaderViewHeight:scrollY];
}

- (void)CustomRequirementsDesginListViewControllerTableViewDidScroll:(CGFloat)scrollY{
    
    [self customRequirementsDetailScrollToChangeHeaderViewHeight:scrollY];
}

- (void)customRequirementsDetailScrollToChangeHeaderViewHeight:(CGFloat)scrollY{
        NSLog(@"%f",scrollY);
    if (scrollY < 0) {
        
//        _customRequirementsDetaiVc.tableView.bounces = NO;
//        _customRequirementsDesginList.tableView.bounces = NO;
        [UIView animateWithDuration:0.25 animations:^{

            _rootScrollView.contentOffset = CGPointMake(0, 0);
            
        } completion:^(BOOL finished) {
            
            _rootScrollView.scrollEnabled = YES;
            _customRequirementsDetaiVc.tableView.scrollEnabled = NO;
            _customRequirementsDesginList.tableView.scrollEnabled = NO;

    }];

    } else{
        
        NSLog(@"走你");
    }
}

#pragma mark- ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (CGSizeEqualToSize(scrollView.contentSize , _rootScrollView.contentSize)) {
        
//        self.contentView.scrollEnabled = NO;
        NSLog(@"%f",scrollView.contentOffset.y);
        if (scrollView.contentOffset.y >= 223) {
            
//            self.contentView.scrollEnabled = YES;
            _rootScrollView.contentOffset = CGPointMake(0, 223);
            _rootScrollView.scrollEnabled = NO;
            _customRequirementsDetaiVc.tableView.scrollEnabled = YES;
            _customRequirementsDesginList.tableView.scrollEnabled = YES;
        }
    }else{
        
        _rootScrollView.scrollEnabled = YES;
        _customRequirementsDetaiVc.tableView.scrollEnabled = NO;
        _customRequirementsDesginList.tableView.scrollEnabled = NO;
    }
    if (scrollView == self.contentView) {
    }
}

// 滚动切换控制器
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.contentView) {
//        NSLog(@"=======%f",scrollView.contentOffset.x);
        int index = scrollView.contentOffset.x/ViewWidth;
        [self.segment selectIndex:index];
        
        
        if (self.rootScrollView.contentOffset.y >= 223) {
            _customRequirementsDetaiVc.tableView.scrollEnabled = YES;
            _customRequirementsDesginList.tableView.scrollEnabled = YES;

        } else {
            _customRequirementsDetaiVc.tableView.scrollEnabled = NO;
            _customRequirementsDesginList.tableView.scrollEnabled = NO;
        }
    }
}

#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index{
    
    __weak typeof(self) weakSelf = self;
    //添加滚动动画
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.contentView.contentOffset = CGPointMake(ScreenWidth*index, 0);
    } completion:^(BOOL finished) {
        
//        [self setItmeWithItmeTitle:self.dataArray[index] itemIndex:index];
    }];
}


@end
