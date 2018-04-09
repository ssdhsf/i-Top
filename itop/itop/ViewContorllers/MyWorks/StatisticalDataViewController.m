//
//  StatisticalDataViewController.m
//  itop
//
//  Created by huangli on 2018/1/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "StatisticalDataViewController.h"
#import "StatisticalDataStore.h"
#import "PXLineChartView.h"
#import "PointItem.h"
#import "LMJDropdownMenu.h"
//#import "SegmentTapView.h"

#define MAX_COUNT(a,b,c) (a>b?(a>c?a:c):(b>c?b:c))

//static bool fill = NO;

@interface StatisticalDataViewController ()<PXLineChartViewDelegate,SegmentTapViewDelegate,LMJDropdownMenuDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong)StatisticalDataStore *statisticalDataStore;

//@property (nonatomic, strong) SegmentTapView *segment;
@property (nonatomic, strong) LMJDropdownMenu *dropdownMenu;
@property(nonatomic,  strong) NSArray *dropdownItme; //下拉分类
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, weak) IBOutlet PXLineChartView *pXLineChartView;
//@property (weak, nonatomic) IBOutlet UILabel *useCountLabel;
//@property (weak, nonatomic) IBOutlet UIView *useCountView;
//
//@property (weak, nonatomic) IBOutlet UIView *browseCountView;
//@property (weak, nonatomic) IBOutlet UILabel *browseCountLabel;
//
//@property (weak, nonatomic) IBOutlet UIView *funsCountView;
//@property (weak, nonatomic) IBOutlet UILabel *funsCountLabel;
//
//@property (weak, nonatomic) IBOutlet UIView *productCountView;
//@property (weak, nonatomic) IBOutlet UILabel *productCountLabel;
//@property (weak, nonatomic) IBOutlet UIView *commentsCountView;
//@property (weak, nonatomic) IBOutlet UILabel *commentsCountLabel;
//
//@property (weak, nonatomic) IBOutlet UIView *recommendedCountView;
//@property (weak, nonatomic) IBOutlet UILabel *recommendedCountLabel;

@property (nonatomic, strong) NSMutableArray *lines;//line count
@property (nonatomic, strong) NSMutableArray *xElements;//x轴数据
@property (nonatomic, strong) NSMutableArray *yElements;//y轴数据


@property (nonatomic, strong) NSMutableArray *itmeArray;//y轴数据

@property (nonatomic, strong)Statistical *statisticalModel;//曲线模型
//@property (nonatomic, assign)StatisticsType statisticsType;//数据类型

//@property (nonatomic, strong)RecordStatisticsItem *statisticsItemH5;
//@property (nonatomic, strong)RecordStatisticsItem *statisticsItemHot;
//@property (nonatomic, strong)RecordStatisticsItem *statisticsItemFuns;
//@property (nonatomic, assign)BOOL currentItme;
@property (nonatomic, assign)NSInteger itmeFrameMaxY;

@end

@implementation StatisticalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initView{
    
    [super initView];
    _pXLineChartView.hidden = YES;
    if (self.statisticsType == StatisticsTypePop) {
        
        [self initDropdownMenu];
    }
    [self initDateSegmentControl];
    [self initPXLineChartView];
//    [self setupCountView];
}

