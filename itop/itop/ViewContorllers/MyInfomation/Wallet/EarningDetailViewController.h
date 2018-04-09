//
//  EarningDetailViewController.h
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

typedef NS_ENUM(NSInteger, DetailType) { //作品审核状态
    DetailTypeEarningList = 0, //收益详情
    DetailTypeTradingList = 1,//交易详情
};


#import "BaseTableViewController.h"

@interface EarningDetailViewController : BaseTableViewController

@property (strong, nonatomic)EarningList *earningList;
@property (strong, nonatomic)TradingList *tradingList;
@property (assign, nonatomic)DetailType detailType;

@end
