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

- (NSMutableArray *)configurationStatisticalDataWithUserType:(UserType )user_type itmeType:(StatisticalItmeType)itme_type{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    switch (user_type) {
        case UserTypeDesigner:
            
            break;
            
        default:
            break;
    }
    
    
    return dataArray;
}

-(NSArray *)configurationStatisticalItmeDataTitleWithUserType:(UserType )user_type itmeType:(StatisticsType)itme_type{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    switch (itme_type) {
        case StatisticsTypeH5Product:
            
            [dataArray addObject: [self statisticalModelWithTitle:@"使用量" markColor:UIColorFromRGB(0x90e0ff)]];
            [dataArray addObject:[self statisticalModelWithTitle:@"作品" markColor:UIColorFromRGB(0xfd91bd)]];
            [dataArray addObject:[self statisticalModelWithTitle:@"浏览量" markColor:UIColorFromRGB(0xffc58c)]];
            [dataArray addObject:[self statisticalModelWithTitle:@"粉丝使用量" markColor:UIColorFromRGB(0xffa0a0)]];
            [dataArray addObject:[self statisticalModelWithTitle:@"推荐量" markColor:UIColorFromRGB(0xacbbfc)]];
            [dataArray addObject: [self statisticalModelWithTitle:@"评论量" markColor:UIColorFromRGB(0x7ee794)]];
//            return @[@"使用量",@"作品量",@"浏览量",@"粉丝使用量",@"推荐量",@"评论量"];
            break;
        case StatisticsTypeHot:
            
            [dataArray addObject:[self statisticalModelWithTitle:@"发布量" markColor:UIColorFromRGB(0xfd91bd)]];
            [dataArray addObject: [self statisticalModelWithTitle:@"推荐量" markColor:UIColorFromRGB(0x90e0ff)]];
            [dataArray addObject:[self statisticalModelWithTitle:@"浏览量" markColor:UIColorFromRGB(0xffc58c)]];
            [dataArray addObject:[self statisticalModelWithTitle:@"粉丝阅读量" markColor:UIColorFromRGB(0xffa0a0)]];
            [dataArray addObject: [self statisticalModelWithTitle:@"评论量" markColor:UIColorFromRGB(0x7ee794)]];
            [dataArray addObject:[self statisticalModelWithTitle:@"跳出率" markColor:UIColorFromRGB(0xacbbfc)]];
//            return @[@"推荐量",@"发布量",@"浏览量",@"粉丝阅读量",@"跳出率",@"评论量"];
            break;
        case StatisticsTypeFuns:
            
            [dataArray addObject: [self statisticalModelWithTitle:@"粉丝总量" markColor:UIColorFromRGB(0x90e0ff)]];
            [dataArray addObject:[self statisticalModelWithTitle:@"新增粉丝" markColor:UIColorFromRGB(0xfd91bd)]];
            [dataArray addObject:[self statisticalModelWithTitle:@"取消关注" markColor:UIColorFromRGB(0xffc58c)]];
            [dataArray addObject:[self statisticalModelWithTitle:@"我关注" markColor:UIColorFromRGB(0xffa0a0)]];
//            [dataArray addObject:[self statisticalModelWithTitle:@"跳出率" markColor:UIColorFromRGB(0xacbbfc)]];
//            [dataArray addObject: [self statisticalModelWithTitle:@"评论量" markColor:UIColorFromRGB(0x7ee794)]];
//            return @[@"推荐量",@"发布量",@"浏览量",@"粉丝阅读量",@"跳出率",@"评论量"];
            break;

        case StatisticsTypePop:
            
            [dataArray addObject:[self statisticalModelWithTitle:@"浏览量" markColor:UIColorFromRGB(0xfd91bd)]];
            [dataArray addObject: [self statisticalModelWithTitle:@"转发量" markColor:UIColorFromRGB(0x90e0ff)]];
            [dataArray addObject: [self statisticalModelWithTitle:@"评论量" markColor:UIColorFromRGB(0x7ee794)]];
            
            if (user_type == UserTypeMarketing) {
                
                 [dataArray addObject:[self statisticalModelWithTitle:@"收益" markColor:UIColorFromRGB(0xacbbfc)]];
            } else{
                
                 [dataArray addObject:[self statisticalModelWithTitle:@"消费" markColor:UIColorFromRGB(0xacbbfc)]];
            }
           
//            return @[@"使用量",@"发布量",@"浏览量",@"粉丝阅读量",@"推荐量",@"评论量"];
            
            break;
        default:
            break;
    }
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

-(StatisticalDataModel *)statisticalModelWithTitle:(NSString *)title
                                            markColor:(UIColor *)color{
    
    StatisticalDataModel *statistical = [[StatisticalDataModel alloc]init];
    statistical.title = title;
    statistical.markColor = color;
    return statistical;
}

@end
