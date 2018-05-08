//
//  BiddingProductListStore.m
//  itop
//
//  Created by huangli on 2018/4/27.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BiddingProductListStore.h"

@implementation BiddingProductListStore


+ (instancetype)shearBiddingProductListStore{
    
    static BiddingProductListStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[BiddingProductListStore alloc]init];
    });
    return store;
    
}

- (NSMutableArray *)configurationBiddingProductListWithRequsData:(NSArray *)arr{
    
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in arr) {
            
            BiddingProduct *custom = [[BiddingProduct alloc]initWithDictionary:dic error:nil];
            
            [array addObject:custom];
        }
        return array;
}

@end
