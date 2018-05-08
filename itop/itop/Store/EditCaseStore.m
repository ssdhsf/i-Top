//
//  EditCaseStore.m
//  itop
//
//  Created by huangli on 2018/5/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "EditCaseStore.h"

@implementation EditCaseStore

+ (instancetype)shearEditCaseStore{
    
    static EditCaseStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[EditCaseStore alloc]init];
    });
    return store;
}

- (NSMutableArray *)configurationEditCaseStoreWithRequsData:(NSArray *)arr{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
        
        EditCase *disputes = [[EditCase alloc]initWithDictionary:dic error:nil];
        
        [array addObject:disputes];
    }
    return array;
}

@end
