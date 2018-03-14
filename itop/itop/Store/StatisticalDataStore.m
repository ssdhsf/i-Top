//
//  StatisticalDataStore.m
//  itop
//
//  Created by huangli on 2018/1/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "StatisticalDataStore.h"

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

@end