-(void)initNavigationBarItems{
    
    self.title = @"数据概况";
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initData{
    
    [super initData];
    _itmeArray = [[StatisticalDataStore shearStatisticalDataStore]configurationStatisticalItmeDataTitleWithUserType:[[UserManager shareUserManager]crrentUserType] itmeType:_statisticsType];
    
    _xElements = [NSMutableArray array];
    _yElements = [NSMutableArray array];
//    _statisticsType = StatisticsTypeH5Product; // 初始值
    [self assignmentXElementsWithSegmentType:1];
}

-(void)loadingDataToViews{

    _lines = [NSMutableArray array];
//    self.productCountLabel.text = [NSString stringWithFormat:@"%@",_statisticalModel.product_count_total] ;
//    self.commentsCountLabel.text = [NSString stringWithFormat:@"%@",_statisticalModel.comment_count_total];
//    self.recommendedCountLabel.text = [NSString stringWithFormat:@"%@",_statisticalModel.commend_count_total];
    
//    self.browseCountLabel.text = @"暂无数据";
//    self.funsCountLabel.text = @"暂无数据";
//    self.useCountLabel.text = @"暂无数据";
    
    [_lines addObject:[[StatisticalDataStore shearStatisticalDataStore] itmeDataModelWithDictionarys:_statisticalModel.product_count_list ThemeColor:UIColorFromRGB(0xfd91bd)]];
    [_lines addObject:[[StatisticalDataStore shearStatisticalDataStore] itmeDataModelWithDictionarys:_statisticalModel.commend_count_list ThemeColor:UIColorFromRGB(0xacbbfc)]];
    [_lines addObject:[[StatisticalDataStore shearStatisticalDataStore] itmeDataModelWithDictionarys:_statisticalModel.comment_count_list ThemeColor:UIColorFromRGB(0x7ee794)]];
    NSInteger maxTemp = MAX_COUNT([_statisticalModel.product_count_total integerValue], [_statisticalModel.commend_count_total integerValue],[_statisticalModel.comment_count_total integerValue]);
    
    [_yElements removeAllObjects];
    [_yElements addObjectsFromArray:[[StatisticalDataStore shearStatisticalDataStore] coordinatesYElementsPiecewiseWithMaxCount:maxTemp]];
    [_pXLineChartView reloadData];
//    [self recordStatisticsItemWithItmeTypeIndex:_statisticsType];
}

//-(void)initSegment{
//    
//    NSArray *titleArray = [NSArray arrayWithObjects:@"H5作品",@"热点",@"粉丝", nil];
//    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(30, 19, ScreenWidth/2, 30) withDataArray:titleArray withFont:15];
//    self.segment.delegate = self;
//    self.segment.lineImageView.hidden = YES;
//    self.segment.textNomalColor = [UIColor blackColor];
//    self.segment.textSelectedColor = UIColorFromRGB(0xf9a5ee);
//    self.segment.titleFont = 15;
//    [self.view addSubview:self.segment];
//}

-(void)initDropdownMenu{
    
    _dropdownMenu = [[LMJDropdownMenu alloc]initWithFrame:CGRectMake(50, 20, ScreenWidth -100, 34)];
    [self.view addSubview:_dropdownMenu];
    [self steupDropdownMenu];
}

-(void)steupDropdownMenu{
    
    [_dropdownMenu setMenuTitles:self.dropdownItme rowHeight:44];
    _dropdownMenu.delegate = self;
}

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    
//    H5List *product = _myProductArray[number];
//    [self refreshProductCommentWithProductId:product.id];
}


-(void)setupStatisticalItem{
    for (int i = 0; i<_itmeArray.count; i++) {
    
        StatisticalDataModel *statistica = _itmeArray[i];
        UIView *mark = [[UIView alloc] init];
        UILabel *total = [[UILabel alloc] init];
        
        if (i%2 > 0) {
           
            mark.frame = CGRectMake(ScreenWidth/2,CGRectGetMaxY(_segmentedControl.frame)+30+ (i/2*45), 12, 12);
            total.frame = CGRectMake(CGRectGetMaxX(mark.frame)+5,CGRectGetMaxY(_segmentedControl.frame)+30+ (i/2*45), ScreenWidth/2-32, 17);
        } else {
            
            mark.frame = CGRectMake(15,CGRectGetMaxY(_segmentedControl.frame)+30+ (i/2*45), 12, 12);
            total.frame = CGRectMake(CGRectGetMaxX(mark.frame)+5,CGRectGetMaxY(_segmentedControl.frame)+30+ (i/2*45), ScreenWidth/2-32, 17);
            
        }
        mark.layer.cornerRadius = mark.width/2;
        mark.backgroundColor = statistica.markColor;
        total.text = [NSString stringWithFormat:@"%@  %@",statistica.title,statistica.accessNumber];
        total.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:mark];
        [self.view addSubview:total];
        
        if (i == _itmeArray.count-1) {
           
            _itmeFrameMaxY = CGRectGetMaxY(total.frame); //记录最后一个itme 的frame
            _pXLineChartView.frame = CGRectMake(0, _itmeFrameMaxY+40, ScreenWidth-10, 170);
            _pXLineChartView.hidden = NO;
        }
    }
}

