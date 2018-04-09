//
//  StatisticalDataViewController.h
//  itop
//
//  Created by huangli on 2018/1/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController.h"

@class RecordStatisticsItem;

@interface StatisticalDataViewController : BaseViewController

@property (assign,nonatomic)StatisticsType statisticsType;

@end

//@interface RecordStatisticsItem : NSObject
//
////@property (nonatomic, assign) StatisticsType statisticsType;
//@property (nonatomic, assign) NSInteger dayIndex;
//@property (nonatomic, strong) NSMutableArray *lines;//line count
//@property (nonatomic, strong) NSMutableArray *xElements;//x轴数据
//@property (nonatomic, strong) NSMutableArray *yElements;//y轴数据
//
//@end
