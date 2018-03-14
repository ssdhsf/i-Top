//
//  StatisticalDataViewController.m
//  itop
//
//  Created by huangli on 2018/1/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "StatisticalDataViewController.h"
#import "StatisticalDataStore.h"
#import "StatisticalDataDataSource.h"
#import "StatisticalDataCell.h"
#import "PXLineChartView.h"
#import "PointItem.h"
#import "SegmentTapView.h"
//#import "SNChart.h"
//#import "Charts-Swift.h"
//#import "itop-Bridging-Header.h"

static bool fill = NO;

static NSString *StatisticalDataIdentifier = @"StatisticalData";

@interface StatisticalDataViewController ()<PXLineChartViewDelegate,SegmentTapViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong)StatisticalDataDataSource *statisticalDataDataSource;
@property (nonatomic, strong)StatisticalDataStore *statisticalDataStore;

@property (nonatomic, strong) SegmentTapView *segment;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, weak) IBOutlet PXLineChartView *pXLineChartView;
@property (weak, nonatomic) IBOutlet UILabel *useCountLabel;
@property (weak, nonatomic) IBOutlet UIView *useCountView;

@property (weak, nonatomic) IBOutlet UIView *browseCountView;
@property (weak, nonatomic) IBOutlet UILabel *browseCountLabel;

@property (weak, nonatomic) IBOutlet UIView *funsCountView;
@property (weak, nonatomic) IBOutlet UILabel *funsCountLabel;

@property (weak, nonatomic) IBOutlet UIView *productCountView;
@property (weak, nonatomic) IBOutlet UILabel *productCountLabel;
@property (weak, nonatomic) IBOutlet UIView *commentsCountView;
@property (weak, nonatomic) IBOutlet UILabel *commentsCountLabel;

@property (weak, nonatomic) IBOutlet UIView *recommendedCountView;
@property (weak, nonatomic) IBOutlet UILabel *recommendedCountLabel;

@property (nonatomic, strong) NSArray *lines;//line count
@property (nonatomic, strong) NSMutableArray *xElements;//x轴数据
@property (nonatomic, strong) NSMutableArray *yElements;//y轴数据
//@property (strong, nonatomic)SNChart * chart;
@property (nonatomic,strong) UILabel * markY;


@property (nonatomic, strong)NSArray *dayArray;
@property (nonatomic, strong)NSArray *countArray1;
@property (nonatomic, strong)NSArray *countArray2;

@end

@implementation StatisticalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    [super initView];
    
    NSLog(@"%ld",(long)ScreenWidth);
    [self initSegment];
    [self initDateSegmentControl];
    [self initPXLineChartView];
    [self setupCountView];
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
    _xElements = [NSMutableArray array];
    _yElements = [NSMutableArray array];
    _dayArray = @[@"2-20",@"2-21",@"2-22",@"2-23",@"2-24",@"2-25",@"2-26",@"2-27",@"2-28",@"3-1",@"3-2",@"3-3",@"3-4",@"3-5",@"3-6",@"3-7",@"3-8",@"3-9",@"3-10",@"3-11",@"3-12",@"3-13",@"3-14",@"3-15",@"3-16",@"3-17",@"3-18",@"3-19",@"3-20",@"3-21"];
    
    _countArray1 = @[@{@"xValue" : @"2-20", @"yValue" : @"1000"},
                    @{@"xValue" : @"2-21", @"yValue" : @"2000"},
                    @{@"xValue" : @"2-22", @"yValue" : @"2800"},
                    @{@"xValue" : @"2-23", @"yValue" : @"1700"},
                    @{@"xValue" : @"3-1", @"yValue" : @"3100"},
                    @{@"xValue" : @"3-3", @"yValue" : @"3500"},
                    @{@"xValue" : @"3-5", @"yValue" : @"3400"},
                    @{@"xValue" : @"3-6", @"yValue" : @"1100"},
                    @{@"xValue" : @"3-9", @"yValue" : @"1100"},
                    @{@"xValue" : @"3-13", @"yValue" : @"1100"},
                    @{@"xValue" : @"3-15", @"yValue" : @"4100"},
                    @{@"xValue" : @"3-16", @"yValue" : @"1700"},
                    @{@"xValue" : @"3-17", @"yValue" : @"3100"},
                    @{@"xValue" : @"3-19", @"yValue" : @"1500"}];
    
    _countArray2 = @[@{@"xValue" : @"2-21", @"yValue" : @"2000"},
                     @{@"xValue" : @"2-24", @"yValue" : @"2200"},
                     @{@"xValue" : @"2-26", @"yValue" : @"2200"},
                     @{@"xValue" : @"2-27", @"yValue" : @"2200"},
                     @{@"xValue" : @"3-1", @"yValue" : @"2200"},
                     @{@"xValue" : @"3-3", @"yValue" : @"1900"},
                     @{@"xValue" : @"3-5", @"yValue" : @"2200"},
                     @{@"xValue" : @"3-6", @"yValue" : @"3400"},
                     @{@"xValue" : @"3-9", @"yValue" : @"3000"},
                     @{@"xValue" : @"3-10", @"yValue" : @"3750"},
                     @{@"xValue" : @"3-14", @"yValue" : @"3800"},
                     @{@"xValue" : @"3-15", @"yValue" : @"3200"},
                     @{@"xValue" : @"3-16", @"yValue" : @"4300"},
                     @{@"xValue" : @"3-19", @"yValue" : @"6000"},
                     @{@"xValue" : @"3-20", @"yValue" : @"2000"}];

}

