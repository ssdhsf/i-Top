//
//  DisputesStore.m
//  itop
//
//  Created by huangli on 2018/5/3.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DisputesStore.h"

@implementation DisputesStore


+ (instancetype)shearDisputesStore{
    
    static DisputesStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[DisputesStore alloc]init];
    });
    return store;
}

- (NSMutableArray *)configurationDisputesWithRequsData:(NSArray *)arr{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
        
        Disputes *disputes = [[Disputes alloc]initWithDictionary:dic error:nil];
        
        [array addObject:disputes];
    }
    return array;
}
@end
