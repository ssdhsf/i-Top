//
//  TradingListStore.h
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradingListStore : NSObject

+ (instancetype)shearTradingListStore;

//解析交易记录数据
-(NSMutableArray *)configurationTradingListMenuWithUserInfo:(NSArray *)menu;

//解析收益记录数据
-(NSMutableArray *)configurationEarningListMenuWithUserInfo:(NSArray *)menu;

//解析收益记录详情
-(NSMutableArray *)configurationEarningDetailMenuWithUserInfo:(EarningList *)earningList;
@end
