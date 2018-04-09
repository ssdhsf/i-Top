//
//  PopularizeStore.m
//  itop
//
//  Created by huangli on 2018/3/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "PopularizeStore.h"

@implementation PopularizeStore

+ (instancetype)shearPopularizeStore{
    
    static PopularizeStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[PopularizeStore alloc]init];
    });
    return store;
}

-(NSMutableArray *)configurationPopularizeWithMenu:(NSArray *)arr{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
       
        Popularize *pop = [[Popularize alloc]initWithDictionary:dic error:nil];
        [array addObject:pop];
    }
       return array;
}

@end
