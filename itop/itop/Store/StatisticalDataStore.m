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
    
    for (int i = 0; i < 3; i ++) {
       
        StatisticalData *stad = [[StatisticalData alloc]init];
        switch (i) {
            case 0:
                stad.title = @"浏览量";
                stad.content = @"1234";
                break;
            case 1:
                stad.title = @"使用量";
                stad.content = @"1234";
                break;
            case 2:
                stad.title = @"评论量";
                stad.content = @"1234";
                break;
                
            default:
                break;
        }
        
        [dataArray addObject:stad];
    }
    return dataArray;
}

@end