-(void)initDateSegmentControl{
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"7天",@"14天",@"30天", nil];
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:titleArray];
    
    if (self.statisticsType == StatisticsTypePop) {
       _segmentedControl.frame = CGRectMake(ScreenWidth/2-180/2,80, 180, 30);
    } else {
        
         _segmentedControl.frame = CGRectMake(ScreenWidth/2-180/2,40, 180, 30);
    }
    _segmentedControl.tintColor = UIColorFromRGB(0xe0e3e6);
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    [self.segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
}

//-(void)setupCountView{
//    
//    _productCountView.layer.cornerRadius = _productCountView.width/2;
//    _useCountView.layer.cornerRadius = _useCountView.width/2;
//    _browseCountView.layer.cornerRadius = _browseCountView.width/2;
//    _funsCountView.layer.cornerRadius = _funsCountView.width/2;
//    _recommendedCountView.layer.cornerRadius = _recommendedCountView.width/2;
//    _commentsCountView.layer.cornerRadius = _commentsCountView.width/2;
//}

-(void)initPXLineChartView{
    
    _pXLineChartView.delegate = self;
}

//获取访问日期
-(void)assignmentXElementsWithSegmentType:(NSInteger )index{
   
//    _currentItme = YES; //进入请求数据页表示已经在当前页
    [_xElements removeAllObjects];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd"];
    NSInteger currentTime = [date timeIntervalSince1970];
    for (int i = 0; i < index *7; i++) {
        
        NSInteger dayTime = (long)24*60*60*(i);
        NSString *day =  [NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:currentTime - dayTime]]];
        [_xElements addObject:day];
        NSLog(@"%@",day);
    }
   _xElements = (NSMutableArray *)[[_xElements reverseObjectEnumerator] allObjects];
    [[UserManager shareUserManager]dataStatisticsWithStartDate:[_xElements lastObject] endDate:[_xElements firstObject] statisticsType:_statisticsType];
    [UserManager shareUserManager].statisticsSuccess = ^(NSDictionary *statistics){
        
        _statisticalModel = [[Statistical alloc]initWithDictionary:statistics error:nil];
        [self setupStatisticalItem];
        [self loadingDataToViews];
    };
}

//获取不同类型的最大数据  然后根据用户选择截取
//-(NSMutableArray *)geMonthDataWithMonthData:(NSArray *)monthData{
//    
//    return nil;
//}

#pragma mark --- scrollView delegate
#pragma mark -------- select Index
//-(void)selectedIndex:(NSInteger)index{
//    
//    _statisticsType = index;
//    _currentItme = NO; //切换item表示已经不是本页
//    [self recordStatisticsItemWithItmeTypeIndex:index];
//}

#pragma mark PXLineChartViewDelegate
//通用设置
- (NSDictionary<NSString*, NSString*> *)lineChartViewAxisAttributes {
    return @{yElementInterval : @"30",
             xElementInterval : @"40",
             yMargin : @"50",
             xMargin : @"25",
             yAxisColor : [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1],
             xAxisColor : [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1],
             gridColor : [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1],
             gridHide : @1,
             pointHide : @0,
             pointFont : [UIFont systemFontOfSize:10],
             firstYAsOrigin : @1,
             scrollAnimation : @1,
             scrollAnimationDuration : @"2"};
}

//line count
- (NSUInteger)numberOfChartlines {
    return self.lines.count;
}

//x轴y轴对应的元素count
- (NSUInteger)numberOfElementsCountWithAxisType:(AxisType)axisType {
    return (axisType == AxisTypeY)? _yElements.count : _xElements.count;
}

