//
//  MarketingStore.m
//  itop
//
//  Created by huangli on 2018/2/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MarketingStore.h"

@implementation MarketingStore

+ (instancetype)shearMarketingStore{
    
    static MarketingStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[MarketingStore alloc]init];
    });
    return store;

}

- (NSArray *)configurationMenuWithShowIndex:(NSInteger )index{
    
    Marketing *markting = [[Marketing alloc]init];
    markting.title = [NSString stringWithFormat:@"渠道名称%ld",(long)index];
    markting.placeholder = [NSString stringWithFormat:@"请输入渠道名称%ld",(long)index];
    
    Marketing *markting1 = [[Marketing alloc]init];
    markting1.title = [NSString stringWithFormat:@"粉丝数量%ld",(long)index];
    markting1.placeholder = [NSString stringWithFormat:@"请输入粉丝数量%ld",(long)index];
    
    Marketing *markting2 = [[Marketing alloc]init];
    markting2.title = [NSString stringWithFormat:@"主页链接%ld",(long)index];
    markting2.placeholder = [NSString stringWithFormat:@"请输主页链接%ld",(long)index];
    NSArray *array = @[markting,markting1,markting2];
    
    return array;
}


@end
