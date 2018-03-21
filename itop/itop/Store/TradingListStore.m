//
//  TradingListStore.m
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "TradingListStore.h"

@implementation TradingListStore

+ (instancetype)shearTradingListStore{
   
    static TradingListStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[TradingListStore alloc]init];
    });
    return store;
}

-(NSMutableArray *)configurationEarningListMenuWithUserInfo:(NSArray *)menu{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in menu) {
        
        EarningList * earning = [[ EarningList alloc]initWithDictionary:dic error:nil];
        [array addObject:earning];
    }
    return array;
}

-(NSMutableArray *)configurationEarningDetailMenuWithUserInfo:(EarningList *)earningList{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"入账i豆" content:earningList.reward_price]];
    [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"类型" content:@"转发"]];
    [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"商品" content:earningList.name]];
    [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"时间" content:earningList.create_datetime]];
    [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"交易单号" content:earningList.order_no]];
    
    NSString *channelLabel = [NSString string];
    switch ([earningList.reward_type integerValue]) {
        case 0:
            channelLabel = @"默认转发";
            break;
        case 1:
            channelLabel = @"微信转发";
            break;
        case 2:
            channelLabel = @"QQ转发";
            break;
        case 3:
            channelLabel = @"新浪微博转发";
            break;
            
        default:
            break;
    }
    [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"转发渠道" content:channelLabel]];
    return array;
}



-(Infomation *)setupLeaveDetailWithLeaveDetailTitle:(NSString *)title
                                            content:(NSString *)content{
    
    Infomation *info = [[Infomation alloc]init];
    info.title = title;
    info.content = content;
    return info;
}


@end