-(void)initSegment{
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"H5作品",@"热点",@"粉丝", nil];
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(30, 19, ScreenWidth/2, 30) withDataArray:titleArray withFont:15];
    self.segment.delegate = self;
    self.segment.lineImageView.hidden = YES;
    self.segment.textNomalColor = [UIColor blackColor];
    self.segment.textSelectedColor = UIColorFromRGB(0xf9a5ee);
    self.segment.titleFont = 15;
    [self.view addSubview:self.segment];
}

-(void)initDateSegmentControl{
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"7天",@"14天",@"30天", nil];
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:titleArray];
    _segmentedControl.frame = CGRectMake(ScreenWidth/2-180/2,CGRectGetMaxY(self.segment.frame)+40, 180, 30);
    _segmentedControl.tintColor = UIColorFromRGB(0xe0e3e6);
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    [self.segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
}

-(void)setupCountView{
    
    _productCountView.layer.cornerRadius = _productCountView.width/2;
    _useCountView.layer.cornerRadius = _useCountView.width/2;
    _browseCountView.layer.cornerRadius = _browseCountView.width/2;
    _funsCountView.layer.cornerRadius = _funsCountView.width/2;
    _recommendedCountView.layer.cornerRadius = _recommendedCountView.width/2;
    _commentsCountView.layer.cornerRadius = _commentsCountView.width/2;
}

-(void)initPXLineChartView{
    
    _pXLineChartView.delegate = self;
    [_xElements addObjectsFromArray:[_dayArray  subarrayWithRange:NSMakeRange(_dayArray.count-7, 7)]];
    [_yElements  addObjectsFromArray: @[@"0",@"2000",@"4000",@"6000",@"8000",@"10000"]];
//    [self assignmentXElementsWithSegmentType:1];
//    [self assignmentYElementsWithSegmentTypeData:nil];
    self.lines = [self lines:NO];
}

//获取访问全部的访问日期
-(void)assignmentXElementsWithSegmentType:(NSInteger )index{
    
    NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd"];
    NSInteger currentTime = [date timeIntervalSince1970];
    for (int i = 0; i < index *7; i++) {
        
        NSInteger dayTime = (long)24*60*60*(i+1);
        NSString *day =  [NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:currentTime - dayTime]]];
        [_xElements addObject:day];
        NSLog(@"%@",day);
    }
}

//获取访问数值的最大数然后划分
-(void)assignmentYElementsWithSegmentTypeData:(NSArray *)TypeData{
    
    [_yElements addObjectsFromArray: @[@"0",@"500",@"1000",@"1500",@"2100",@"3300",@"5000"]];
}

//获取不同类型的最大数据  然后根据用户选择截取
-(NSMutableArray *)geMonthDataWithMonthData:(NSArray *)monthData{
    
    return nil;
}

#pragma mark --- scrollView delegate
#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index{
    
    //选中 type 日期
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 81;
}

- (NSArray *)lines:(BOOL)fill {
    
    NSMutableArray *pointsArr = [NSMutableArray array];
    NSMutableArray *pointsArr1 = [NSMutableArray array];
    
    
    for (NSString *date in _xElements) {
        
        for (NSDictionary *dic in _countArray1) {
            
            if ([date isEqualToString:dic[@"xValue"]]) {
               
                [pointsArr addObject:dic];
            }
        }
        
    }
    
    for (NSString *date in _xElements) {
        
        for (NSDictionary *dic in _countArray2) {
            
            if ([date isEqualToString:dic[@"xValue"]]) {
                
                [pointsArr1 addObject:dic];
            }
        }
    }
    
    NSMutableArray *points = @[].mutableCopy;
    for (int i = 0; i < pointsArr.count; i++) {
        PointItem *item = [[PointItem alloc] init];
        NSDictionary *itemDic = pointsArr[i];
        item.price = itemDic[@"yValue"];
        item.time = itemDic[@"xValue"];
        item.chartLineColor = UIColorFromRGB(0x90e0ff);
        item.chartPointColor = UIColorFromRGB(0x90e0ff);
        item.pointValueColor = UIColorFromRGB(0x90e0ff);
        if (fill) {
            item.chartFillColor = [UIColor colorWithRed:0 green:0.5 blue:0.2 alpha:0.5];
            item.chartFill = YES;
        }
        [points addObject:item];
    }
    
    NSMutableArray *pointss = @[].mutableCopy;
    for (int i = 0; i < pointsArr1.count; i++) {
        PointItem *item = [[PointItem alloc] init];
        NSDictionary *itemDic = pointsArr1[i];
        item.price = itemDic[@"yValue"];
        item.time = itemDic[@"xValue"];
        item.chartLineColor = UIColorFromRGB(0xffc58c);
        item.chartPointColor = UIColorFromRGB(0xffc58c);
        item.pointValueColor = UIColorFromRGB(0xffc58c);
        if (fill) {
            item.chartFillColor = [UIColor colorWithRed:0.5 green:0.1 blue:0.8 alpha:0.5];
            item.chartFill = YES;
        }
        [pointss addObject:item];
    }
    //两条line
    return @[pointss,points];
}

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
    
    [_xElements removeAllObjects];
    
    if (segmented.selectedSegmentIndex >1) {
        
        [_xElements addObjectsFromArray:_dayArray];
        
    } else {
        
        [_xElements addObjectsFromArray:[_dayArray  subarrayWithRange:NSMakeRange(_dayArray.count-((segmented.selectedSegmentIndex+1)*7), (segmented.selectedSegmentIndex+1)*7)]];
        
    }
    
    self.lines = [self lines:fill];
    [_pXLineChartView reloadData];
}


@end
