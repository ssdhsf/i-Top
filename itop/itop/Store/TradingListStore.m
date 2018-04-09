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

-(NSMutableArray *)configurationTradingListMenuWithUserInfo:(NSArray *)menu{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in menu) {
        
        TradingList * earning = [[ TradingList alloc]initWithDictionary:dic error:nil];
        [array addObject:earning];
    }
    return array;
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

-(NSMutableArray *)configurationTradingDetailMenuWithUserInfo:(TradingList *)tradingList{
    
    NSMutableArray *array = [NSMutableArray array];
    if ([tradingList.pay_scene integerValue] == 3) {
        
        [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"入账金额" content:tradingList.price]];
    }else {
        
        [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"出账金额" content:tradingList.price]];
    }
    
    NSString *pay_status = [NSString string];
    switch ([tradingList.pay_status integerValue]) {
        case 0:
            pay_status = @"未支付";
            break;
        case 1:
            pay_status = @"支付成功";
            break;
        case 2:
            pay_status = @"支付失败";
            break;
            
        default:
            break;
    }
    [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"状态" content:pay_status]];
    
    NSString *pay_scene = [NSString string];
    switch ([tradingList.pay_scene integerValue]) {
        case 0:
            pay_scene = @"未知";
            break;
        case 1:
            pay_scene = @"文章支付";
            break;
        case 2:
            pay_scene = @"作品支付";
            break;
        case 3:
            pay_scene = @"充值";
            break;
        case 4:
            pay_scene = @"企业服务";
            break;
            
        default:
            break;
    }
    
    [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"类型" content:pay_scene]];
    [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"商品" content:tradingList.message]];//TODO
    [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"时间" content:tradingList.create_datetime]];
    [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"交易单号" content:tradingList.order_no]];
    [array addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"账户余额" content:tradingList.order_no]]; //TODO
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
