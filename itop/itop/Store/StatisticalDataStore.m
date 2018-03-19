//
//  StatisticalDataStore.m
//  itop
//
//  Created by huangli on 2018/1/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "StatisticalDataStore.h"
#import "PointItem.h"
@implementation StatisticalDataStore

+ (instancetype)shearStatisticalDataStore{
    
    static StatisticalDataStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[StatisticalDataStore alloc]init];
    });
    return store;
}

- (NSMutableArray *)configurationStatisticalDataWithData:(NSArray *)statisticalData{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    return dataArray;
}

-(NSMutableArray *)itmeDataModelWithDictionarys:(NSArray *)Dictionarys
                                     ThemeColor:(UIColor *)ThemeColor{
    
    NSMutableArray *itmes = [NSMutableArray array];
    for (NSDictionary *date in Dictionarys) {//评论量
        NSString *day = [[Global sharedSingleton]timeFormatTotimeStringFormatWithtime:date[@"date"] willPattern:TIME_PATTERN_second didPattern:TIME_PATTERN_month_day];
        NSDictionary *dic = @{@"xValue" : day, @"yValue" : [NSString stringWithFormat:@"%@",date[@"count"]] };
        PointItem *item = [[PointItem alloc] init];
        item.price = dic[@"yValue"];
        item.time = dic[@"xValue"];
        item.chartLineColor = ThemeColor;
        item.chartPointColor = ThemeColor;
        item.pointValueColor = ThemeColor;
//        if (fill) {
        item.chartFillColor = [UIColor colorWithRed:0.5 green:0.1 blue:0.8 alpha:0.5];
            item.chartFill = YES;
//        }
        [itmes addObject:item];
    }
    return itmes;
}

-(NSArray *)coordinatesYElementsPiecewiseWithMaxCount:(NSInteger)maxCount{
    
    NSArray *yElements = [NSArray array];
    if (maxCount < 10) {
        
        yElements = @[@"0",@"2",@"4",@"6",@"8",@"10"];
    } else if (maxCount > 10 && maxCount < 100){
        
        yElements = @[@"0",@"20",@"40",@"60",@"80",@"100"];
        
    } else if (maxCount > 100 && maxCount < 1000){
        
        yElements = @[@"0",@"200",@"400",@"600",@"800",@"1000"];
    }
    else if (maxCount > 1000 && maxCount < 10000){
        
        yElements  = @[@"0",@"2000",@"4000",@"6000",@"8000",@"10000"];
    }
    return yElements;
}


@end