//x轴y轴对应的元素view
- (UILabel *)elementWithAxisType:(AxisType)axisType index:(NSUInteger)index {
    UILabel *label = [[UILabel alloc] init];
    NSString *axisValue = @"";
    if (axisType == AxisTypeX) {
        axisValue = _xElements[index];
        label.textAlignment = NSTextAlignmentCenter;//;
    }else if(axisType == AxisTypeY){
        axisValue = _yElements[index];
        label.textAlignment = NSTextAlignmentRight;//;
    }
    label.text = axisValue;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    return label;
}

//每条line对应的point数组
- (NSArray<id<PointItemProtocol>> *)plotsOflineIndex:(NSUInteger)lineIndex {
    return self.lines[lineIndex];
}

//点击point回调响应
- (void)elementDidClickedWithPointSuperIndex:(NSUInteger)superidnex pointSubIndex:(NSUInteger)subindex {
    PointItem *item = self.lines[superidnex][subindex];
    NSString *xTitle = item.time;
    NSString *yTitle = item.price;
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:yTitle
                                                                       message:[NSString stringWithFormat:@"x：%@ \ny：%@",xTitle,yTitle] preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertView animated:YES completion:nil];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    fill = !fill;
//    self.lines = [self lines:fill];
//    [_pXLineChartView reloadData];
//}

/**
 *  UISegmentedControl点击事件
 *
 *  @param  segmented index
 */
-(void)didClicksegmentedControlAction:(UISegmentedControl *)segmented {
    
    
    [self assignmentXElementsWithSegmentType:segmented.selectedSegmentIndex +1];
}

//-(void)recordStatisticsItemWithItmeTypeIndex:(StatisticsType)itmeTypeIndex{
//    
//    switch (itmeTypeIndex) {
//        case StatisticsTypeH5Product: //作品
//            
//            if (!_statisticsItemH5) {
//                _statisticsItemH5 = [[RecordStatisticsItem alloc]init];
//                [self generalStatisticsDataToStatisticsDataItem:_statisticsItemH5];
//            }else if(_statisticsItemH5 && _currentItme){
//                
//                [self generalStatisticsDataToStatisticsDataItem:_statisticsItemH5];
//            }else {
//                
//                [self generalStatisticsDataWithItem:_statisticsItemH5];
//            }
//            break;
//        case StatisticsTypeHot://热点
//            
//            if (!_statisticsItemHot) {
//                _statisticsItemHot = [[RecordStatisticsItem alloc]init];
//                self.segmentedControl.selectedSegmentIndex = 0;
//                [self assignmentXElementsWithSegmentType:1];
//
//            } else if(_statisticsItemHot && _currentItme){
//                
//                [self generalStatisticsDataToStatisticsDataItem:_statisticsItemHot];
//            }else {
//                
//                [self generalStatisticsDataWithItem:_statisticsItemHot];
//            }
//            break;
//        case StatisticsTypeFuns://粉丝
//            
//            if (!_statisticsItemFuns) {
//              
//                _statisticsItemFuns = [[RecordStatisticsItem alloc]init];
//                [self assignmentXElementsWithSegmentType:1];
//                self.segmentedControl.selectedSegmentIndex = 0;
//
//            } else if(_statisticsItemFuns && _currentItme){
//                
//                [self generalStatisticsDataToStatisticsDataItem:_statisticsItemFuns];
//            } else {
//                
//                [self generalStatisticsDataWithItem:_statisticsItemFuns];
//            
//            }
//            break;
//        default:
//            break;
//    }
//    [_pXLineChartView reloadData];
//}

//-(void)generalStatisticsDataWithItem:(RecordStatisticsItem *)statisticsItem{
//    
//    self.lines = statisticsItem.lines;
//    self.xElements = statisticsItem.xElements;
//    self.yElements = statisticsItem.yElements;
//    self.segmentedControl.selectedSegmentIndex = statisticsItem.dayIndex;
//}
//
//-(void)generalStatisticsDataToStatisticsDataItem:(RecordStatisticsItem *)statisticsItem{
//    
//    statisticsItem.lines = self.lines;
//    statisticsItem.xElements = self.xElements;
//    statisticsItem.yElements = self.yElements;
//    statisticsItem.dayIndex = self.segmentedControl.selectedSegmentIndex;
//}

@end

//@implementation RecordStatisticsItem
//
//@end
